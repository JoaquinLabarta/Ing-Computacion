#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "comandos.h"
#include "uart.h"
#include "control_rgb.h"

static uint8_t es_digito (char c);
static void quitar_espacios (char *texto);
static uint8_t leer_componente (const char **texto, uint8_t *valor);
static uint8_t parsear_color (const char *texto, uint8_t *rojo, uint8_t *verde, uint8_t *azul);
static void procesar_comando_linea (char *linea);

// Devuelve 1 si el caracter recibido representa un digito decimal
static uint8_t es_digito (char c) {
    return (uint8_t)((c >= '0') && (c <= '9'));
}

// Elimina espacios y tabulaciones para aceptar SET_COLOR=... y SET_COLOR = ...
static void quitar_espacios (char *texto) {
    uint8_t lectura = 0;
    uint8_t escritura = 0;

    while (texto[lectura] != '\0') {
        if ((texto[lectura] != ' ') && (texto[lectura] != '\t')) {
            texto[escritura] = texto[lectura];
            escritura++;
        }

        lectura++;
    }

    texto[escritura] = '\0';
}

// Lee una componente decimal y comprueba que pertenezca al rango 0 a 255
static uint8_t leer_componente (const char **texto, uint8_t *valor) {
    uint16_t acumulado = 0;
    uint8_t cantidad = 0;

    while (es_digito(**texto)) {
        acumulado = (uint16_t)(acumulado * 10U + (**texto - '0'));
        cantidad++;

        if (acumulado > 255U) {
            return 0;
        }

        (*texto)++;
    }

    if (cantidad == 0) {
        return 0;
    }

    *valor = (uint8_t)acumulado;
    return 1;
}

// Valida el formato exacto SET_COLOR=R,G,B luego de haber eliminado los espacios
static uint8_t parsear_color (const char *texto, uint8_t *rojo, uint8_t *verde, uint8_t *azul) {
    const char *cursor;

    if (strncmp(texto, "SET_COLOR=", 10) != 0) {
        return 0;
    }

    cursor = &texto[10];

    if (!leer_componente(&cursor, rojo) || (*cursor != ',')) {
        return 0;
    }
    cursor++;

    if (!leer_componente(&cursor, verde) || (*cursor != ',')) {
        return 0;
    }
    cursor++;

    if (!leer_componente(&cursor, azul) || (*cursor != '\0')) {
        return 0;
    }

    return 1;
}

// Procesa una linea completa y actualiza el color o informa el error por terminal
static void procesar_comando_linea (char *linea) {
    uint8_t rojo;
    uint8_t verde;
    uint8_t azul;
    char mensaje[72];

    quitar_espacios(linea);

    if (strncmp(linea, "SET_COLOR=", 10) == 0) {
        if (!parsear_color(linea, &rojo, &verde, &azul)) {
            uart_enviar_cadena("[CMD_ERROR] Use SET_COLOR=R,G,B con valores de 0 a 255\r\n");
            return;
        }

        control_rgb_establecer_color(rojo, verde, azul);

        snprintf(mensaje, sizeof(mensaje),
                 "[CMD_OK] Color actualizado: R=%u | G=%u | B=%u\r\n",
                 rojo, verde, azul);
        uart_enviar_cadena(mensaje);
        return;
    }

    uart_enviar_cadena("[CMD_ERROR] Comando no reconocido\r\n");
}

// Arma lineas hasta ENTER y deja el procesamiento completo fuera de la ISR de recepcion
void procesar_comandos_uart (void) {
    static char linea[COMANDO_TAM];
    static uint8_t indice = 0;
    char dato;

    if (uart_rx_desborde) {
        uart_rx_desborde = 0;
        indice = 0;
        uart_enviar_cadena("[CMD_ERROR] Desborde de buffer UART RX\r\n");
    }

    if (uart_rx_error_trama) {
        uart_rx_error_trama = 0;
        indice = 0;
        uart_enviar_cadena("[CMD_ERROR] Error de trama UART\r\n");
    }

    while (uart_leer_caracter(&dato)) {
        if ((dato == '\r') || (dato == '\n')) {
            if (indice > 0) {
                linea[indice] = '\0';
                procesar_comando_linea(linea);
                indice = 0;
            }
        }
        else {
            if (indice < (COMANDO_TAM - 1)) {
                linea[indice] = dato;
                indice++;
            }
            else {
                indice = 0;
                uart_enviar_cadena("[CMD_ERROR] Comando demasiado largo\r\n");
            }
        }
    }
}
