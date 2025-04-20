#include <stdio.h>
#include <stdlib.h>
int ** reservar(int , int);
void liberar(int**,int);
void mostrar(int **, int, int);
int main()
{   int ** MD;
    const int FIL = 4, COL = 2;
    int f, c;

    MD = reservar(FIL,COL);

    for (f=0; f<FIL;f++)
        for (c=0; c<COL;c++)
            MD[f][c] = COL*f+c;

    mostrar(MD, FIL, COL);

    liberar(MD, FIL);

    return 0;
}
int **reservar(int FIL, int COL){
    int** aux;
    int f;
    aux = (int **) malloc(FIL * sizeof(int *));
    for (f=0; f<FIL; f++){
        aux[f] = (int*) malloc( COL*sizeof(int) );
    }
    return(aux);
}
void mostrar(int **MD, int FIL, int COL){
   int f, c;
   for (f=0; f<FIL;f++){
        for (c=0; c<COL;c++)
            printf("%2d  ", MD[f][c]);
        printf("\n");
    }
}

void liberar(int **aux, int FIL){
    int f;
    for (f=0; f<FIL; f++){
        free(aux[f]) ;
    }
    free(aux);
}
