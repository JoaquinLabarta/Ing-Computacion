/*Se desea leer y procesar información de un listado de apuestas. Para ello se dispone de un archivo
de texto (llamado apuestas.txt) con el siguiente formato:
código_de_apuesta|monto_apostado; … ; código_de_apuesta|monto_apostado;
Donde cada apuesta se compone de un número entero (código de apuesta) y un número flotante
(monto apostado). Escriba un programa que procese la información del archivo e informe el monto
total apostado.
Ejemplo: 1|100.0;65|50.5;23|34.5; debe informar: “El monto total apostado es $185”.
Nota: Intente resolver el problema leyendo cada tupla (código, monto) al mismo tiempo.*/

#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *f;
    f = fopen("apuestas.txt", "r");
    if (f == NULL) {
        printf("Error al abrir el archivo.\n");
        return 1;
    }
    float monto_total = 0.0; 
    while (!feof(f)) {
        int codigo;
        float monto;
        if (fscanf(f, "%d|%f;", &codigo, &monto) == 2) {
            monto_total += monto;
        }
    }
    fclose(f);
    printf("El monto total apostado es $%.2f\n", monto_total);
    return 0;
}
