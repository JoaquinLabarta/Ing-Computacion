#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "pwm_rgb.h"

#define PIN_LED_ROJO PB5
#define PIN_LED_VERDE PB2
#define PIN_LED_AZUL PB1

static volatile uint8_t intensidad_roja_solicitada = 0;
static volatile uint8_t intensidad_roja_ciclo = 0;

// Comienza cada periodo del PWM por software y enciende el rojo si su intensidad no es cero 
ISR (TIMER0_OVF_vect) { // Interrupcion del desborde del TIMER0
    intensidad_roja_ciclo = intensidad_roja_solicitada;
    OCR0A = intensidad_roja_ciclo;   // Instante del flanco de apagado dentro del ciclo de 256 cuentas

    if (intensidad_roja_ciclo == 0) {
        PORTB |= (1 << PIN_LED_ROJO);   // Anodo comun: alto significa apagado
    }
    else {
        PORTB &= ~(1 << PIN_LED_ROJO);   // Comienza el pulso activo en nivel bajo
    }
}

// Finaliza el pulso rojo cuando TCNT0 alcanza la proporcion pedida
ISR (TIMER0_COMPA_vect) { // Interrupcion de comparacion del TIMER0
    if (intensidad_roja_ciclo < 255) {
        PORTB |= (1 << PIN_LED_ROJO);
    }
    // Para intensidad 255 no se genera flanco de apagado y el rojo queda encendido todo el ciclo
}

// Configura TIMER1 para verde y azul por hardware, y TIMER0 para el rojo por software
void pwm_rgb_iniciar (void) {
    DDRB |= (1 << PIN_LED_ROJO) | (1 << PIN_LED_VERDE) | (1 << PIN_LED_AZUL);
    PORTB |= (1 << PIN_LED_ROJO) | (1 << PIN_LED_VERDE) | (1 << PIN_LED_AZUL);

    // TIMER1: PWM fase correcta de 8 bits, modo invertido y prescaler 64
    // OC1A=PB1 controla azul y OC1B=PB2 controla verde
    TCCR1A = (1 << COM1A1) | (1 << COM1A0) |
             (1 << COM1B1) | (1 << COM1B0) |
             (1 << WGM10);   // WGM13:0=0001, TOP=0x00FF
    TCCR1B = 0x00;
    TCNT1 = 0;
    OCR1A = 0;
    OCR1B = 0;
    TCCR1B = (1 << CS11) | (1 << CS10);   // Configuracion del TIMER1 para una frecuencia de 490,2Hz (fPWM=16MHz/(64*2*255))

    // TIMER0: modo normal de 8 bits; sus interrupciones forman el PWM por software sobre PB5
    TCCR0A = 0x00;
    TCCR0B = 0x00;
    TCNT0 = 0;
    OCR0A = 0;
    TIFR0 = (1 << OCF0A) | (1 << TOV0);   // Limpia comparacion y desborde pendientes 
    TIMSK0 = (1 << OCIE0A) | (1 << TOIE0); // Habilita interrupciones de comparacion y desborde del TIMER0
    TCCR0B = (1 << CS02);   // Configuracion del TIMER0 para una frecuencia de 244,1Hz (fPWM=16MHz/(256*256))
}

// Recibe intensidades logicas entre 0 y 255; el modo invertido compensa el anodo comun
void pwm_rgb_establecer_intensidades (uint8_t rojo, uint8_t verde, uint8_t azul) { 
    intensidad_roja_solicitada = rojo;
    OCR1B = verde;   // OC1B/PB2 controla el verde
    OCR1A = azul;   // OC1A/PB1 controla el azul
}
