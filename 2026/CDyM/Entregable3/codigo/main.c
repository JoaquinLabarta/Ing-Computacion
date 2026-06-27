#include <avr/interrupt.h>
#include "placa.h"
#include "uart.h"
#include "timer.h"
#include "twi.h"
#include "dht.h"
#include "comandos.h"
#include "monitor.h"

// Pertenece a main.c.
// Inicializa perifericos, habilita interrupciones y ejecuta el super-loop background que procesa comandos y reportes periodicos
int main (void) {
    placa_iniciar();
    uart_iniciar();
    timer0_iniciar();
    twi_iniciar();
    dht_iniciar();

    sei();

    uart_enviar_cadena("Monitor de invernadero iniciado\r\n");
    uart_enviar_cadena("Comandos: SET_TIME=HH:MM:SS | SET_TM=SS\r\n");

    while (1) {
        procesar_comandos_uart();

        if (obtener_segundo_pendiente()) {
            contador_reporte_s++;

            if (contador_reporte_s >= intervalo_reporte_s) {
                contador_reporte_s = 0;
                tarea_emitir_reporte();
            }
        }
    }

    return 0;
}
