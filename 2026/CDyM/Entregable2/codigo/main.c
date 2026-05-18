#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>
#include "lcd.h"

//Constantes
#define true 1
#define false 0
#define TECLA_NONE 0
#define MAX_TIEMPO_SEGUNDOS 5999U
#define LCD_COLUMNS 16

//Pines de LEDs indicadores
#define LED_ALARMA_PIN PC5
#define LED_INTERIOR_PIN PC4
#define LED_MAGNETRON_PIN PB5

//Pines del teclado matricial 4x4
#define teclado_FILA0_PIN PB4
#define teclado_FILA1_PIN PB3
#define teclado_FILA2_PIN PB0
#define teclado_FILA3_PIN PD7
#define teclado_COL0_PIN PD3
#define teclado_COL1_PIN PD5
#define teclado_COL2_PIN PD4
#define teclado_COL3_PIN PD2

//Mensajes temporales del LCD.
#define MSG_NONE 0
#define MSG_PUERTA_ABIERTA 1
#define MSG_TIEMPO_CERO 2
#define MSG_INVALIDO 3

//Estados de la maquina de estados del microondas
typedef enum {
	LIBRE,
	COCINANDO,
	PAUSADO,
	TERMINADO
} micro_estados_t;

// Flags compartidos con la ISR del Timer0
static volatile uint8_t flag_teclado_10ms = 0;
static volatile uint8_t flag_MEF_100ms = 0;
static volatile uint8_t flag_Blink_500ms = 0;
static volatile uint8_t flag_OneSecond = 0;

//Variables privadas del teclado
static char teclado_event = TECLA_NONE;
static char teclado_candidate = TECLA_NONE;
static uint8_t teclado_stable_count = 0;
static uint8_t teclado_pressed_lock = false;

//Variables privadas de la aplicacion
static micro_estados_t Estado_sistema = LIBRE;
static uint16_t Tiempo_coccion_segundos = 0;
static uint8_t Tiempo_digitos[4] = {0, 0, 0, 0};
static uint8_t Puerta_abierta = false;
static uint8_t Pantalla_sucia = true;
static uint8_t Parpadeo = true;
static uint8_t Finalizado_segundos_transcurridos = 0;
static uint16_t Contador_llamados_estado = 0;
static uint8_t Mensaje_code = MSG_NONE;
static uint8_t Mensaje_ticks_100ms = 0;

//Prototipos privados
static void MCU_Init(void);
static void TIMER0_Init_1ms(void);
static void teclado_Init(void);
static void teclado_Actualizar(void);
static char teclado_ObtenerEvento(void);
static char teclado_LeerMatriz(void);
static void teclado_FilasHigh(void);
static void teclado_FilaLow(uint8_t row);
static uint8_t teclado_IsColumnaLow(uint8_t column);
static void teclado_Estabilizar(void);
static void micro_Init(void);
static void micro_Actualizar(void);
static void micro_ProcesarTecla(char tecla);
static void micro_TareaPorSegundo(void);
static void micro_Parpadear(void);
static void micro_CambiarEstado(micro_estados_t nuevo_estado);
static void micro_LimpiarTiempo(void);
static void micro_IngresarDigito(uint8_t digit);
static uint16_t micro_DigitoASegundos(void);
static void micro_CargarDigitos(uint16_t total_segundos);
static void micro_30segundos(void);
static void micro_EmpezarCoccion(void);
static void micro_ActualizarLeds(void);
static void micro_ActualizarDisplay(void);
static void micro_Escribir(uint8_t code);

