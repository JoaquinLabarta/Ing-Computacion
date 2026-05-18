#ifndef LCD_H
#define LCD_H

//El LCD trabaja en modo 4 bits usando DB4..DB7

#ifndef F_CPU
#define F_CPU 16000000UL
#endif

#include <avr/io.h>
#include <util/delay.h>
#include <stdint.h>

//Pines de control del LCD
#define LCD_RS PD1
#define LCD_E PD0

//Pines de datos del LCD en modo 4 bits
#define LCD_D4 PC1
#define LCD_D5 PC2
#define LCD_D6 PB2
#define LCD_D7 PB1

//Puertos usados por el LCD
#define LCD_CONTROL_PORT PORTD
#define LCD_CONTROL_DDR DDRD
#define LCD_DATA_PORT_B PORTB
#define LCD_DATA_DDR_B DDRB
#define LCD_DATA_PORT_C PORTC
#define LCD_DATA_DDR_C DDRC

//Comandos basicos
#define LCD_CLR 0
#define LCD_HOME 1
#define LCD_DDRAM 7
#define LCD_LINE_LENGTH 16
#define LCD_LINE0_DDRAMADDR 0x00
#define LCD_LINE1_DDRAMADDR 0x40

//Prototipos publicos del modulo LCD
void LCDsendChar(uint8_t ch);
void LCDsendCommand(uint8_t cmd);
void LCDinit(void);
void LCDclr(void);
void LCDhome(void);
void LCDstring(uint8_t *data, uint8_t nBytes);
void LCDGotoXY(uint8_t x, uint8_t y);
void LCDcursorOFF(void);
void LCDblank(void);
void LCDvisible(void);
void LCD_Init(void);
void LCD_WriteFixedLine(uint8_t line, const char *text);

#endif