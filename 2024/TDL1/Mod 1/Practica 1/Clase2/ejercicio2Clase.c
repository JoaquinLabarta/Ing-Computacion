#include <stdio.h>
int ordenar(int * ,int *);
int main()
{
    int *ptr1,*ptr2;
    int nro1,nro2;
    //lectura
    printf("Ingrese dos numeros\n");
    scanf("%d %d",&nro1,&nro2);
    //asignacion
    ptr1=&nro1;
    ptr2=&nro2;
    //programa
    ordenar(ptr1,ptr2); //tambien podria haber pasado &nro1 &nro2 que son las direcciones
    printf("El menor y el mayor ordenados quedan: %d %d\n",*ptr1,*ptr2);
    return 0;
}

int ordenar(int *juan, int *pedro){
    int nro3;
    if (*juan>*pedro){
        nro3 = *pedro;
        *pedro = *juan;
        *juan = nro3;
    }
}
