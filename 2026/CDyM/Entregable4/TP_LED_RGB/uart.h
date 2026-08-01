#ifndef UART_H
#define UART_H

#include <stdint.h>

#define UART_UBRR 103   // Valor UBRR para 9600 bps con 16 MHz en modo normal
#define UART_TX_TAM 128
#define UART_RX_TAM 64

extern volatile uint8_t uart_rx_desborde;
extern volatile uint8_t uart_rx_error_trama;

void uart_iniciar (void);
void uart_enviar_cadena (const char *cadena);
uint8_t uart_leer_caracter (char *dato);

#endif
