#ifndef UART_H
#define UART_H

#include <stdint.h>

#define UART_BAUD_9600_16MHZ 103   // Valor UBRR para 9600 bps con F_CPU=16 MHz en modo normal
#define UART_TX_TAM 128   // Tamanio del buffer circular de transmision
#define UART_RX_TAM 64   // Tamanio del buffer circular de recepcion

extern volatile uint8_t uart_rx_desborde;
extern volatile uint8_t uart_rx_error_trama;

void uart_iniciar (void);
void uart_enviar_caracter (char dato);
void uart_enviar_cadena (const char *cadena);
uint8_t uart_hay_caracter (void);
uint8_t uart_leer_caracter (char *dato);

#endif
