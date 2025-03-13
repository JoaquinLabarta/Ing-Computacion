#include<stdio.h>
#include<stdlib.h>

int main(){

int x=10, y=20;
int q=30, z=40;
int *const p = &x;
const int *ptr = &q;

printf("El valor de x %d",x);
printf("\nEl valor de y: %d\n\n",y);

printf("La direccion de x %p",&x);
printf("\nLa direccion de y: %p\n",&y);

printf("\nEl valor es %d y su direccion es: %p",*p,p);

*p = y;// CAMBIA VALOR

printf("\nEl valor es %d y su direccion es: %p", *p,p); 

printf("\n\nEl valor de q %d",q);
printf("\nEl valor de z: %d\n\n",z);

printf("La direccion de q %p",&q);
printf("\nLa direccion de z: %p\n\n",&z);

printf("El valor es %d y su direccion es: %p\n",*ptr,ptr);

ptr = &z;

printf("El valor es %d y su direccion es: %p",*ptr,ptr);

return 0;
}