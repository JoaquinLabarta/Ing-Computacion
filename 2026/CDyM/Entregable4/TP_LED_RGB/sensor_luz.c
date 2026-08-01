#include <avr/io.h>
#include <stdint.h>
#include "sensor_luz.h"

// Configura el ADC con referencia AVCC, resultado de 10 bits y canal ADC3
void sensor_luz_iniciar (void) {
    ADMUX = (1 << REFS0) | (1 << MUX1) | (1 << MUX0);   // REFS=01 y MUX=0011 para ADC3
    ADCSRB = 0x00;   // Conversiones simples sin disparo automatico
    ADCSRA = (1 << ADEN) |
              (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);   // fADC=16MHz/128=125kHz
    DIDR0 |= (1 << ADC3D);   // Deshabilita la entrada digital de PC3
}

// Inicia una conversion simple y devuelve el resultado de 0 a 1023
uint16_t sensor_luz_leer (void) {
    ADCSRA |= (1 << ADSC);   // ADSC inicia la conversion

    while (ADCSRA & (1 << ADSC)) {}

    return ADC;   // AVR-GCC lee ADCL antes de ADCH mediante el registro combinado ADC
}

// Mapea linealmente 0 ADC a 6000 ms y 1023 ADC a 3000 ms
uint16_t sensor_luz_calcular_periodo_ms (uint16_t lectura_adc) {
    uint32_t reduccion_ms;

    if (lectura_adc > ADC_LUZ_MAXIMO) {
        lectura_adc = ADC_LUZ_MAXIMO;
    }

    reduccion_ms = ((uint32_t)lectura_adc *
                   (PERIODO_LUZ_MAXIMO_MS - PERIODO_LUZ_MINIMO_MS) +
                   (ADC_LUZ_MAXIMO / 2)) / ADC_LUZ_MAXIMO;

    return (uint16_t)(PERIODO_LUZ_MAXIMO_MS - reduccion_ms);
}
