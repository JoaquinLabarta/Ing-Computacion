#ifndef PWM_RGB_H
#define PWM_RGB_H

#include <stdint.h>

void pwm_rgb_iniciar (void);
void pwm_rgb_establecer_intensidades (uint8_t rojo, uint8_t verde, uint8_t azul);

#endif
