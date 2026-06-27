#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "comandos.h"
#include "uart.h"
#include "rtc.h"
#include "monitor.h"

// Pertenece a comandos.c.
// Devuelve 1 si el caracter recibido es un digito decimal ASCII
uint8_t es_digito (char c) {
    return (uint8_t)((c >= '0') && (c <= '9'));
}

// Pertenece a comandos.c.
// Convierte una cadena decimal positiva de hasta dos digitos a uint8_t. Se usa para SET_TM
uint8_t convertir_numero (const char *texto, uint8_t *valor) {
    uint16_t acumulado = 0;
    uint8_t cantidad = 0;

    while (*texto != '\0') {
        if (!es_digito(*texto)) {return 0;}

        acumulado = (uint16_t)(acumulado * 10 + (*texto - '0'));
        cantidad++;

        if (acumulado > 255) {return 0;}

        texto++;
    }

    if (cantidad == 0) {return 0;}

    *valor = (uint8_t)acumulado;
    return 1;
}

// Pertenece a comandos.c.
// Valida y extrae una hora con formato exacto HH:MM:SS para el comando SET_TIME
uint8_t parsear_hora (const char *texto, uint8_t *hora, uint8_t *minuto, uint8_t *segundo) {
    uint8_t h;
    uint8_t m;
    uint8_t s;

    if (strlen(texto) != 8) {return 0;}

    if (!es_digito(texto[0]) || !es_digito(texto[1]) || texto[2] != ':' ||
        !es_digito(texto[3]) || !es_digito(texto[4]) || texto[5] != ':' ||
        !es_digito(texto[6]) || !es_digito(texto[7])) {
        return 0;
    }

    h = (uint8_t)((texto[0] - '0') * 10 + (texto[1] - '0'));
    m = (uint8_t)((texto[3] - '0') * 10 + (texto[4] - '0'));
    s = (uint8_t)((texto[6] - '0') * 10 + (texto[7] - '0'));

    if ((h > 23) || (m > 59) || (s > 59)) {return 0;}

    *hora = h;
    *minuto = m;
    *segundo = s;

    return 1;
}

// Pertenece a comandos.c.
// Procesa una linea completa recibida desde UART y ejecuta SET_TIME o SET_TM, informando errores por terminal
void procesar_comando_linea (char *linea) {
    uint8_t hora;
    uint8_t minuto;
    uint8_t segundo;
    uint8_t nuevo_intervalo;

    if (strncmp(linea, "SET_TIME=", 9) == 0) {
        if (!parsear_hora(&linea[9], &hora, &minuto, &segundo)) {
            uart_enviar_cadena("[CMD_ERROR] Formato invalido. Use SET_TIME=HH:MM:SS\r\n");
            return;
        }

        if (rtc_escribir_hora(hora, minuto, segundo)) {
            uart_enviar_cadena("[CMD_OK] Hora actualizada\r\n");
        }
        else {
            uart_enviar_cadena("[CMD_ERROR] No se pudo actualizar el RTC\r\n");
        }

        return;
    }

    if (strncmp(linea, "SET_TM=", 7) == 0) {
        if (!convertir_numero(&linea[7], &nuevo_intervalo)) {
            uart_enviar_cadena("[CMD_ERROR] Formato invalido. Use SET_TM=SS\r\n");
            return;
        }

        if ((nuevo_intervalo < TM_MIN_SEGUNDOS) || (nuevo_intervalo > TM_MAX_SEGUNDOS)) {
            uart_enviar_cadena("[CMD_ERROR] SET_TM fuera de rango. Use 2 a 60 segundos\r\n");
            return;
        }

        intervalo_reporte_s = nuevo_intervalo;
        contador_reporte_s = 0;

        uart_enviar_cadena("[CMD_OK] Intervalo de reporte actualizado\r\n");
        return;
    }

    uart_enviar_cadena("[CMD_ERROR] Comando no reconocido\r\n");
}

// Pertenece a comandos.c.
// Toma caracteres del buffer RX, arma lineas hasta ENTER y las entrega al parser sin bloquear el lazo principal
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
