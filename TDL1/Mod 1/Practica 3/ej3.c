/*Defina una estructura direccion que contenga los siguientes campos: calle (arreglo de 50
caracteres), ciudad (arreglo de 30 caracteres), codigo_postal (int) y pais (arreglo de 40
caracteres).*/

/*Defina una estructura alu que contenga los siguientes campos: apellido (arreglo de 50
caracteres), nombre (arreglo de 50 caracteres), legajo (arreglo de 8 caracteres), promedio
(float) y domicilio (struct direccion).
a. Renombre el tipo struct alu a alumno mediante la palabra clave typedef.
b. Escriba una función que reciba un alumno y lo inicialice a partir de valores ingresados por
teclado.
c. Escriba un programa que defina un arreglo de 30 elementos alumno y lo inicialice utilizando
la función definida en el inciso anterior. Luego, informe el nombre y apellido del alumno que
tiene mejor promedio.*/
#include <stdio.h>
#include <string.h>

struct direccion{
    char calle[50];
    char ciudad[30];
    int postal;
    char pais[40];
};

typedef struct alu{
    char apellido[50];
    char nombre[50];
    char legajo[8];
    float promedio;
    struct direccion dir;
} alumno;

void inicializarAlumno(alumno *,char[],char[],char[],float,char[],char[],int,char[]);

int main(){
    char apellido[50], nombre[50], legajo[8], calle[50], ciudad[30], pais[40];
    float promedio;
    int postal;
    char apellido2[50], nombre2[50];
    float max=-1;
    alumno a[30];

    for(int i=0; i<30; i++){
        printf("\nIngrese el nombre del alumno: %d",i+1);
        scanf("%s",nombre);
        printf("\nIngrese el apellido del alumno: %d",i+1);
        scanf("%s",apellido);
        printf("\nIngrese el legajo del alumno: %d",i+1);
        scanf("%s",legajo);
        printf("\nIngrese el promedio del alumno: %d",i+1);
        scanf("%f",&promedio);
        printf("\nIngrese la calle del alumno: %d",i+1);
        scanf("%s",calle);
        printf("\nIngrese la ciudad del alumno: %d",i+1);
        scanf("%s",ciudad);
        printf("\nIngrese el codigo postal del alumno: %d",i+1);
        scanf("%d",&postal);
        printf("\nIngrese el pais del alumno: %d",i+1);
        scanf("%s",pais);
        inicializarAlumno(&a[i],apellido,nombre,legajo,promedio,calle,ciudad,postal,pais);
        if(a[i].promedio>=max){
            max=a[i].promedio;
            strcpy(nombre2,a[i].nombre);
            strcpy(apellido2,a[i].apellido);
        }
    }
}

void inicializarAlumno(alumno * a, char apellido[50], char nombre[50], char legajo[8], float promedio, char calle[50], char ciudad[30], int postal, char pais[40]){
    strcpy(a->apellido,apellido);
    strcpy(a->nombre,nombre);
    strcpy(a->legajo,legajo);
    a->promedio=promedio;
    strcpy(a->dir.calle,calle);
    strcpy(a->dir.pais,pais);
    strcpy(a->dir.ciudad,ciudad);
    a->dir.postal=postal;
    return;
}
