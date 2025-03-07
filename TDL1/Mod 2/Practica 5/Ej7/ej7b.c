#include <stdio.h>

int main() {
    FILE *fuente, *destino;
    char linea[1000];

    fuente = fopen("archivo_origen.txt", "r");
    destino = fopen("archivo_destino.txt", "w");

    if (fuente == NULL || destino == NULL) {
        printf("Error al abrir los archivos.\n");
        return 1;
    }

    while (fgets(linea, sizeof(linea), fuente) != NULL) {
        fputs(linea, destino);
    }

    fclose(fuente);
    fclose(destino);

    printf("Se ha copiado el archivo exitosamente utilizando fgets y fputs.\n");

    return 0;
}
