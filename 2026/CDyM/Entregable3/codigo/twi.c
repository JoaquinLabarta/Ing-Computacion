#include <avr/io.h>
#include <util/twi.h>                    // Incluye macros de estados TWI: TW_START, TW_MT_SLA_ACK, etc
#include <stdint.h>
#include "twi.h"

// Pertenece a twi.c.
// Inicializa el periferico TWI/I2C en modo maestro a 100 kHz aproximados,con prescaler 1 y reloj del sistema de 16 MHz
void twi_iniciar(void) {
    TWSR = 0x00;   // TWSR: prescaler TWI en 1 para calcular SCL con TWBR
    TWBR = (uint8_t)(((F_CPU / TWI_SCL_HZ) - 16) / 2);   // TWBR: define frecuencia SCL; con 16 MHz da 72 para 100 kHz
    TWCR = (1 << TWEN);   // TWCR/TWEN: habilita el periferico TWI
}

// Pertenece a twi.c.
// Espera que termine una operacion TWI mirando TWINT; usa timeout para que el sistema no quede bloqueado si el RTC o el bus fallan
uint8_t twi_esperar_fin (void) {
    uint32_t timeout = TWI_TIMEOUT;

    // TWCR/TWINT: se pone en 1 cuando termina la operacion TWI
    while (!(TWCR & (1 << TWINT))) {
        timeout--;

        if (timeout == 0) {return 0;}
    }

    return 1;
}

// Pertenece a twi.c.
// Genera condicion START en el bus I2C y verifica el estado devuelto por el hardware TWI
uint8_t twi_start (void) {
    uint8_t estado;

    TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN);  // TWCR/TWINT/TWSTA/TWEN: limpia flag, pide START y mantiene TWI activo

    if (!twi_esperar_fin()) {return 0;}

    estado = TWSR & 0xF8;   // TWSR: se enmascaran bits de prescaler para leer solo el estado TWI

    //TW_START/TW_REP_START: macros de util/twi.h para START valido
    if ((estado == TW_START) || (estado == TW_REP_START)) {return 1;}

    return 0;
}

// Pertenece a twi.c.
// Genera condicion STOP para liberar el bus I2C luego de una lectura o escritura sobre el RTC
void twi_stop (void) {
    TWCR = (1 << TWINT) | (1 << TWSTO) | (1 << TWEN);   // TWCR/TWINT/TWSTO/TWEN: limpia flag, genera STOP y deja TWI habilitado
}

// Pertenece a twi.c.
// Envia un byte por I2C y compara el estado obtenido contra el esperado, lo que permite detectar si el RTC respondi� con ACK
uint8_t twi_write (uint8_t dato, uint8_t estado_esperado) {
    uint8_t estado;

    TWDR = dato;   // TWDR: registro de datos TWI; se carga direccion o dato a transmitir
    TWCR = (1 << TWINT) | (1 << TWEN);   // TWCR/TWINT/TWEN: inicia transmision del byte cargado en TWDR

    if (!twi_esperar_fin()) {return 0;}

    estado = TWSR & 0xF8;   //TWSR: lectura del estado TWI sin bits de prescaler

    return (estado == estado_esperado);
}

// Pertenece a twi.c.
// Lee un byte desde I2C respondiendo ACK, util cuando todavia quedan mas bytes por leer desde el RTC
uint8_t twi_read_ack (uint8_t *dato) {
    uint8_t estado;

    TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWEA);   // TWCR/TWINT/TWEN/TWEA: lee byte y responde ACK al esclavo

    if (!twi_esperar_fin()) {return 0;}

    estado = TWSR & 0xF8;   // TWSR: estado TWI despues de recibir el byte

    // TW_MR_DATA_ACK: macro de util/twi.h para dato recibido con ACK
    if (estado != TW_MR_DATA_ACK) {return 0;}

    *dato = TWDR;   // TWDR: contiene el byte recibido desde el RTC

    return 1;
}

// Pertenece a twi.c.
// Lee un byte desde I2C respondiendo NACK, usado en el ultimo byte para indicar al RTC que la lectura termino
uint8_t twi_read_nack (uint8_t *dato) {
    uint8_t estado;

    TWCR = (1 << TWINT) | (1 << TWEN);   // TWCR/TWINT/TWEN: lee byte sin TWEA para responder NACK

    if (!twi_esperar_fin()) {return 0;}

    estado = TWSR & 0xF8;   // TWSR: estado TWI despues de recibir el ultimo byte. */

    // TW_MR_DATA_NACK: macro de util/twi.h para dato recibido con NACK
    if (estado != TW_MR_DATA_NACK) {return 0;}

    *dato = TWDR;   // TWDR: contiene el ultimo byte recibido desde el RTC

    return 1;
}