//ISR del Timer0. Ocurre cada 1 ms y solo levanta flags de tareas periodicas
ISR(TIMER0_COMPA_vect) {
	static uint8_t count_10ms = 0;
	static uint8_t count_100ms = 0;
	static uint16_t count_500ms = 0;
	static uint16_t count_1000ms = 0;

	count_10ms++;
	if (count_10ms >= 10) {count_10ms = 0; flag_teclado_10ms = 1;}

	count_100ms++;
	if (count_100ms >= 100) {count_100ms = 0; flag_MEF_100ms = 1;}

	count_500ms++;
	if (count_500ms >= 500) {count_500ms = 0; flag_Blink_500ms = 1;}

	count_1000ms++;
	if (count_1000ms >= 1000) {count_1000ms = 0; flag_OneSecond = 1;}
}

//Main principal
int main(void) {
	cli();

	MCU_Init();
	LCD_Init();
	teclado_Init();
	micro_Init();
	TIMER0_Init_1ms();

	sei();

	while (1) {
		if (flag_teclado_10ms != 0) {flag_teclado_10ms = 0; teclado_Actualizar();}

		if (flag_OneSecond != 0) {flag_OneSecond = 0; micro_TareaPorSegundo();}

		if (flag_Blink_500ms != 0) {flag_Blink_500ms = 0; micro_Parpadear();}

		if (flag_MEF_100ms != 0) {flag_MEF_100ms = 0; micro_Actualizar();}
	}
	return 0;
}

//Inicializa los puertos del microcontrolador
//Apaga los LEDs del magnetron, interior y alarma al arrancar
static void MCU_Init(void) {
	DDRB = 0x00; DDRC = 0x00; DDRD = 0x00;

	PORTB = 0x00; PORTC = 0x00; PORTD = 0x00;

	DDRB |= (1 << LED_MAGNETRON_PIN);
	DDRC |= (1 << LED_ALARMA_PIN) | (1 << LED_INTERIOR_PIN);

	PORTB &= ~(1 << LED_MAGNETRON_PIN);
	PORTC &= ~((1 << LED_ALARMA_PIN) | (1 << LED_INTERIOR_PIN));
}

//Configura el Timer0 en modo CTC para generar una interrupcion cada 1 ms
//Ese tick se usa como base de tiempo para teclado, MEF, parpadeo y cuenta de segundos
static void TIMER0_Init_1ms(void) {
	TCCR0A = 0x00; TCCR0B = 0x00; 
	TCNT0 = 0; //Tope minimo

	/*
	Como el timer0 es de 8 bits, solo puede contar hasta 255, debo elegir un prescaler acorde que permita dividir el reloj de 16MHz 
	en partes exactas para que un timer de 8 bits genere un retraso de 1ms sin usar decimales.
	OCROA = 16MHz / (Prescaler * Fclk) = 16MHz / (P * 1mS) = 249
	*/
	OCR0A = 249; //Tope maximo
	TCCR0A |= (1 << WGM01); //Modo CTC -> Clear Timer on Compare Match
	TIMSK0 |= (1 << OCIE0A); // Habilita interrupcion por evento, no por desbordamiento (filmina)
	TCCR0B |= (1 << CS01) | (1 << CS00); //Configuracion de prescaler = 64
}

//Configura el teclado matricial: filas como salidas y columnas como entradas con pullup
//Al final deja todas las filas en alto, que es el estado de reposo del teclado
static void teclado_Init(void) {
	DDRB |= (1 << teclado_FILA0_PIN) | (1 << teclado_FILA1_PIN) | (1 << teclado_FILA2_PIN);
	DDRD |= (1 << teclado_FILA3_PIN);

	DDRD &= ~((1 << teclado_COL0_PIN) | (1 << teclado_COL1_PIN) |
	(1 << teclado_COL2_PIN) | (1 << teclado_COL3_PIN));

	PORTD |= (1 << teclado_COL0_PIN) | (1 << teclado_COL1_PIN) |
	(1 << teclado_COL2_PIN) | (1 << teclado_COL3_PIN);

	teclado_FilasHigh();
}

