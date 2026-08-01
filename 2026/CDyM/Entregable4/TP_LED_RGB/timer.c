#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "timer.h"

static volatile uint8_t milisegundos_pendientes = 0;

// Se ejecuta cada 1 ms y deja el trabajo de la aplicacion pendiente para el background
ISR (TIMER2_COMPA_vect) {
    if (milisegundos_pendientes < 255) {
        milisegundos_pendientes++;
    }
}

// Configura TIMER2 en CTC para obtener una unica base de tiempo exacta de 1 ms
void timer2_iniciar (void) {
    TCCR2A = (1 << WGM21);   // Modo CTC, cuenta desde 0 hasta OCR2A
    TCCR2B = 0x00;
    TCNT2 = 0;
    OCR2A = 249;   // 16MHz / 64 / (249+1) = 1000Hz = 1ms
    TIFR2 = (1 << OCF2A);   // Limpia una comparacion pendiente antes de habilitarla
    TIMSK2 = (1 << OCIE2A);   // Habilita interrupcion por comparacion A
    TCCR2B = (1 << CS22);   // TIMER2 comienza con prescaler 64
}

// Extrae de forma atomica un milisegundo generado por la ISR
uint8_t obtener_milisegundo_pendiente (void) {
    uint8_t hay_milisegundo = 0;
    uint8_t estado_interrupciones = SREG;

    cli();

    if (milisegundos_pendientes > 0) {
        milisegundos_pendientes--;
        hay_milisegundo = 1;
    }

    SREG = estado_interrupciones;

    return hay_milisegundo;
}
