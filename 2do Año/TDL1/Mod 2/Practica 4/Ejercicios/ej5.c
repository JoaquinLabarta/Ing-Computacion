/*Escriba un programa que reserve en forma dinámica un arreglo de 100 caracteres. A continuación, lea
10 oraciones utilizando la función gets e informe para cada una de ellas la cantidad de letras
minúsculas y de letras mayúsculas que la componen. Utilice el arreglo creado como variable temporal
para procesar cada oración. Por último, libere la memoria reservada dinámicamente.*/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int main()
{
    for (int i=0; i<10; i++){
        char *oracion;
        oracion = (char *) malloc(100 * sizeof(char));
        if (oracion!= NULL){
            printf("Se pudo reservar memoria \n");
            printf("Ingrese una oracion (maximo 100 car): \n");
            gets(oracion);
            int cant = strlen(oracion),may=0,min=0;
            printf("Cantidad de letras de la oracion: %d\n", cant);
            for (int j = 0; j< cant; j++){
                if (islower(oracion[j])){
                min++;
            } else if (isupper(oracion[j])){
                may++;
            }
            }
            printf("Cantidad de mayusculas: %d\n Cantidad de minusculas: %d\n",may,min);
            free(oracion);
            if (oracion = NULL){
                printf("Se libero la memoria");
            }
        }
        else{
            printf("No se pudo reservar memoria \n");
        }
    }
    return 0;
}