//Lee el teclado cada 10 ms y aplica antirrebote por software
//Solo genera un evento cuando una tecla se mantiene estable varias lecturas
static void teclado_Actualizar(void) {
	char raw_tecla = teclado_LeerMatriz();

	if (raw_tecla == TECLA_NONE) {teclado_pressed_lock = false; teclado_candidate = TECLA_NONE; teclado_stable_count = 0;}
	else {
		if (raw_tecla == teclado_candidate) {
			if (teclado_stable_count < 10) {teclado_stable_count++;}

			if ((teclado_stable_count >= 3) && (teclado_pressed_lock == false)) {
				if (teclado_event == TECLA_NONE) {teclado_event = raw_tecla;}
				teclado_pressed_lock = true;
			}
		}
		else {teclado_candidate = raw_tecla; teclado_stable_count = 1;
		}
	}
}

//Devuelve la ultima tecla validada por el antirrebote
//Despues de leerla, borra el evento para no procesar la misma tecla dos veces
static char teclado_ObtenerEvento(void) {
	char tecla = teclado_event;
	teclado_event = TECLA_NONE;
	return tecla;
}

//Escanea la matriz del teclado activando una fila por vez
//Si detecta una columna en bajo, devuelve el caracter correspondiente
static char teclado_LeerMatriz(void) {
	static const char TECLAmap[4][4] =
	{
		{'1', '2', '3', 'A'},
		{'4', '5', '6', 'B'},
		{'7', '8', '9', 'C'},
		{'*', '0', '#', 'D'}
	};

	uint8_t row;
	uint8_t column;
	char found_tecla=found_tecla = TECLA_NONE;

	for (row = 0; row < 4; row++) {
		teclado_FilasHigh();
		teclado_FilaLow(row);
		teclado_Estabilizar();

		for (column = 0; column < 4; column++) {
			if (teclado_IsColumnaLow(column) != false) {found_tecla = TECLAmap[row][column]; break;}
		}

		if (found_tecla != TECLA_NONE){
			break;
		}
	}

	teclado_FilasHigh();
	return found_tecla;
}

//Coloca todas las filas del teclado en nivel alto
//Se usa como estado de reposo antes de seleccionar una fila para leer
static void teclado_FilasHigh(void) {
	PORTB |= (1 << teclado_FILA0_PIN) | (1 << teclado_FILA1_PIN) | (1 << teclado_FILA2_PIN);
	PORTD |= (1 << teclado_FILA3_PIN);
}

//Coloca una sola fila del teclado en nivel bajo
//Permite saber en que fila esta la tecla presionada durante el escaneo
static void teclado_FilaLow(uint8_t row) {
	switch (row)
	{
		case 0: PORTB &= ~(1 << teclado_FILA0_PIN); break;

		case 1: PORTB &= ~(1 << teclado_FILA1_PIN); break;

		case 2: PORTB &= ~(1 << teclado_FILA2_PIN); break;

		case 3: PORTD &= ~(1 << teclado_FILA3_PIN); break;

		default: break;
	}
}

//Lee una columna del teclado y devuelve true si esta en nivel bajo
//Como las columnas tienen pull-up, nivel bajo significa tecla presionada
static uint8_t teclado_IsColumnaLow(uint8_t column) {
	switch (column)
	{
		case 0: return ((PIND & (1 << teclado_COL0_PIN)) == 0) ? true : false;

		case 1: return ((PIND & (1 << teclado_COL1_PIN)) == 0) ? true : false;

		case 2: return ((PIND & (1 << teclado_COL2_PIN)) == 0) ? true : false;

		case 3: return ((PIND & (1 << teclado_COL3_PIN)) == 0) ? true : false;

		default: return false;
	}
}

//Hace una espera muy corta para que se estabilicen los niveles del teclado
//Se usa despues de cambiar la fila activa antes de leer las columnas
static void teclado_Estabilizar(void) {
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
	asm volatile("nop");
}

