/*Desarrolle un programa que permita leer por teclado e imprimir por pantalla la información
correspondiente a un estudiante: Apellido, Nombres, Legajo e Identificación. Tenga en cuenta que la
identificación es el DNI (Numérico) para estudiantes argentinos y pasaporte (Alfanumérico) para
estudiantes extranjeros.*/

#include <stdio.h>

enum tipo {DNI = 0, PAS = 1};

typedef union iden{
    int dni;
    char pasaporte[10];
} iden;

typedef struct persona{
    char apellido[50] ;
    char nombre[49];
    char legajo[8];
    union iden identificacion; 
    enum tipo tipo;
} persona;

int main(){
    persona p;
    printf("Ingrese nombre: ");
    scanf("%s",p.nombre);
    printf("\nIngrese apellido: ");
    scanf("%s",p.apellido);
    printf("\nIngrese legajo: ");
    scanf("%s",p.legajo);
    printf("\nIngrese identificacion (0 si es DNI, 1 si es pasaporte): ");
    scanf("%d",&p.tipo);

    if(p.tipo==0){
        printf("\nIngrese DNI: ");
        scanf("%d",&p.identificacion.dni);
        printf("\nEl estudiante %s %s numero de legajo %s tiene identificacion DNI: %d", p.apellido, p.nombre, p.legajo, p.identificacion.dni);
    } 

    else if(p.tipo==1){
        printf("\nIngrese pasaporte: ");
        scanf("%s",p.identificacion.pasaporte);
        printf("\nEl estudiante %s %s numero de legajo %s tiene identificacion pasaporte: %s", p.apellido, p.nombre, p.legajo, p.identificacion.pasaporte);
    }
    return 0;
}