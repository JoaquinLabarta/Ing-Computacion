#ifndef SENSOR_LUZ_H
#define SENSOR_LUZ_H

#include <stdint.h>

#define ADC_LUZ_MAXIMO 1023UL
#define PERIODO_LUZ_MINIMO_MS 3000U
#define PERIODO_LUZ_MAXIMO_MS 6000U

void sensor_luz_iniciar (void);
uint16_t sensor_luz_leer (void);
uint16_t sensor_luz_calcular_periodo_ms (uint16_t lectura_adc);

#endif
