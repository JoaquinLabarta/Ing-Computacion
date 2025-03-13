#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    if (argc == 5) {  // Debe haber 5 argumentos: el nombre del programa y 4 números
        float prom, suma = 0;
        for (int i = 1; i < argc; i++) {
            suma += atof(argv[i]);
        }
        prom = suma / 4;
        printf("Promedio de los números: %.2f\n",prom);  // Agregamos %f para imprimir el valor de prom
    } else {
        printf("Debe ingresar exactamente 4 números como argumentos.\n");
    }
    return 0;
}
