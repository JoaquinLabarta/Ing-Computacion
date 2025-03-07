//Escriba una función que reciba un arreglo unidimensional e invierta el orden de sus valores.
#include <stdio.h>
#define N 5
void swap(int *,int *);
int main()
{
    int vector[N]={1,2,3,4,5};
    int *ptrVector;
    ptrVector=vector;
    //comienzo
    for (int i=0;i<N/2;i++){
        swap(ptrVector,&vector[N-i-1]);
        *ptrVector++;
    }
    //imprimo
    for(int j=0;j<N;j++){
        printf("%d ",vector[j]);
    }
    return 0;
}
void swap(int *primer, int *segundo)
{
    int aux = *primer; //ej: aux = vector[i]=1
    *primer=*segundo; //ej: vector[i]=vector[i+x]
    *segundo=aux; //ej: vector[i+x] = aux = vector[i]
}
