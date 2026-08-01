#include <avr/interrupt.h>
#include <avr/io.h>
#include <stdint.h>
#include "uart.h"
#include "timer.h"
#include "sensor_luz.h"
#include "pwm_rgb.h"
#include "control_rgb.h"
#include "comandos.h"

#define INTERVALO_LECTURA_LUZ_MS 100   // El LDR se actualiza diez veces por segundo

static void placa_iniciar (void);

// Configura la direccion inicial de los terminales usados por el LED, el LDR y la UART0
static void placa_iniciar (void) {
    DDRB |= (1 << DDB5) | (1 << DDB2) | (1 << DDB1);   // PB5=R, PB2=G y PB1=B como salidas
    PORTB |= (1 << PORTB5) | (1 << PORTB2) | (1 << PORTB1);   // Anodo comun: nivel alto apaga el LED

    DDRC &= ~(1 << DDC3);   // PC3/ADC3 como entrada para el divisor del LDR
    PORTC &= ~(1 << PORTC3);   // Pull-up interno deshabilitado para no alterar el divisor resistivo

    DDRD &= ~(1 << DDD0);   // RXD como entrada
    DDRD |= (1 << DDD1);   // TXD como salida
}

// Inicializa los perifericos y ejecuta en background las tareas de comandos, desvanecimiento y lectura de luz
int main (void) {
    uint16_t lectura_luz;
    uint16_t contador_lectura_luz_ms = 0;

    placa_iniciar();
    uart_iniciar();
    sensor_luz_iniciar();

    lectura_luz = sensor_luz_leer();   // Primera lectura para comenzar con un periodo acorde a la iluminacion

    pwm_rgb_iniciar();
    control_rgb_iniciar(sensor_luz_calcular_periodo_ms(lectura_luz));
    timer2_iniciar();

    sei();

    uart_enviar_cadena("Control de LED RGB iniciado\r\n");
    uart_enviar_cadena("Comando: SET_COLOR=R,G,B con valores de 0 a 255\r\n");

    while (1) {
        procesar_comandos_uart();

        while (obtener_milisegundo_pendiente()) {
            control_rgb_actualizar_1ms();

            contador_lectura_luz_ms++;

            if (contador_lectura_luz_ms >= INTERVALO_LECTURA_LUZ_MS) {
                contador_lectura_luz_ms = 0;

                lectura_luz = sensor_luz_leer();
                control_rgb_establecer_periodo(sensor_luz_calcular_periodo_ms(lectura_luz));
            }
        }
    }

    return 0;
}
