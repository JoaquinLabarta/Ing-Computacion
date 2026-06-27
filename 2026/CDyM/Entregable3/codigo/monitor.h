#ifndef MONITOR_H
#define MONITOR_H

#include <stdint.h>
#include "rtc.h"
#include "dht.h"

#define TM_INICIAL_SEGUNDOS 5   // Tasa inicial de reporte si no se envia SET_TM
#define CANT_ALERTA 2   // Cantidad de tramas entre alertas

#define DIA_HORA_INICIO 7   // Inicio de ventana diurna: 07:00
#define DIA_HORA_FIN 18   // Fin de ventana diurna: 18:59

#define TEMP_DIA_MIN 20   // Rango diurno de temperatura minima
#define TEMP_DIA_MAX 30   // Rango diurno de temperatura maxima
#define HUM_DIA_MIN 50   // Rango diurno de humedad minima
#define HUM_DIA_MAX 70   // Rango diurno de humedad maxima

#define TEMP_NOCHE_MIN 15   // Rango nocturno de temperatura minima
#define TEMP_NOCHE_MAX 22   // Rango nocturno de temperatura maxima
#define HUM_NOCHE_MIN 60   // Rango nocturno de humedad minima
#define HUM_NOCHE_MAX 80   // Rango nocturno de humedad maxima

typedef enum
{
    ESTADO_NORMAL = 0,
    ESTADO_ALERTA = 1
} estado_monitor_t;

extern uint8_t intervalo_reporte_s;
extern uint8_t contador_reporte_s;
extern uint8_t contador_tramas_alerta;

uint8_t es_horario_diurno (const tiempo_t *tiempo);
estado_monitor_t evaluar_estado (const tiempo_t *tiempo, const lectura_ambiente_t *lectura);
void formatear_hora (const tiempo_t *tiempo, char *salida);
void tarea_emitir_reporte (void);
void emitir_telemetria (const tiempo_t *tiempo, const lectura_ambiente_t *lectura, estado_monitor_t estado);
void emitir_alarmas (const tiempo_t *tiempo, const lectura_ambiente_t *lectura);

#endif
