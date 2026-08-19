#include <avr/io.h>
#include <stdint.h>
#include "sensor_luz.h"

// Configura el ADC con referencia AVCC, resultado de 10 bits y canal ADC3
void sensor_luz_iniciar (void) {
    ADMUX = (1 << REFS0) | (1 << MUX1) | (1 << MUX0); // Configuracion del ADC para el canal 3 (PC3) con referencia AVCC y resultado de 10 bits (ADMUX=01001) (REFS=01 y MUX=0011) 
    ADCSRB = 0x00;   // Conversiones simples sin disparo automatico
    ADCSRA = (1 << ADEN) |
              (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);   // Configuracion del ADC para una frecuencia de muestreo de 125kHz (fADC=16MHz/128)
    DIDR0 |= (1 << ADC3D);   // Deshabilita la entrada digital de PC3
}

// Inicia una conversion simple y devuelve el resultado de 0 a 1023
uint16_t sensor_luz_leer (void) {
    ADCSRA |= (1 << ADSC);   // ADSC inicia la conversion

    while (ADCSRA & (1 << ADSC)) {} // Espera a que la conversion termine (ADSC=0)  

    return ADC;   // AVR-GCC lee ADCL antes de ADCH mediante el registro combinado ADC 
}

// Mapea linealmente 0 ADC a 6000 ms y 1023 ADC a 3000 ms
uint16_t sensor_luz_calcular_periodo_ms (uint16_t lectura_adc) {
    uint32_t reduccion_ms;

    if (lectura_adc > ADC_LUZ_MAXIMO) { // Si la lectura es mayor al maximo, se establece en el maximo (ADC_LUZ_MAXIMO=1023)
        lectura_adc = ADC_LUZ_MAXIMO;
    }

    reduccion_ms = (uint32_t)(lectura_adc / ADC_LUZ_MAXIMO)*3000; 

    return (uint16_t)(PERIODO_LUZ_MAXIMO_MS - reduccion_ms);
}
