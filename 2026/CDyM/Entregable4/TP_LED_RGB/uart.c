#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "uart.h"

static volatile char uart_tx_buffer[UART_TX_TAM];   // Buffer lineal de transmision
static volatile uint8_t uart_tx_escritura = 0;
static volatile uint8_t uart_tx_lectura = 0;

static volatile char uart_rx_buffer[UART_RX_TAM];   // Buffer lineal de recepcion
static volatile uint8_t uart_rx_escritura = 0;
static volatile uint8_t uart_rx_lectura = 0;

volatile uint8_t uart_rx_desborde = 0;   // Flag si el buffer RX se llena
volatile uint8_t uart_rx_error_trama = 0;   // Flag si UART informa FE0, DOR0 o UPE0

static void uart_enviar_caracter (char dato);

// Se ejecuta cuando llega un byte y lo deja en el buffer para procesarlo en background
ISR (USART_RX_vect) {
    uint8_t estado = UCSR0A;   // UCSR0A debe leerse antes de UDR0 para conservar los errores del byte
    char dato = UDR0;

    if (estado & ((1 << FE0) | (1 << DOR0) | (1 << UPE0))) {
        uart_rx_error_trama = 1;
        return;
    }

    if (uart_rx_escritura >= UART_RX_TAM) {
        uart_rx_desborde = 1;
    }
    else {
        uart_rx_buffer[uart_rx_escritura] = dato;
        uart_rx_escritura++;
    }
}

// Transmite el siguiente byte o detiene la interrupcion si el buffer ya quedo vacio
ISR (USART_UDRE_vect) {
    if (uart_tx_lectura >= uart_tx_escritura) {
        uart_tx_lectura = 0;
        uart_tx_escritura = 0;
        UCSR0B &= ~(1 << UDRIE0);
    }
    else {
        UDR0 = uart_tx_buffer[uart_tx_lectura];
        uart_tx_lectura++;
    }
}

// Configura UART0 a 9600 bps, 8 bits de datos, sin paridad y un bit de parada
void uart_iniciar (void) {
    UCSR0A = 0x00;   // Modo normal, U2X0=0
    UBRR0H = 0x00;
    UBRR0L = UART_UBRR;
    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);   // UMSEL=0, UPM=00, USBS=0 y UCSZ=011: 8N1
    UCSR0B = (1 << RXEN0) | (1 << TXEN0) | (1 << RXCIE0);
}

// Encola un caracter en el buffer lineal y habilita la interrupcion de registro vacio
static void uart_enviar_caracter (char dato) {
    uint8_t estado_interrupciones;

    while (uart_tx_escritura >= UART_TX_TAM) {}

    estado_interrupciones = SREG;
    cli();

    uart_tx_buffer[uart_tx_escritura] = dato;
    uart_tx_escritura++;
    UCSR0B |= (1 << UDRIE0);

    SREG = estado_interrupciones;
}

// Encola una cadena terminada en '\0' para enviarla por UART0 mediante interrupciones
void uart_enviar_cadena (const char *cadena) {
    while (*cadena != '\0') {
        uart_enviar_caracter(*cadena);
        cadena++;
    }
}

// Extrae un byte del buffer RX; devuelve 1 si habia un dato y 0 si estaba vacio
uint8_t uart_leer_caracter (char *dato) { 
    uint8_t hay_dato = 0;
    uint8_t estado_interrupciones = SREG;

    cli();

    if (uart_rx_lectura < uart_rx_escritura) { // Si hay un dato en el buffer, se lee y se actualiza el indice de lectura
        *dato = uart_rx_buffer[uart_rx_lectura];
        uart_rx_lectura++;
        hay_dato = 1;

        if (uart_rx_lectura >= uart_rx_escritura) { // Si se llego al final del buffer, se reinicia el indice de lectura y escritura
            uart_rx_lectura = 0;
            uart_rx_escritura = 0;
        }
    }

    SREG = estado_interrupciones; // Se restaura el estado de las interrupciones

    return hay_dato;
}
