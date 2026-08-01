#include <stdint.h>
#include "control_rgb.h"
#include "pwm_rgb.h"

typedef enum {
    ESTADO_SUBIDA = 0,
    ESTADO_MAXIMO,
    ESTADO_BAJADA,
    ESTADO_APAGADO
} estado_desvanecimiento_t;

static estado_desvanecimiento_t estado_actual = ESTADO_SUBIDA;
static uint16_t tiempo_estado_ms = 0;
static uint16_t periodo_actual_ms = TIEMPO_ACTIVO_MS;
static uint16_t periodo_siguiente_ms = TIEMPO_ACTIVO_MS;

static uint8_t color_rojo = COLOR_INICIAL_ROJO;
static uint8_t color_verde = COLOR_INICIAL_VERDE;
static uint8_t color_azul = COLOR_INICIAL_AZUL;
static uint8_t nivel_desvanecimiento = 0;

static uint8_t escalar_componente (uint8_t componente, uint8_t nivel);
static void aplicar_nivel (uint8_t nivel);
static void comenzar_nuevo_ciclo (void);

// Escala una componente de color por el nivel global sin cambiar la proporcion entre R, G y B
static uint8_t escalar_componente (uint8_t componente, uint8_t nivel) {
    return (uint8_t)(((uint16_t)componente * nivel + 127U) / 255U);
}

// Convierte el color seleccionado y el nivel de la rampa en las tres intensidades PWM finales
static void aplicar_nivel (uint8_t nivel) {
    nivel_desvanecimiento = nivel;

    pwm_rgb_establecer_intensidades(
        escalar_componente(color_rojo, nivel),
        escalar_componente(color_verde, nivel),
        escalar_componente(color_azul, nivel)
    );
}

// Inicia una nueva rampa y adopta el ultimo periodo calculado a partir del LDR
static void comenzar_nuevo_ciclo (void) {
    periodo_actual_ms = periodo_siguiente_ms;
    estado_actual = ESTADO_SUBIDA;
    tiempo_estado_ms = 0;
    aplicar_nivel(0);
}

// Inicia la MEF apagada, con color blanco y preparada para comenzar la rampa de subida
void control_rgb_iniciar (uint16_t periodo_inicial_ms) {
    if (periodo_inicial_ms < TIEMPO_ACTIVO_MS) {
        periodo_inicial_ms = TIEMPO_ACTIVO_MS;
    }

    color_rojo = COLOR_INICIAL_ROJO;
    color_verde = COLOR_INICIAL_VERDE;
    color_azul = COLOR_INICIAL_AZUL;

    periodo_actual_ms = periodo_inicial_ms;
    periodo_siguiente_ms = periodo_inicial_ms;
    estado_actual = ESTADO_SUBIDA;
    tiempo_estado_ms = 0;

    aplicar_nivel(0);
}

// Actualiza cada 1 ms la MEF: subida, maximo, bajada y tiempo restante apagado
void control_rgb_actualizar_1ms (void) {
    uint16_t tiempo_apagado_ms;
    uint8_t nuevo_nivel;

    tiempo_estado_ms++;

    switch (estado_actual) {
        case ESTADO_SUBIDA:
            if (tiempo_estado_ms >= RAMPA_SUBIDA_MS) {
                estado_actual = ESTADO_MAXIMO;
                tiempo_estado_ms = 0;
                aplicar_nivel(255);
            }
            else {
                nuevo_nivel = (uint8_t)(((uint32_t)tiempo_estado_ms * 255U) / RAMPA_SUBIDA_MS);
                aplicar_nivel(nuevo_nivel);
            }
            break;

        case ESTADO_MAXIMO:
            if (tiempo_estado_ms >= TIEMPO_MAXIMO_MS) {
                estado_actual = ESTADO_BAJADA;
                tiempo_estado_ms = 0;
                aplicar_nivel(255);
            }
            break;

        case ESTADO_BAJADA:
            if (tiempo_estado_ms >= RAMPA_BAJADA_MS) {
                tiempo_estado_ms = 0;
                aplicar_nivel(0);

                if (periodo_actual_ms > TIEMPO_ACTIVO_MS) {
                    estado_actual = ESTADO_APAGADO;
                }
                else {
                    comenzar_nuevo_ciclo();
                }
            }
            else {
                nuevo_nivel = (uint8_t)(255U -
                              ((uint32_t)tiempo_estado_ms * 255U) / RAMPA_BAJADA_MS);
                aplicar_nivel(nuevo_nivel);
            }
            break;

        case ESTADO_APAGADO:
            tiempo_apagado_ms = periodo_actual_ms - TIEMPO_ACTIVO_MS;

            if (tiempo_estado_ms >= tiempo_apagado_ms) {
                comenzar_nuevo_ciclo();
            }
            break;

        default:
            comenzar_nuevo_ciclo();
            break;
    }
}

// Cambia inmediatamente el color base y conserva el punto actual del desvanecimiento
void control_rgb_establecer_color (uint8_t rojo, uint8_t verde, uint8_t azul) {
    color_rojo = rojo;
    color_verde = verde;
    color_azul = azul;

    aplicar_nivel(nivel_desvanecimiento);
}

// Guarda el periodo para aplicarlo al comienzo del ciclo siguiente
void control_rgb_establecer_periodo (uint16_t nuevo_periodo_ms) {
    if (nuevo_periodo_ms < TIEMPO_ACTIVO_MS) {
        nuevo_periodo_ms = TIEMPO_ACTIVO_MS;
    }

    periodo_siguiente_ms = nuevo_periodo_ms;
}
