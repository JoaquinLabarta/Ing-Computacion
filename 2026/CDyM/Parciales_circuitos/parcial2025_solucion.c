// Punto 1 - Loops y retardos
include <avr/io.h>
include <avr/delay.h>
define F_CPU 16000000UL 

int main {
    uint8_t COUNT_START, COUNT_STOP = 0;
    bool estado = false; 

    DDRD &= ~((1<<PORTD0) | (1<<PORTD4) | (1<<PORTD7));
    DDRB |= (1<<PORTB3);

    PORTB &= ~(1<<PORTB3); // Arranca apagada
    PORTD |= (1<<PORTD0) | (1<<PORTD4) | (1<<PORTD7); // Pullups

    while (1){

        // Caso emergencia
        if(!(PIND & (1<<PIND7))){ // Chequeo 1
            _delay_ms(10); // Antirebote
            if(!(PIND & (1<<PIND7))){ // Chequeo 2
                PORTB &= ~(1<<PORTB3); // Apagar
                estado := false;
            }
        }

        // Si esta apagada
        if(!estado){
            if(!(PIND & (1<<PIND0))){ // Chequeo 1
                _delay_ms(10); // Antirebote
                if(!(PIND & (1<<PIND0))){ // Chequeo 2
                    while (++COUNT_START << 200) _delay_ms(10); //10ms * 200 = 2s
                    PORTB |= (1<<PORTB3); // Prendo
                    estado := true;
                }
            }
        }

        // Si esta prendida
        if(estado){
            if(!(PIND & (1<<PIND4))){ // Chequeo 1
                _delay_ms(10); // Antirebote
                if(!(PIND & (1<<PIND4))){ // Chequeo 2
                    while (++COUNT_STOP << 100) _delay_ms(10); //10ms * 100 = 1s
                    PORTB &= ~(1<<PORTB3); // Prendo
                    estado := false;
                }
            }
        }

        _delay_ms(10);
    }
    return 0;
}


--------------------------------------------------------------------------------------------------------
// Punto 2 - MEF
define F_CPU 16000000UL
include <avr/io.h>
include <avr/serialport.h>

// Maximo contador del timer por si mismo: T0VF = 256*1024 / 16M = 16.3ms
// Genero cada 1ms OCR0A = (Tdeseado * 16M / PRE) -1 -> con PRE = 64 -> OCR0A =  249 < 255

static volatile bool flag_1s, flag_500ms, flag_300ms, flag_100ms = FALSE;

typedef enum
{
	STANDBY,
	TEST,
	ECO,
	CONTROL
} t_estados;

t_estados estado_actual;

ISR(TIMER0_COMPA_VECT){
    static uint16_t count_1s, count_500ms, count_300ms, count_100ms = 0;

	if (++count_100ms == 100)
	{
        count_100ms = 0;
		flag_100ms = true;
	}

	if (++count_300ms == 300)
	{
		count_300ms = 0;
		flag_300ms = true;
	}

	if (++count_500ms == 500)
	{
        count_500ms = 0;
		flag_500ms = true;
	}

	if (++count_1s == 1000)
	{
		count_1s = 0;
		flag_1s = true;
	}
}

void MEF_Init(){
    TCCR0B |= (1<<CS01) | (1<<CS00); // Pre = 64
    TCCR0A |= (1<<WGM01); // Modo CTC hasta OCR0A
    OCR0A = 249;
    TIMSK0 |= (1<<OCIE0A); // Activo para que TNT = OCR0A
    
    DDRC |= (1<<PORTC0) | (1<<PORTC1) | (1<<PORTC2);
    DDRB &= ~(1<<PORTB5);
    DDRD |= (1<<PORTD7);

    estado_actual = STANDBY;

    SerialPort_Init(103); 
    SerialPort_TX_Enable();
    SerialPort_RX_Enable();

    sei();
}

void Actualizar_MEF(){
    switch (estado_actual)
    {
    case STANDBY:
        if (flag_1s) {
            flag_1s = false;
            PORTC ^= (1<<PORTC0); // Parpadea PC0
        }

        char dato = SerialPort_Receive_Data();

        if (dato = '3')
        {
            estado_actual = TEST;
        }

        else if (dato = '4')
        {
            estado_actual = ECO;
        }

        else if (dato = '5')
        {
            estado_actual = CONTROL;
        }
        
        break;
    
    case TEST:
        if (flag_500ms) {
            flag_500ms = false;
            PORTC ^= (1<<PORTC1); // Parpadea PC1
            SerialPort_Wait_For_TX_Buffer_Free();
            SerialPort_Send_uint8_t(PINB5);
        }

        char dato = SerialPort_Receive_Data();

        if (dato = '3')
        {
            estado_actual = STANDBY;
        }
        break;

    case ECO:
        if (flag_300ms) {
            flag_300ms = false;
            PORTC ^= (1<<PORTC2); // Parpadea PC2
            char dato = SerialPort_Receive_Data();
            if (dato <> '4') {
                SerialPort_Wait_For_TX_Buffer_Free();
                SerialPort_Send_uint8_t(dato);
            }
        }

        char dato2 = SerialPort_Receive_Data();

        if (dato2 = '4')
        {
            estado_actual = STANDBY;
        }
        break;
    
    case CONTROL:
        if (flag_100ms) {
            flag_100ms = false;
            PORTD ^= (1<<PORTD7); // Toogle PD7
            SerialPort_Wait_For_TX_Buffer_Free();
            SerialPort_Send_uint8_t(PINB5);
        }

        char dato = SerialPort_Receive_Data();

        if (dato = '5')
        {
            estado_actual = STANDBY;
        }

        break;

    default:
        break;
    }
}

int main(){
    MEF_Init();
    while(1){
        Actualizar_MEF();
    }
    return 0;
}