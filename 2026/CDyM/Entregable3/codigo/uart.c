#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "uart.h"

volatile char uart_tx_buffer[UART_TX_TAM];   // Buffer circular de transmision usado por main e ISR UART
volatile uint8_t uart_tx_cabeza = 0;   // Indice de escritura del buffer de transmision
volatile uint8_t uart_tx_cola = 0;   // Indice de lectura del buffer de transmision

volatile char uart_rx_buffer[UART_RX_TAM];   // Buffer circular de recepcion usado por ISR UART y main
volatile uint8_t uart_rx_cabeza = 0;   // Indice de escritura del buffer de recepcion
volatile uint8_t uart_rx_cola = 0;   // Indice de lectura del buffer de recepcion
volatile uint8_t uart_rx_desborde = 0;   // Flag de error si llega mas informacion que la que entra en el buffer
volatile uint8_t uart_rx_error_trama = 0;   // Flag de error si UART informa FE0, DOR0 o PE0

// Pertenece a uart.c.
// Se ejecuta cuando llega un byte por UART0
// Guarda el dato en el buffer de recepcion y deja el procesamiento del comando para el background
ISR (USART_RX_vect) {
    uint8_t estado = UCSR0A;   // UCSR0A: registro de estado UART; se lee para detectar FE0, DOR0 y PE0
    char dato = UDR0;   // UDR0: registro de datos UART; leerlo retira el byte recibido

    // FE0/DOR0/PE0: macros de error de trama, sobrecarga o paridad
    if (estado & ((1 << FE0) | (1 << DOR0) | (1 << UPE0))) {
        uart_rx_error_trama = 1;
        return;
    }

    uint8_t siguiente = (uint8_t)((uart_rx_cabeza + 1) % UART_RX_TAM);

    if (siguiente == uart_rx_cola) {
        uart_rx_desborde = 1;
    }
    else {
        uart_rx_buffer[uart_rx_cabeza] = dato;
        uart_rx_cabeza = siguiente;
    }
}

// Pertenece a uart.c.
// Se ejecuta cuando UDR0 esta vacio; transmite el siguiente byte del buffer o deshabilita esta interrupcion si ya no queda nada por enviar
ISR (USART_UDRE_vect) {
    if (uart_tx_cola == uart_tx_cabeza) {
        UCSR0B &= ~(1 << UDRIE0);   // UCSR0B/UDRIE0: deshabilita interrupcion UDRE si no hay datos
    }
    else {
        UDR0 = uart_tx_buffer[uart_tx_cola];   // UDR0: escribir aca carga el proximo byte a transmitir por UART
        uart_tx_cola = (uint8_t)((uart_tx_cola + 1) % UART_TX_TAM);
    }
}

// Pertenece a uart.c.
// Configura UART0 a 9600 bps, formato 8N1, habilitando transmision,recepcion e interrupcion por recepcion completa
void uart_iniciar (void) {
    UCSR0A = 0x00;   // UCSR0A: modo UART normal, U2X0=0, sin doble velocidad
    UBRR0H = 0x00;   // UBRR0H: byte alto del divisor de baudios; 0 para 9600 a 16 MHz
    UBRR0L = UART_BAUD_9600_16MHZ;   // UBRR0L: byte bajo del divisor; 103 configura 9600 bps

    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);               // UCSR0C/UCSZ01/UCSZ00: formato 8 bits de datos, sin paridad, 1 stop.

    UCSR0B = (1 << RXEN0) | (1 << TXEN0) | (1 << RXCIE0); // UCSR0B/RXEN0/TXEN0/RXCIE0: habilita RX, TX e interrupcin RX.
}

// Pertenece a uart.c.
// Encola un caracter para transmision; al habilitar UDRIE0, la UART seguir enviando desde la ISR sin bloquear el programa principal
void uart_enviar_caracter (char dato) {
    uint8_t siguiente = (uint8_t)((uart_tx_cabeza + 1) % UART_TX_TAM);

    while (siguiente == uart_tx_cola) {} //Espera si el buffer esta lleno. La ISR de UART lo vacia

    cli();

    uart_tx_buffer[uart_tx_cabeza] = dato;
    uart_tx_cabeza = siguiente;
    UCSR0B |= (1 << UDRIE0);   // UCSR0B/UDRIE0: habilita interrupcion cuando UDR0 esta vacio

    sei();
}

// Pertenece a uart.c.
// Encola una cadena terminada en '\0' para enviarla por UART0 usando el mecanismo de transmision por interrupcion
void uart_enviar_cadena (const char *cadena) {
    while (*cadena != '\0') {
        uart_enviar_caracter(*cadena);
        cadena++;
    }
}

// Pertenece a uart.c.
// Indica si hay al menos un caracter recibido en el buffer circular de RX pendiente de procesamiento por el programa principal
uint8_t uart_hay_caracter(void) {
    return (uart_rx_cabeza != uart_rx_cola);
}

// Pertenece a uart.c.
// Obtiene un caracter recibido desde el buffer circular. Devuelve 1 si pudo leer y 0 si no habia datos disponibles
uint8_t uart_leer_caracter(char *dato) {
    if (uart_rx_cabeza == uart_rx_cola) {return 0;}

    *dato = uart_rx_buffer[uart_rx_cola];
    uart_rx_cola = (uint8_t)((uart_rx_cola + 1) % UART_RX_TAM);

    return 1;
}
