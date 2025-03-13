/*Escriba una función que reciba una matriz cuadrada A e imprima en pantalla su matriz transpuesta*/
#include <stdio.h>
#define col 2
void trasponer(int[][col],int);
int main()
{
    int filas;
    printf("Ingrese la cantidad de filas que debera tener la matriz\n");
    scanf("%d",&filas);
    int m[filas][col];
    for (int i=0;i<filas;i++){
        for (int j=0;j<col;j++){
            printf("Ingrese el valor para la fila %d columna %d\n",i,j);
            scanf("%d",&m[i][j]);
        }
    }
    trasponer(m,filas);
    return 0;
}

void trasponer(int m[][col],int filas)
{
    printf("La matriz traspuesta es: \n");
    for (int i=0;i<col;i++){
        for (int j=0;j<filas;j++){
            printf("%d",m[j][i]);
        }
        printf("\n");
    }
}
