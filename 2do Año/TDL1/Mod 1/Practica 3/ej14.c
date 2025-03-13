#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define COMODIN 0
#define total_mazo 50

typedef struct carta{
    unsigned int palo : 3;
    unsigned int nro : 4;
} carta;

void inicializarMazo(carta *);
void barajarMazo(carta *);
carta sacarCarta(carta *);

int main(){
    carta mazo[total_mazo];
    inicializarMazo(mazo); //Mazo inicializado
    barajarMazo(mazo); //Mazo barajado
    //Imprimo mazo barajado
    for (int i=0;i<total_mazo; i++){
        printf("\nCarta nro %d, palo: %u, numero: %u",i,mazo[i].palo,mazo[i].nro);
    }
    
    carta carta2 = sacarCarta(mazo); //Sacar carta
    //Imprimir carta
    printf("\nLa carta sacada es del palo: %u, y numero: %u\n",carta2.palo,carta2.nro);
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
    for (int k=48;k<total_mazo;k++){
        mazo[k].palo = COMODIN;
        mazo[k].nro = COMODIN;
    }
}

void barajarMazo(carta * mazo){
    srand(time(NULL));
    for(int i=0;i<total_mazo;i++){
        //numeros aleatorios
        int cartaAlea = rand() % total_mazo;
        int posAlea = rand() % total_mazo;
        //inserto
        carta tmp = mazo[posAlea];
        mazo[posAlea] = mazo[cartaAlea];
        mazo[cartaAlea] = tmp;
    }
    return;
}

carta sacarCarta(carta * mazo){
    srand(time(NULL));
    return (mazo[(rand() % total_mazo)]);
}