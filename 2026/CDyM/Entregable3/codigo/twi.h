#ifndef TWI_H
#define TWI_H

#include <stdint.h>

#define F_CPU 16000000UL

#define TWI_SCL_HZ 100000UL   // Velocidad I2C de 100 kHz
#define TWI_TIMEOUT 30000UL   // Tiempo de timeout para evitar bloqueos si el RTC no responde

void twi_iniciar (void);
uint8_t twi_esperar_fin (void);
uint8_t twi_start (void);
void twi_stop (void);
uint8_t twi_write (uint8_t dato, uint8_t estado_esperado);
uint8_t twi_read_ack (uint8_t *dato);
uint8_t twi_read_nack (uint8_t *dato);

#endif
