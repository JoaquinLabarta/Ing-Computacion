#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "monitor.h"
#include "uart.h"
#include "rtc.h"
#include "dht.h"

uint8_t intervalo_reporte_s = TM_INICIAL_SEGUNDOS;   // Tasa de muestreo configurable por comando SET_TM
uint8_t contador_reporte_s = 0;   // Cuenta segundos hasta generar un mensaje
uint8_t contador_tramas_alerta = 0;   // Cuenta tramas para emitir alarma

// Pertenece a monitor.c.
// Determina si la hora del RTC corresponde a la ventana diurna definida por el enunciado: 07:00 a 18:59
uint8_t es_horario_diurno (const tiempo_t *tiempo) {
    if (!tiempo->valido) {return 0;}

    return (uint8_t)((tiempo->hora >= DIA_HORA_INICIO) && (tiempo->hora <= DIA_HORA_FIN));
}

// Pertenece a monitor.c.
// Evalua si temperatura y humedad estan dentro de rango segun la hora.
// Si el RTC o el DHT11 fallan, el estado se considera ALERTA
estado_monitor_t evaluar_estado (const tiempo_t *tiempo, const lectura_ambiente_t *lectura) {
    uint8_t temp_min;
    uint8_t temp_max;
    uint8_t hum_min;
    uint8_t hum_max;

    if (!tiempo->valido || !lectura->valido) {
        return ESTADO_ALERTA;
    }

    if (es_horario_diurno(tiempo)) {
        temp_min = TEMP_DIA_MIN;
        temp_max = TEMP_DIA_MAX;
        hum_min = HUM_DIA_MIN;
        hum_max = HUM_DIA_MAX;
    }
    else {
        temp_min = TEMP_NOCHE_MIN;
        temp_max = TEMP_NOCHE_MAX;
        hum_min = HUM_NOCHE_MIN;
        hum_max = HUM_NOCHE_MAX;
    }

    if ((lectura->temperatura < temp_min) || (lectura->temperatura > temp_max)) {return ESTADO_ALERTA;}

    if ((lectura->humedad < hum_min) || (lectura->humedad > hum_max)) {return ESTADO_ALERTA;}

    return ESTADO_NORMAL;
}

// Pertenece a monitor.c.
// Genera el texto HH:MM:SS si el RTC es valido. Si no lo es, usa una marca visible para indicar que no se pudo leer la hora
void formatear_hora (const tiempo_t *tiempo, char *salida) {
    if (tiempo->valido) {
        snprintf(salida, 9, "%02u:%02u:%02u", tiempo->hora, tiempo->minuto, tiempo->segundo);
    }
    else {
        strcpy(salida, "??:??:??");
    }
}

// Pertenece a monitor.c.
// Emite una trama normal de telemetr�a con hora, temperatura, humedad y estado general del monitor
void emitir_telemetria (const tiempo_t *tiempo, const lectura_ambiente_t *lectura, estado_monitor_t estado){
    char hora_texto[9];
    char mensaje[80];

    formatear_hora(tiempo, hora_texto);

    if (lectura->valido) {
        snprintf(mensaje, sizeof(mensaje),
                 "[%s] T: %02d\xB0""C | H: %02u%% | Estado: %s\r\n",
                 hora_texto,
                 lectura->temperatura,
                 lectura->humedad,
                 (estado == ESTADO_NORMAL) ? "NORMAL" : "ALERTA");
    }
    else {
        snprintf(mensaje, sizeof(mensaje),
                 "[%s] T: --\xB0""C | H: --%% | Estado: ALERTA\r\n",
                 hora_texto);
    }

    uart_enviar_cadena(mensaje);
}

// Pertenece a monitor.c.
//Emite mensajes de emergencia para cada anomalia detectada; se llama solo cada dos tramas de telemetria cuando el estado general ests en alerta
void emitir_alarmas(const tiempo_t *tiempo, const lectura_ambiente_t *lectura) {
    char hora_texto[9];
    char mensaje[96];
    uint8_t diurno;

    formatear_hora(tiempo, hora_texto);

    if (!tiempo->valido) {
        snprintf(mensaje, sizeof(mensaje),
                 "[ALERTA] [%s] RTC no disponible o hora invalida!\r\n",
                 hora_texto);
        uart_enviar_cadena(mensaje);
        return;
    }

    if (!lectura->valido) {
        snprintf(mensaje, sizeof(mensaje),
                 "[ALERTA] [%s] Sensor DHT11 no disponible!\r\n",
                 hora_texto);
        uart_enviar_cadena(mensaje);
        return;
    }

    diurno = es_horario_diurno(tiempo);

    if (diurno) {
        if ((lectura->temperatura < TEMP_DIA_MIN) || (lectura->temperatura > TEMP_DIA_MAX)) {
            snprintf(mensaje, sizeof(mensaje),
                     "[ALERTA] [%s] Temperatura fuera de rango diurno! Valor: %d\xB0""C\r\n",
                     hora_texto,
                     lectura->temperatura);
            uart_enviar_cadena(mensaje);
        }

        if ((lectura->humedad < HUM_DIA_MIN) || (lectura->humedad > HUM_DIA_MAX)) {
            snprintf(mensaje, sizeof(mensaje),
                     "[ALERTA] [%s] Humedad fuera de rango diurno! Valor: %u%%\r\n",
                     hora_texto,
                     lectura->humedad);
            uart_enviar_cadena(mensaje);
        }
    }
    else {
        if ((lectura->temperatura < TEMP_NOCHE_MIN) || (lectura->temperatura > TEMP_NOCHE_MAX)) {
            snprintf(mensaje, sizeof(mensaje),
                     "[ALERTA] [%s] Temperatura fuera de rango nocturno! Valor: %d\xB0""C\r\n",
                     hora_texto,
                     lectura->temperatura);
            uart_enviar_cadena(mensaje);
        }

        if ((lectura->humedad < HUM_NOCHE_MIN) || (lectura->humedad > HUM_NOCHE_MAX)) {
            snprintf(mensaje, sizeof(mensaje),
                     "[ALERTA] [%s] Humedad fuera de rango nocturno! Valor: %u%%\r\n",
                     hora_texto,
                     lectura->humedad);
            uart_enviar_cadena(mensaje);
        }
    }
}

// Pertenece a monitor.c.
// Lee RTC y DHT11, evalua rangos y envia telemetria; si hay alerta, genera una alarma de emergencia cada dos tramas
void tarea_emitir_reporte (void) {
    tiempo_t tiempo;
    lectura_ambiente_t lectura;
    estado_monitor_t estado;

    rtc_leer_hora(&tiempo);
    dht_leer(&lectura);

    estado = evaluar_estado(&tiempo, &lectura);

    emitir_telemetria(&tiempo, &lectura, estado);

    if (estado == ESTADO_ALERTA){
        contador_tramas_alerta++;

        if (contador_tramas_alerta >= CANT_ALERTA) {
            contador_tramas_alerta = 0;
            emitir_alarmas(&tiempo, &lectura);
        }
    }
    else {
        contador_tramas_alerta = 0;
    }
}
