/*Implemente una estructura y las funciones para implementar un mazo de 50 cartas españolas.
Implemente las siguientes funciones y realice un programa para probarlas:
a. Barajar el mazo de cartas.
b. Sacar una carta: dado un mazo, sacar la carta del mazo y devolverla.
c. Imprimir una carta (número/figura con su palo).
Nota: utilice constantes (define o const) para definir los palos de las cartas, modelice las cartas y el
mazo.*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define COMODIN 0

typedef struct carta{
    int palo;
    int nro;
} carta;

void inicializarMazo(carta *);
void barajarMazo(carta *);
carta sacarCarta(carta *);

int main(){
    carta mazo[50];
    inicializarMazo(mazo); //Mazo inicializado
    barajarMazo(mazo); //Mazo barajado
    carta carta2 = sacarCarta(mazo); //Sacar carta
    //Imprimir carta
    printf("La carta sacada es del palo: %d, y numero: %d\n",carta2.palo,carta2.nro);
    return 0;
}

void inicializarMazo(carta * mazo){
    int i=0;
    //Inicializo cartas
    for (int n=0;n<4;n++){
        for (int j=0;j<12;j++){
            mazo[i].palo = n+1;
            mazo[i].nro = j+1;
            i++;
        }
    }
    //Comodines
    for (int k=48;k<50;k++){
        mazo[k].palo = COMODIN;
        mazo[k].nro = COMODIN;
    }
}

void barajarMazo(carta * mazo){
    srand(time(NULL));
    for(int i=0;i<50;i++){
        //numeros aleatorios
        int cartaAlea = rand() % 50;
        int posAlea = rand() % 50;
        //inserto
        carta tmp = mazo[posAlea];
        mazo[posAlea] = mazo[cartaAlea];
        mazo[cartaAlea] = tmp;
    }
    return;
}

carta sacarCarta(carta * mazo){
    srand(time(NULL));
    return (mazo[(rand() % 50)]);
}