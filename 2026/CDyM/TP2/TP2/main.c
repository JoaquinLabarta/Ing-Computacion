#define F_CPU 16000000UL
#include <xc.h>
#include <avr/io.h>
#include <util/delay.h>
#include "lcd.h"


int main(void)
{
	LCD_Init();
	_delay_ms(500);
	LCDGotoXY(0,0);
	LCDstring((uint8_t*)"HOLA",4);
    while(1)
    {
    }
}