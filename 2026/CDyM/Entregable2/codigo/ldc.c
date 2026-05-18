#include "lcd.h"

//RW no se configura porque esta conectado a GND. La secuencia de inicializacion de 4 bits se ajusta a la datasheet


//Prototipos privados del modulo LCD
static void LCD_EnablePulse(void);
static void LCD_WriteNibble(uint8_t nibble);

//Escribe un nibble en DB4..DB7 preservando los otros bits de PORTB/PORTC
static void LCD_WriteNibble(uint8_t nibble)
{
    if ((nibble & 0x01) != 0) LCD_DATA_PORT_C |=  (1 << LCD_D4);
    else                      LCD_DATA_PORT_C &= ~(1 << LCD_D4);

    if ((nibble & 0x02) != 0) LCD_DATA_PORT_C |=  (1 << LCD_D5);
    else                      LCD_DATA_PORT_C &= ~(1 << LCD_D5);

    if ((nibble & 0x04) != 0) LCD_DATA_PORT_B |=  (1 << LCD_D6);
    else                      LCD_DATA_PORT_B &= ~(1 << LCD_D6);

    if ((nibble & 0x08) != 0) LCD_DATA_PORT_B |=  (1 << LCD_D7);
    else                      LCD_DATA_PORT_B &= ~(1 << LCD_D7);

    LCD_EnablePulse();
}

//Genera el pulso de habilitacion E para que el LCD capture el dato
static void LCD_EnablePulse(void)
{
    LCD_CONTROL_PORT |= (1 << LCD_E);
    _delay_us(2);
    LCD_CONTROL_PORT &= ~(1 << LCD_E);
    _delay_us(2);
}

//Envia un caracter de 8 bits al LCD en dos escrituras de 4 bits
void LCDsendChar(uint8_t ch)
{
    LCD_CONTROL_PORT |= (1 << LCD_RS);
    LCD_WriteNibble(ch >> 4);
    LCD_WriteNibble(ch & 0x0F);
    _delay_us(60);
}

//Envia un comando de 8 bits al LCD en dos escrituras de 4 bits
void LCDsendCommand(uint8_t cmd)
{
    LCD_CONTROL_PORT &= ~(1 << LCD_RS);
    LCD_WriteNibble(cmd >> 4);
    LCD_WriteNibble(cmd & 0x0F);

    if ((cmd == 0x01) || (cmd == 0x02))
    {
        _delay_ms(2);
    }
    else
    {
        _delay_us(60);
    }
}

//Inicializa el LCD en modo 4 bits, 2 lineas, cursor apagado
void LCDinit(void)
{
    LCD_DATA_DDR_C |= (1 << LCD_D4) | (1 << LCD_D5);
    LCD_DATA_DDR_B |= (1 << LCD_D6) | (1 << LCD_D7);
    LCD_CONTROL_DDR |= (1 << LCD_E) | (1 << LCD_RS);

    LCD_CONTROL_PORT &= ~((1 << LCD_E) | (1 << LCD_RS));

    _delay_ms(20);

    LCD_CONTROL_PORT &= ~(1 << LCD_RS);

    LCD_WriteNibble(0x03);
    _delay_ms(5);

    LCD_WriteNibble(0x03);
    _delay_ms(1);

    LCD_WriteNibble(0x03);
    _delay_ms(1);

    LCD_WriteNibble(0x02);
    _delay_ms(1);

    LCDsendCommand(0x28);
    LCDsendCommand(0x08);
    LCDsendCommand(0x01);
    LCDsendCommand(0x06);
    LCDsendCommand(0x0C);
}

//Borra el display 
void LCDclr(void)
{
    LCDsendCommand(1 << LCD_CLR);
}

//Lleva el cursor a la posicion inicial de DDRAM
void LCDhome(void)
{
    LCDsendCommand(1 << LCD_HOME);
}

//Escribe nBytes caracteres desde RAM
void LCDstring(uint8_t *data, uint8_t nBytes)
{
    uint8_t i;
    if (data == 0) return;
    for (i = 0; i < nBytes; i++)
    {
        LCDsendChar(data[i]);
    }
}

//Posiciona el cursor usando las direcciones DDRAM de la datasheet
void LCDGotoXY(uint8_t x, uint8_t y)
{
    uint8_t ddram_address;
    if (y == 0)
    {
        ddram_address = LCD_LINE0_DDRAMADDR + x;
    }
    else
    {
        ddram_address = LCD_LINE1_DDRAMADDR + x;
    }
    LCDsendCommand((1 << LCD_DDRAM) | ddram_address);
}

//Deja display encendido y cursor apagado
void LCDcursorOFF(void)
{
    LCDsendCommand(0x0C);
}

//Apaga visualmente el LCD sin borrar DDRAM
void LCDblank(void)
{
    LCDsendCommand(0x08);
}

//Vuelve a encender visualmente el LCD
void LCDvisible(void)
{
    LCDsendCommand(0x0C);
}

//Inicializa, borra y posiciona el cursor al inicio
void LCD_Init(void)
{
    LCDinit();
    LCDclr();
    LCDhome();
    LCDGotoXY(0, 0);
}

//Escribe una linea completa de 16 caracteres y rellena con espacios
void LCD_WriteFixedLine(uint8_t line, const char *text)
{
    uint8_t i;
    uint8_t ended;
    char c;
    LCDGotoXY(0, line);
    ended = 0;
    for (i = 0; i < LCD_LINE_LENGTH; i++)
    {
        if ((ended == 0) && (text[i] != '\0'))
        {
            c = text[i];
        }
        else
        {
            ended = 1;
            c = ' ';
        }
        LCDsendChar((uint8_t)c);
    }
}