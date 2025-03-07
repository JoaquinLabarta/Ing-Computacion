#include <stdio.h>

int main() {
    FILE *fuente, *destino;
    int caracter;

    fuente = fopen("archivo_origen.txt", "r");
    destino = fopen("archivo_destino.txt", "w");

    if (fuente == NULL || destino == NULL) {
        printf("Error al abrir los archivos.\n");
        return 1;
    }

    while ((caracter = fgetc(fuente)) != EOF) {
        fputc(caracter, destino);
    }

    fclose(fuente);
    fclose(destino);

    printf("Se ha copiado el archivo exitosamente utilizando fgetc y fputc.\n");

    return 0;
}
