#include <stdio.h>
#include <stdlib.h>
typedef struct {
  char nom[20];
  int edad;
} TPersona;


TPersona ** reservar(int , int);
void liberar(TPersona**,int);
void mostrar(TPersona **, int, int);
void cargar(TPersona **, int, int);
int main()
{   TPersona ** MD;
    const int FIL = 4, COL = 2;

    MD = reservar(FIL,COL);

    cargar(MD, FIL, COL);

    mostrar(MD, FIL, COL);

    liberar(MD, FIL);

    return 0;
}
TPersona **reservar(int FIL, int COL){
    TPersona** aux;
    int f;
    aux = malloc(FIL * sizeof(TPersona *));
    for (f=0; f<FIL; f++){
        aux[f] = malloc( COL*sizeof(TPersona) );
    }
    return(aux);
}
void mostrar(TPersona **MD, int FIL, int COL){
   int f, c;
   for (f=0; f<FIL;f++){
        for (c=0; c<COL;c++)
            printf("%s - %d     ",
                   MD[f][c].nom, MD[f][c].edad);
        printf("\n");
    }
}

void liberar(TPersona **aux, int FIL){
    int f;
    for (f=0; f<FIL; f++){
        free(aux[f]) ;
    }
    free(aux);
}

void cargar(TPersona **MD, int FIL, int COL){
  int f,c;
  for (f=0; f<FIL;f++)
     for (c=0; c<COL;c++){
        printf("Ingrese nombre :");
        scanf("%s", MD[f][c].nom );

        printf("Ingrese Edad :");
        scanf("%d", &(MD[f][c].edad));
     }

}