//Inicializa las variables principales de la aplicacion del microondas
//Deja el sistema en estado LIBRE, con puerta cerrada, tiempo en 00:00 y LEDs actualizados
static void micro_Init(void) {
	Estado_sistema = LIBRE;
	Puerta_abierta = false;
	Parpadeo = true;
	Mensaje_code = MSG_NONE;
	Mensaje_ticks_100ms = 0;
	Contador_llamados_estado = 0;
	micro_LimpiarTiempo();
	micro_ActualizarLeds();
	micro_ActualizarDisplay();
	Pantalla_sucia = false;
}

//Actualiza periodicamente la maquina de estados del microondas
//Procesa mensajes temporales, lee teclas nuevas, actualiza LEDs y refresca el LCD si hace falta
static void micro_Actualizar(void) {
	char tecla;
	Contador_llamados_estado++;
	if (Mensaje_ticks_100ms != 0) {
		Mensaje_ticks_100ms--;
		if (Mensaje_ticks_100ms == 0) {
			Mensaje_code = MSG_NONE;
			Pantalla_sucia = true;
		}
	}

	tecla = teclado_ObtenerEvento();
	if (tecla != TECLA_NONE) {micro_ProcesarTecla(tecla);}

	micro_ActualizarLeds();

	if (Pantalla_sucia != false) {micro_ActualizarDisplay(); Pantalla_sucia = false;}
}

//Procesa una tecla recibida como entrada de la MEF
//Segun la tecla y el estado actual, ingresa tiempo, inicia, pausa, cancela o simula puerta
static void micro_ProcesarTecla(char tecla) {
	if ((tecla >= '0') && (tecla <= '9')) {
		if (Estado_sistema == LIBRE) {micro_IngresarDigito((uint8_t)(tecla - '0'));}
		return;
	}

	switch (tecla){
		case 'A': if ((Estado_sistema == LIBRE) || (Estado_sistema == PAUSADO)) {micro_EmpezarCoccion();} break;

		case 'B':
		if (Estado_sistema == LIBRE){
			micro_LimpiarTiempo();
		}
		else if (Estado_sistema == COCINANDO){
			micro_CambiarEstado( PAUSADO);
		}
		else if (Estado_sistema == PAUSADO){
			micro_LimpiarTiempo();
			micro_CambiarEstado(LIBRE);
		}
		else if (Estado_sistema == TERMINADO){
			micro_LimpiarTiempo();
			micro_CambiarEstado(LIBRE);
		}
		break;

		case 'C':
		if (Estado_sistema == TERMINADO){
			micro_LimpiarTiempo();
			micro_CambiarEstado(LIBRE);
		}

		micro_30segundos();

		if (Estado_sistema == LIBRE){
			micro_EmpezarCoccion();
		}
		break;

		case 'D':
		Puerta_abierta = (Puerta_abierta == false) ? true : false;

		if ((Puerta_abierta == true) && (Estado_sistema == COCINANDO)){
			micro_CambiarEstado(PAUSADO);
		}

		Pantalla_sucia = true;
		break;

		default: break;
	}
}

//Tarea que se ejecuta cada 1 segundo
//Descuenta el tiempo de coccion o cuenta los 5 segundos del estado TERMINADO
static void micro_TareaPorSegundo(void) {
	if (Estado_sistema == COCINANDO) {
		if (Tiempo_coccion_segundos > 0){
			Tiempo_coccion_segundos--;
			micro_CargarDigitos(Tiempo_coccion_segundos);
			Pantalla_sucia = true;
		}

		if (Tiempo_coccion_segundos == 0) {
			Finalizado_segundos_transcurridos = 0;
			Parpadeo = true;
			micro_CambiarEstado( TERMINADO);
		}
	}
	else if (Estado_sistema == TERMINADO) {
		if (Finalizado_segundos_transcurridos < 5) {
			Finalizado_segundos_transcurridos++;
		}

		if (Finalizado_segundos_transcurridos >= 5) {
			micro_LimpiarTiempo();
			micro_CambiarEstado( LIBRE);
			Parpadeo = true;
		}
	}
}

