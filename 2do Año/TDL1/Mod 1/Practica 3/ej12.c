/*.El formato utiliza 3 componentes (Red, Green, Blue) de 8 bits para codificar un píxel de color, requiriendo 3 bytes
o 24 bits de memoria. Hace muchos años cuando surgieron los primeros teléfonos a color se utilizó un
formato RGB reducido a 2 bytes o 16 bits (Red:5 bits, Green:6 bits, Blue: 5 bits) para reducir el espacio
de almacenamiento y mejorar las velocidades de transferencia. Actualmente en el ámbito de los
microcontroladores estos displays siguen siendo utilizados. Teniendo en cuenta lo anterior
implemente un programa que:
a. Defina el tipo RGB24 y RGB16 de forma eficiente.
b. Implemente 2 funciones de conversión de un formato a otro y viceversa*/

#include <stdio.h>
struct RGB24 {
    unsigned int red :8;
    unsigned int blue :8;
    unsigned int green :8;
};

struct RGB16{
    unsigned int red :5;
    unsigned int blue :5;
    unsigned int green :6;
};

struct RGB24 convertir16a24(struct RGB16);
struct RGB16 convertir24a16(struct RGB24);

int main(){
    struct RGB16 p16 = {23,20,19};
    struct RGB24 p24 = {15,23,12};
    //convierto
    struct RGB24 pConvertido24 = convertir16a24(p16);
    struct RGB16 pConvertido16 = convertir24a16(p24);
    //imprimo
    printf("RGB16 original: %u, %u, %u\n", p16.red, p16.blue, p16.green);
    printf("RGB24 convertido desde RGB16: %u, %u, %u\n", pConvertido24.red, pConvertido24.blue, pConvertido24.green);

    printf("RGB24 original: %u, %u, %u\n", p24.red, p24.blue, p24.green);
    printf("RGB16 convertido desde RGB24: %u, %u, %u\n", pConvertido16.red, pConvertido16.blue, pConvertido16.green);
    return 0;
}

struct RGB16 convertir24a16(struct RGB24 p){
    struct RGB16 pConvert;
    pConvert.red = p.red>>3; 
    pConvert.blue = p.blue>>3;
    pConvert.green = p.green>>3;
    return pConvert;
};

struct RGB24 convertir16a24(struct RGB16 p){
    struct RGB24 pConvert;
    pConvert.red = p.red<<3;
    pConvert.blue = p.blue<<3; 
    pConvert.green = p.green<<2;
    return pConvert;
};
