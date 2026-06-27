#ifndef COMANDOS_H
#define COMANDOS_H

#include <stdint.h>

#define COMANDO_TAM 32   // Tamanio maximo de comando recibido por terminal

#define TM_MIN_SEGUNDOS 2   // Minimo pedido por enunciado para SET_TM
#define TM_MAX_SEGUNDOS 60   // Maximo pedido por enunciado para SET_TM

uint8_t es_digito (char c);
uint8_t convertir_numero (const char *texto, uint8_t *valor);
uint8_t parsear_hora (const char *texto, uint8_t *hora, uint8_t *minuto, uint8_t *segundo);
void procesar_comando_linea (char *linea);
void procesar_comandos_uart (void);

#endif
