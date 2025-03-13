#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *f;
    f = fopen("precipitaciones.txt", "r");
    if (f == NULL) {
        printf("Error al abrir el archivo.\n");
        return 1;
    }

    int max = 0, dia = 0, diaMax = 0, cant;

    while (fscanf(f, "%d-", &cant) != EOF) {
        dia++; // Contador de días
        if (cant >= max) {
            max = cant;
            diaMax = dia;
        }
    }

    fclose(f);

    if (diaMax > 0) {
        printf("El día con mayor precipitación es el día %d con %d mm de lluvia.\n", diaMax, max);
    } else {
        printf("No se encontraron datos de precipitación en el archivo.\n");
    }

    return 0;
}
