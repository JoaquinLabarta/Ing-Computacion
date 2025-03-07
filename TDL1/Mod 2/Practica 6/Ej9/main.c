/*Realice un programa que genere un vector de 1000 enteros al azar y utilice una función para localizar un
elemento. Se pide:
a) Implementar la función de búsqueda que, dado un entero, retorne la posición donde se encuentra.
En caso de no existir el número retorne -1.
b) Modificar a) para agregar información de depuración que permita imprimir en consola la cantidad
de veces que se debió acceder al arreglo para encontrar (o no) el elemento en cada llamado a la
función. Utilice las directivas del procesador para activar/desactivar la depuración e imprimir/no
imprimir la información en la consola.
c) Verifique el tamaño del programa compilando con la depuración y sin la depuración. Explique
porque difieren.
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//Las depuracion se activan con 1 y desactivan con 0
#define ACTIVAR_DEPURACION 0 
#define IMPRIMIR_DEPURACION 0
#define DIMF 1000
#define FALSE -1
//Prototipo y programa
int buscar(int vec[],int);
int main(){
    srand(time(NULL));
    int nro,vec[DIMF];
    //Llenado vector
    for (int i=0;i<DIMF; i++)
    {
        vec[i]=rand() % 10;
    }
    //Funcionalidad
    printf("Ingrese un numero a buscar (fin = -1)\n");
    scanf("%d",&nro);
    int exito = buscar(vec,nro);
    #if ACTIVAR_DEPURACION
        int cant = 1;
    #endif
    while (nro != FALSE){
        if(exito!=FALSE) printf("La posicion del numero %d es: %d\n\n",nro,exito);
        else printf("No se encontro la posicion\n\n");
        #if ACTIVAR_DEPURACION
            cant++;
        #endif
        printf("Ingrese un numero a buscar (fin = -1)\n");
        scanf("%d",&nro);
        exito = buscar(vec,nro);
    }
    #if IMPRIMIR_DEPURACION
        printf("Cantidad de llamados a la funcion: %d",cant);
    #endif
    return 0;
}
int buscar(int vec[],int nro){
    int i;
    for (i=0;i<DIMF;i++){
        if (vec[i]==nro){
            return i;
            break;
        }
    }
    return FALSE;
}