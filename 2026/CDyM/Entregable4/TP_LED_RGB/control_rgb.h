#ifndef CONTROL_RGB_H
#define CONTROL_RGB_H

#include <stdint.h>

#define RAMPA_SUBIDA_MS 1000U
#define TIEMPO_MAXIMO_MS 1000U
#define RAMPA_BAJADA_MS 1000U
#define TIEMPO_ACTIVO_MS (RAMPA_SUBIDA_MS + TIEMPO_MAXIMO_MS + RAMPA_BAJADA_MS)

#define COLOR_INICIAL_ROJO 255
#define COLOR_INICIAL_VERDE 255
#define COLOR_INICIAL_AZUL 255

void control_rgb_iniciar (uint16_t periodo_inicial_ms);
void control_rgb_actualizar_1ms (void);
void control_rgb_establecer_color (uint8_t rojo, uint8_t verde, uint8_t azul);
void control_rgb_establecer_periodo (uint16_t nuevo_periodo_ms);

#endif
