#ifndef DHT_H
#define DHT_H

#include <avr/io.h>
#include <stdint.h>

#define DHT_DDR DDRC
#define DHT_PORT PORTC
#define DHT_PINREG PINC
#define DHT_BIT PC0

typedef struct
{
    int8_t temperatura;
    uint8_t humedad;
    uint8_t valido;
} lectura_ambiente_t;

void dht_iniciar (void);
uint8_t dht_esperar_nivel (uint8_t nivel, uint16_t tiempo_us);
uint8_t dht_leer (lectura_ambiente_t *lectura);

#endif
