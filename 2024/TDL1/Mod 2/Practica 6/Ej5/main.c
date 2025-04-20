#include <stdio.h>
#include <stdlib.h>
#define size 25
void imprimir(int * v){ //correji quitando parametro que no funcionaba
 int i;
 for (i=0; i<size; i++){ 
    printf("v[%d]= %d\n", i, v[i]);
 }
}
int main(){
 int v[size];
 imprimir(v); //al usar define, no necesito pasar ese valor, ya que lo puedo usar en cualquier parte del programa
 return 0;
}