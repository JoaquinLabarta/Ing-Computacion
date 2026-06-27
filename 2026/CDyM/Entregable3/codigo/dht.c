#include <avr/io.h>
#include <util/delay.h>
#include <stdint.h>
#include "dht.h"

// Pertenece a dht.c.
// Deja PC0 como entrada liberada. La resistencia de pull-up externa del enunciado mantiene la linea en alto cuando nadie la fuerza a bajo
void dht_iniciar (void) {
    DHT_DDR &= ~(1 << DHT_BIT);   // DDRC/PC0: configura PC0 como entrada para liberar bus DHT11
    DHT_PORT &= ~(1 << DHT_BIT);   // PORTC/PC0: pull-up interno apagado; se usa pull-up externo de 10k
}

// Pertenece a dht.c.
// Espera hasta que la linea del DHT11 tome el nivel pedido o hasta que se cumpla un timeout en microsegundos
uint8_t dht_esperar_nivel (uint8_t nivel, uint16_t tiempo_us) {
    uint16_t i;

    for (i = 0; i < tiempo_us; i++) {
        uint8_t lectura = (DHT_PINREG & (1 << DHT_BIT)) ? 1 : 0;   // PINC/PC0: lee el nivel presente en la linea de datos

        if (lectura == nivel) {return 1;}

        _delay_us(1);
    }

    return 0;
}

// Pertenece a dht.c.
// Lee humedad y temperatura del DHT11 conectado en PC0; si falla el protocolo o checksum, devuelve lectura invalida
uint8_t dht_leer (lectura_ambiente_t *lectura){
    uint8_t datos[5] = {0, 0, 0, 0, 0};
    uint8_t i;
    uint8_t bit;

    lectura->valido = 0;

    // REVISAR

    DHT_DDR |= (1 << DHT_BIT);   // DDRC/PC0: PC0 pasa a salida para iniciar comunicacion con nivel bajo
    DHT_PORT &= ~(1 << DHT_BIT);   // PORTC/PC0: fuerza bajo sobre la linea de datos del DHT11
    _delay_ms(20);

    DHT_DDR &= ~(1 << DHT_BIT);   // DDRC/PC0: PC0 vuelve a entrada para liberar la linea
    DHT_PORT &= ~(1 << DHT_BIT);   // PORTC/PC0: pull-up interno apagado; el alto lo produce resistencia externa
    _delay_us(40);

    if (!dht_esperar_nivel(0, 100)){return 0;}

    if (!dht_esperar_nivel(1, 100)){return 0;}

    if (!dht_esperar_nivel(0, 100)){return 0;}

    for (i = 0; i < 40; i++) {
        if (!dht_esperar_nivel(1, 80)) {return 0;}

        _delay_us(35);

        bit = (DHT_PINREG & (1 << DHT_BIT)) ? 1 : 0;   // PINC/PC0: si sigue alto luego del retardo se interpreta como bit 1

        datos[i / 8] <<= 1;
        datos[i / 8] |= bit;

        if (bit) {
            if (!dht_esperar_nivel(0, 100)) {return 0;}
        }
    }

    if ((uint8_t)(datos[0] + datos[1] + datos[2] + datos[3]) != datos[4]) {return 0;}

    lectura->humedad = datos[0];
    lectura->temperatura = (int8_t)datos[2];
    lectura->valido = 1;

    return 1;
}