//Tarea de parpadeo usada al finalizar la coccion
//Invierte la variable Parpadeo cada 500 ms mientras el estado sea TERMINADO
static void micro_Parpadear(void) {
	if (Estado_sistema == TERMINADO) {
		Parpadeo = (Parpadeo == true) ? false : true;
		Pantalla_sucia = true;
	}
	else {Parpadeo = true;}
}

//Cambia el estado actual de la maquina de estados
//Tambien reinicia el contador del estado y marca que hay que actualizar el display
static void micro_CambiarEstado(micro_estados_t nuevo_estado) {
	Estado_sistema = nuevo_estado;
	Contador_llamados_estado = 0;
	Pantalla_sucia = true;
}

//Borra el tiempo cargado por el usuario
//Deja los digitos y el tiempo total en cero para mostrar 00:00
static void micro_LimpiarTiempo(void) {
	Tiempo_digitos[0] = 0;
	Tiempo_digitos[1] = 0;
	Tiempo_digitos[2] = 0;
	Tiempo_digitos[3] = 0;
	Tiempo_coccion_segundos = 0;
	Pantalla_sucia = true;
}

//Ingresa un digito nuevo en formato MMSS desplazando los anteriores
//Si el campo de segundos queda mayor a 59, rechaza el ingreso y muestra error
static void micro_IngresarDigito(uint8_t digit) {
	uint8_t new_digits[4];
	uint8_t segundos_field;

	new_digits[0] = Tiempo_digitos[1];
	new_digits[1] = Tiempo_digitos[2];
	new_digits[2] = Tiempo_digitos[3];
	new_digits[3] = digit;

	segundos_field = (uint8_t)((new_digits[2] * 10) + new_digits[3]);

	if (segundos_field > 59) {micro_Escribir(MSG_INVALIDO); return;}

	Tiempo_digitos[0] = new_digits[0];
	Tiempo_digitos[1] = new_digits[1];
	Tiempo_digitos[2] = new_digits[2];
	Tiempo_digitos[3] = new_digits[3];

	Tiempo_coccion_segundos = micro_DigitoASegundos();
	Pantalla_sucia = true;
}

//Convierte los cuatro digitos MMSS a segundos totales
//Se usa para trabajar internamente con una sola variable de tiempo
static uint16_t micro_DigitoASegundos(void) {
	uint16_t minutes;
	uint16_t segundos;

	minutes = (uint16_t)((Tiempo_digitos[0] * 10) + Tiempo_digitos[1]);
	segundos = (uint16_t)((Tiempo_digitos[2] * 10) + Tiempo_digitos[3]);

	return (uint16_t)((minutes * 60U) + segundos);
}

//Carga los cuatro digitos MMSS a partir de una cantidad total de segundos
//Sirve para actualizar el display cuando se descuenta tiempo o se suma +30 s
static void micro_CargarDigitos(uint16_t total_segundos) {
	uint8_t minutes;
	uint8_t segundos;

	if (total_segundos > MAX_TIEMPO_SEGUNDOS) {total_segundos = MAX_TIEMPO_SEGUNDOS;}

	minutes = (uint8_t)(total_segundos / 60U);
	segundos = (uint8_t)(total_segundos % 60U);

	Tiempo_digitos[0] = (uint8_t)(minutes / 10U);
	Tiempo_digitos[1] = (uint8_t)(minutes % 10U);
	Tiempo_digitos[2] = (uint8_t)(segundos / 10U);
	Tiempo_digitos[3] = (uint8_t)(segundos % 10U);
}

//Suma 30 segundos al tiempo actual de coccion
//Si se supera el maximo permitido, el tiempo queda en 99:59
static void micro_30segundos(void) {
	if (Tiempo_coccion_segundos > (MAX_TIEMPO_SEGUNDOS - 30U)) {Tiempo_coccion_segundos = MAX_TIEMPO_SEGUNDOS;}
	else {Tiempo_coccion_segundos = (uint16_t)(Tiempo_coccion_segundos + 30U);}

	micro_CargarDigitos(Tiempo_coccion_segundos);
	Pantalla_sucia = true;
}

