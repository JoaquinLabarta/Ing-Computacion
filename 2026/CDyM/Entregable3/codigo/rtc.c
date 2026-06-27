#include <avr/io.h>
#include <util/twi.h>
#include <stdint.h>
#include "rtc.h"
#include "twi.h"

// Pertenece a rtc.c.
// Convierte un numero BCD a decimal. Los registros de hora del RTC se asumen codificados en BCD
uint8_t bcd_a_decimal (uint8_t bcd) {
    return (uint8_t)(((bcd >> 4) * 10) + (bcd & 0x0F));
}

// Pertenece a rtc.c.
// Convierte un numero decimal a BCD para escribir hora, minutos y segundos en el RTC
uint8_t decimal_a_bcd (uint8_t decimal) {
    return (uint8_t)(((decimal / 10) << 4) | (decimal % 10));
}

// Pertenece a rtc.c.
// Lee hora, minuto y segundo desde el RTC por I2C; si algo falla, marca el tiempo como invalido para que la aplicacion emita alerta
uint8_t rtc_leer_hora (tiempo_t *tiempo) {
    uint8_t segundos_bcd;
    uint8_t minutos_bcd;
    uint8_t horas_bcd;

    tiempo->valido = 0;

    if (!twi_start()) {
        twi_stop();
        return 0;
    }

    // TW_MT_SLA_ACK: SLA+W transmitido y ACK recibido
    if (!twi_write((uint8_t)(RTC_DIRECCION << 1), TW_MT_SLA_ACK)) {
        twi_stop();
        return 0;
    }

    // TW_MT_DATA_ACK: direccion de registro 0x00 aceptada por el RTC
    if (!twi_write(0x00, TW_MT_DATA_ACK)) {
        twi_stop();
        return 0;
    }

    if (!twi_start()) {
        twi_stop();
        return 0;
    }

    // TW_MR_SLA_ACK: SLA+R transmitido y ACK recibido
    if (!twi_write((uint8_t)((RTC_DIRECCION << 1) | 1), TW_MR_SLA_ACK)) {
        twi_stop();
        return 0;
    }

    if (!twi_read_ack(&segundos_bcd)) {
        twi_stop();
        return 0;
    }

    if (!twi_read_ack(&minutos_bcd)) {
        twi_stop();
        return 0;
    }

    if (!twi_read_nack(&horas_bcd)) {
        twi_stop();
        return 0;
    }

    twi_stop();

    tiempo->segundo = bcd_a_decimal(segundos_bcd & 0x7F);
    tiempo->minuto = bcd_a_decimal(minutos_bcd & 0x7F);
    tiempo->hora = bcd_a_decimal(horas_bcd & 0x3F);
    tiempo->valido = 1;

    if ((tiempo->hora > 23) || (tiempo->minuto > 59) || (tiempo->segundo > 59)) {
        tiempo->valido = 0;
        return 0;
    }

    return 1;
}

// Pertenece a rtc.c.
// Actualiza la hora del RTC en formato 24 h, escribiendo segundos, minutos y horas a partir del registro 0x00
uint8_t rtc_escribir_hora (uint8_t hora, uint8_t minuto, uint8_t segundo) {
    if ((hora > 23) || (minuto > 59) || (segundo > 59)) {
        return 0;
    }

    if (!twi_start()) {
        twi_stop();
        return 0;
    }

    // TW_MT_SLA_ACK: confirma que el RTC acepto escritura
    if (!twi_write((uint8_t)(RTC_DIRECCION << 1), TW_MT_SLA_ACK)) {
        twi_stop();
        return 0;
    }

    // TW_MT_DATA_ACK: posiciona puntero interno del RTC en segundos
    if (!twi_write(0x00, TW_MT_DATA_ACK)) {
        twi_stop();
        return 0;
    }

    if (!twi_write(decimal_a_bcd(segundo), TW_MT_DATA_ACK)) {
        twi_stop();
        return 0;
    }

    if (!twi_write(decimal_a_bcd(minuto), TW_MT_DATA_ACK)) {
        twi_stop();
        return 0;
    }

    if (!twi_write(decimal_a_bcd(hora), TW_MT_DATA_ACK)) {
        twi_stop();
        return 0;
    }

    twi_stop();

    return 1;
}
