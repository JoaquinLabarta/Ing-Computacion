//Ejercicio 1
#define F_CPU 16000000UL    
#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  DDRD &= ~((1<<PORTD2) | (1<<PORTD3));    // PORTD2, PORTD3 entradas (bits en 0)
  PORTD |=  ((1<<PORTD2) | (1<<PORTD3));    // pull-ups internas (bits en 1)
  DDRB |=  ((1<<PORTB0) | (1<<PORTB1)) ;       // PORTB0, PORTB1 salidas
  PORTB |=  ((1<<PORTB0) | (1<<PORTB1));       // a) ambos encendidos

  uint8_t antes = 0;

  while (1) {
    uint8_t ahora = !(PIND & (1<<PD2)) || !(PIND & (1<<PD3));   // 1 si alguno está apretado
    if (ahora != antes) {
      PORTB |=  (1<<PORTB0);       // PORTB0 on
      PORTB &= ~(1<<PORTB1);       // PORTB1 off
      _delay_ms(250);
      PORTB ^= ((1<<PORTB0) | (1<<PORTB1));            // invierte ambos
      _delay_ms(250);
      PORTB |= ((1<<PORTB0) | (1<<PORTB1));            // vuelve al estado inicial (ambos on)
      antes = ahora;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------
//Ejercicio 2 - Mismo que el 1 pero con TIMER0
#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t count = 0;   // ms que faltan del ciclo. 0 = reposo

int main(void) {
  DDRD  &= ~((1<<PD2) | (1<<PD3));   // PD2, PD3 entradas
  PORTD |=  ((1<<PD2) | (1<<PD3));   // pull-ups
  DDRB  |=  ((1<<PB0) | (1<<PB1));   // PB0, PB1 salidas
  PORTB |=  ((1<<PB0) | (1<<PB1));   // a) ambos encendidos

  // Timer0: CTC, prescaler 64, OCR0A = 249 -> interrupción cada 1 ms
  TCCR0A = (1<<WGM01);
  OCR0A  = 249;
  TIMSK0 = (1<<OCIE0A);
  TCCR0B = (1<<CS01) | (1<<CS00);  
  sei();

  uint8_t antes = 0;

  while (1) {
    uint8_t ahora = !(PIND & (1<<PD2)) || !(PIND & (1<<PD3));

    if (ahora && !antes && count == 0) { // flanco y sin ciclo en curso
      PORTB |=  (1<<PB0);            // fase 1: PB0 on, PB1 off
      PORTB &= ~(1<<PB1);
      count = 500;
    }
    antes = ahora;
  }
}

// Se ejecuta cada 1 ms
ISR(TIMER0_COMPA_vect) {
  if (count == 0) return;            // reposo: nada que hacer
  count--;
  if (count == 250)                  // pasaron 250 ms
    PORTB ^= (1<<PB0) | (1<<PB1);    // fase 2: PB0 off, PB1 on
  else if (count == 0)               // pasaron 500 ms
    PORTB |= (1<<PB0) | (1<<PB1);    // fin: ambos on
}
