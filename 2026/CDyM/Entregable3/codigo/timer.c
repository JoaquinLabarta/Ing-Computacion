#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "timer.h"

volatile uint8_t segundos_pendientes = 0;

// Pertenece a timer.c
// Se ejecuta cada 1 ms por comparacion de Timer0 y acumula segundos pendientes para que el programa principal haga las tareas periodicas en background
ISR (TIMER0_COMPA_vect) {
    static uint16_t cuenta_ms = 0;

    cuenta_ms++;

    if (cuenta_ms >= 1000) {
        cuenta_ms = 0;

        if (segundos_pendientes < 255)
        {
            segundos_pendientes++;
        }
    }
}

//Pertenece a timer.c.
//Configura Timer0 en modo CTC para generar una interrupcion cada 1 ms usando reloj de 16 MHz y prescaler 64
void timer0_iniciar (void) {
    TCCR0A = (1 << WGM01);   // TCCR0A/WGM01: modo CTC, el contador se limpia al llegar a OCR0A.
    TCCR0B =  (1 << CS01) | (1 << CS00);   // TCCR0B: detiene Timer0 mientras se configura.
    TCNT0 = 0;   // TCNT0: contador Timer0 inicia en cero.
    OCR0A = 249;   // OCR0A: TOP=249; 16MHz/64/(249+1)=1000 Hz, perodo 1 ms.
    TIMSK0 = (1 << OCIE0A);   // TIMSK0/OCIE0A: habilita interrupcin por comparacin A.
    TCCR0B = (1 << CS01) | (1 << CS00);   // TCCR0B/CS01/CS00: inicia Timer0 con prescaler 64.
}

// Pertenece a timer.c.
// Extrae un segundo pendiente generado por la ISR de Timer0 de forma segura, usando seccion critica porque la variable tambien la modifica una interrupcion
uint8_t obtener_segundo_pendiente (void) {
    uint8_t hay_segundo = 0;

    cli();

    if (segundos_pendientes > 0)
    {
        segundos_pendientes--;
        hay_segundo = 1;
    }

    sei();

    return hay_segundo;
}
