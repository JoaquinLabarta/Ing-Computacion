#include <avr/io.h>
#include "placa.h"

// Pertenece a placa.c.
// Configura los pines usados por UART, DHT11 e I2C segun el esquema del TP, dejando las lineas I2C y DHT con pull-up externo como indica el enunciado
void placa_iniciar (void) {
    DDRD &= ~(1 << DDD0);   // DDRD/DDD0: PD0 queda como entrada para RXD de UART0
    DDRD |= (1 << DDD1);   // DDRD/DDD1: PD1 queda como salida para TXD de UART0

    DDRC &= ~(1 << DDC0);   // DDRC/DDC0: PC0 queda inicialmente como entrada para DHT11
    PORTC &= ~(1 << PORTC0);   // PORTC/PORTC0: pull-up interno apagado; el enunciado usa pull-up externo de 10k

    DDRC &= ~((1 << DDC4) | (1 << DDC5));   // DDRC/DDC4/DDC5: PC4(SDA) y PC5(SCL) como entradas para TWI/I2C
    PORTC &= ~((1 << PORTC4) | (1 << PORTC5));   // PORTC/PORTC4/PORTC5: pull-up interno apagado; el enunciado usa 4.7k externos
}
