//. Lee el potenciómetro una vez por segundo, y si el valor supera el umbral pasa a cuatro por segundo (cada 250 ms). El valor se muestra en 8 LEDs.

#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>

#define UMBRAL 512                   // en 10 bits (0..1023)

volatile uint8_t tick   = 0;         // la ISR avisa "toca leer"
volatile uint8_t rapido = 0;         // 1 = cada 250 ms, 0 = cada 1000 ms

void adc_init(void) {
  ADMUX  = (1<<REFS0);                                        // ref 5 V, canal ADC0
  ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);  // ADC on, /128
}

uint16_t adc_leer(void) {
  ADCSRA |= (1<<ADSC);               // medí
  while (ADCSRA & (1<<ADSC));        // esperá
  return ADC;                        // 0..1023
}

int main(void) {
  DDRB = 0xFF;                       // 8 LEDs
  adc_init();

  TCCR0A = (1<<WGM01);               // Timer0 igual que siempre: 1 ms
  OCR0A  = 249;
  TIMSK0 = (1<<OCIE0A);
  TCCR0B = (1<<CS01) | (1<<CS00);
  sei();

  while (1) {
    if (tick) {                      // la ISR dijo que toca muestrear
      tick = 0;
      uint16_t v = adc_leer();
      PORTB  = v >> 2;               // "imprimir": los 8 bits altos en los LEDs
      rapido = (v > UMBRAL);         // decide la próxima frecuencia
    }
  }
}

ISR(TIMER0_COMPA_vect) {             // cada 1 ms
  static uint16_t ms = 0;
  uint16_t periodo = rapido ? 250 : 1000;
  if (++ms >= periodo) {
    ms = 0;
    tick = 1;                        // solo avisa: no convierte ni imprime acá
  }
}       
