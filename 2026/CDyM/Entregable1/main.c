#include <avr/io.h>
#define F_CPU 16000000UL
#include <util/delay.h>
#include <stdbool.h>

void enviar_bit(bool bit) {
	if (bit) {

		// T1H = 0,8us = 800ns
		PORTB |= (1 << PINB0); // cada asignacion de puertos consume dos ciclos de reloj 
		asm("nop"); asm("nop"); asm("nop"); asm("nop"); asm("nop"); // 312,5ns

		// T1L = 0,45us = 450ns
		PORTB &= ~(1 << PINB0);

	} else {

		// T0H = 0,4us = 400ns
		PORTB |= (1 << PINB0);

		// T0L = 0,85us = 850ns
		PORTB &= ~(1 << PINB0);
	}
}

void enviar_byte(uint8_t byte) {
	enviar_bit(byte & 0b10000000); enviar_bit(byte & 0b01000000);
	enviar_bit(byte & 0b00100000); enviar_bit(byte & 0b00010000);
	enviar_bit(byte & 0b00001000); enviar_bit(byte & 0b00000100);
	enviar_bit(byte & 0b00000010); enviar_bit(byte & 0b00000001);
}

void enviar_color(uint8_t r, uint8_t g, uint8_t b) {
	enviar_byte(g); enviar_byte(r); enviar_byte(b);
}

int main(void) {

    DDRD = 0xFF;
	DDRC &= ~((1 << PORTC0) | (1 << PORTC1)); // Usando el AND mantiene todos los puertos con el valor original, menos el PORTC0 y PORTC1 que los pone en 0 (entrada)
	PORTC |= ((1 << PORTC0) | (1 << PORTC1)); // Pone el valor 00000011 en PORTC0, mantiene alta impedancia cuando pulsas se va a ground.
	DDRB |= (1 << PORTB0);

    /* DDRX: Configuración
    PORTX: Escritura
    PINX: Lectura */

	bool secuencia1 = true;
    bool secuencia2 = true;
	bool estado_anterior_btn1 = false; // Presionado TRUE
    bool estado_anterior_btn2 = false;
	bool bajar = false;
    bool pei = true;
	
	uint8_t i = 0;
	uint8_t k = 7;
	uint8_t timer_leds = 2;    // Contador para 100ms
	uint8_t timer_neo = 3;     // Contador para 150ms

	while (1) {

		if (timer_leds >= 2) { // Cada 100ms (2 ciclos de 50ms)

			// 1a-Enciende un LED a la vez y lo hace desde el LSB hacia el MSB repetitivamente.
            if (secuencia1){
                if (i >= 8) i = 0;

                PORTD = (1 << i);

                i++;
            }

            // 1b-Enciende un LED a la vez empezando desde el MSB y rebotando en los extremos repetitivamente
            else {
                if (i <= 0) bajar = false;
                else if (i == 7) bajar = true;

                PORTD = (1 << i);

                if (bajar) i--;
                else i++;
            }
			timer_leds = 0;
		}

		// Logica neopixel (Cada 150ms -> 3 ciclos de 50ms) ---
		if (timer_neo >= 3) {

			// 3c-Enciende LEDs pares en rojo y luego LEDs impares en color azul repetidamente.
			if (secuencia2) {
				if (pei) {
					//enviar_color (ROJO, VERDE, AZUL)
					enviar_color(255, 0, 0); // LED 0
					enviar_color(0, 0, 255); // LED 1
					enviar_color(255, 0, 0); // LED 2
					enviar_color(0, 0, 255); // LED 3
					enviar_color(255, 0, 0); // LED 4
					enviar_color(0, 0, 255); // LED 5
					enviar_color(255, 0, 0); // LED 6
					enviar_color(0, 0, 255); // LED 7
				} else {
					enviar_color(0, 0, 255); // LED 0
					enviar_color(255, 0, 0); // LED 1
					enviar_color(0, 0, 255); // LED 2
					enviar_color(255, 0, 0); // LED 3
					enviar_color(0, 0, 255); // LED 4
					enviar_color(255, 0, 0); // LED 5
					enviar_color(0, 0, 255); // LED 6
					enviar_color(255, 0, 0); // LED 7
				}

				pei = !pei;
			
			// 3d-Enciende en color verde un LED a la vez de derecha a izquierda repetitivamente
			} else {
				enviar_color(0, (k == 0 ? 255:0), 0);
				enviar_color(0, (k == 1 ? 255:0), 0);
				enviar_color(0, (k == 2 ? 255:0), 0);
				enviar_color(0, (k == 3 ? 255:0), 0);
				enviar_color(0, (k == 4 ? 255:0), 0);
				enviar_color(0, (k == 5 ? 255:0), 0);
				enviar_color(0, (k == 6 ? 255:0), 0);
				enviar_color(0, (k == 7 ? 255:0), 0);

				if(k <= 0) k = 8;
				k--;
			}
			timer_neo = 0;
		}

		//Logica botones
		bool btn1_actual = !(PINC & (1 << PINC0));
        
		if (btn1_actual && !estado_anterior_btn1) { // Si está presionado y antes no lo estaba
			secuencia1 = !secuencia1;
			i = ((secuencia1) ? 0:7);
		}
		estado_anterior_btn1 = btn1_actual;

		bool btn2_actual = !(PINC & (1 << PINC1));
		if (btn2_actual && !estado_anterior_btn2) {
			secuencia2 = !secuencia2;
			k = 7;
		}
		estado_anterior_btn2 = btn2_actual;

		_delay_ms(50); // Base de tiempo mínima
		timer_leds++;
		timer_neo++;
	}
	return 0;
}