//Intenta iniciar o reanudar la coccion
//No permite arrancar si la puerta esta abierta o si el tiempo es 00:00
static void micro_EmpezarCoccion(void) {
	if (Puerta_abierta == true) { micro_Escribir(MSG_PUERTA_ABIERTA); return;}

	if (Tiempo_coccion_segundos == 0) {micro_Escribir(MSG_TIEMPO_CERO); return;}

	micro_CambiarEstado(COCINANDO);
}

//Actualiza los LEDs segun el estado actual del microondas
//Controla magnetron, luz interior y alarma de fin de coccion
static void micro_ActualizarLeds(void) {
	if ((Estado_sistema == COCINANDO) && (Puerta_abierta == false)) {PORTB |= (1 << LED_MAGNETRON_PIN);}
	else {PORTB &= ~(1 << LED_MAGNETRON_PIN);}

	if ((Estado_sistema == COCINANDO) || (Estado_sistema == PAUSADO)  || (Puerta_abierta == true)) {PORTC |= (1 << LED_INTERIOR_PIN);}
	else {PORTC &= ~(1 << LED_INTERIOR_PIN);}

	if ((Estado_sistema == TERMINADO) && (Parpadeo == true)) {PORTC |= (1 << LED_ALARMA_PIN);}
	else {PORTC &= ~(1 << LED_ALARMA_PIN);}
}

//Actualiza las dos lineas del LCD con el tiempo y el estado del sistema
//Tambien muestra mensajes temporales y maneja el parpadeo visual al terminar
static void micro_ActualizarDisplay(void) {
	char line1[17];
	const char *line2;
	uint8_t minutes;
	uint8_t segundos;
	uint8_t i;

	if ((Estado_sistema == TERMINADO) && (Parpadeo == false)) {LCD_WriteFixedLine(0, "                "); LCD_WriteFixedLine(1, "                "); return;}

	minutes = (uint8_t)(Tiempo_coccion_segundos / 60U);
	segundos = (uint8_t)(Tiempo_coccion_segundos % 60U);

	line1[0] = (char)('0' + (minutes / 10U));
	line1[1] = (char)('0' + (minutes % 10U));
	line1[2] = ':';
	line1[3] = (char)('0' + (segundos / 10U));
	line1[4] = (char)('0' + (segundos % 10U));

	for (i = 5; i < 16; i++) {line1[i] = ' ';} 

	line1[16] = '\0';

	if (Mensaje_ticks_100ms != 0) {
		if (Mensaje_code == MSG_PUERTA_ABIERTA) {line2 = "PUERTA ABIERTA";}
		else if (Mensaje_code == MSG_TIEMPO_CERO) {line2 = "TIEMPO 00:00";}
		else if (Mensaje_code == MSG_INVALIDO){line2 = "SEGUNDOS > 59";}
		else {line2 = "MENSAJE";}
	}
	else {
		switch (Estado_sistema) {
			case LIBRE: line2 = (Puerta_abierta == true) ? "PUERTA ABIERTA" : "INGRESE TIEMPO"; break;

			case COCINANDO: line2 = "COCINANDO"; break;

			case PAUSADO: line2 = (Puerta_abierta == true) ? "PAUSA PUERTA" : "PAUSADO"; break;

			case TERMINADO: line2 = "FIN COCCION"; break;

			default: line2 = "ERROR ESTADO"; break;
		}
	}

	LCD_WriteFixedLine(0, line1);
	LCD_WriteFixedLine(1, line2);
}

//Activa un mensaje temporal en la segunda linea del LCD
//El mensaje dura 1 segundo y luego vuelve a mostrarse el estado normal
static void micro_Escribir(uint8_t code) {
	Mensaje_code = code;
	Mensaje_ticks_100ms = 10;
	Pantalla_sucia = true;
}