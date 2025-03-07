/*Escriba un programa que reciba una secuencia de palabras como argumentos a la función main e imprima
una única frase conformada por la concatenación de todas ellas separándolas entre sí por un blanco. 
En caso de que el programa no reciba ninguna palabra se debe imprimir un mensaje de error.*/

#include <stdio.h>
int main(int argc, char *argv[]){
    if(argc == 1){
        printf("No se recibió ninguna palabra");
        return 1;
    }

    for (int i = 1; i < argc; i++)
    {
        printf(" %s ",argv[i]);
    }
    
    return 0;
}