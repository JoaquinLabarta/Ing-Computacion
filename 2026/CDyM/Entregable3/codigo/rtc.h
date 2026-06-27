#ifndef RTC_H
#define RTC_H

#include <stdint.h>

#define RTC_DIRECCION 0x68   // Direccion I2C estandar asumida para DS3231/DS3232

typedef struct
{
    uint8_t hora;
    uint8_t minuto;
    uint8_t segundo;
    uint8_t valido;
} tiempo_t;

uint8_t bcd_a_decimal (uint8_t bcd);
uint8_t decimal_a_bcd (uint8_t decimal);
uint8_t rtc_leer_hora (tiempo_t *tiempo);
uint8_t rtc_escribir_hora (uint8_t hora, uint8_t minuto, uint8_t segundo);

#endif
