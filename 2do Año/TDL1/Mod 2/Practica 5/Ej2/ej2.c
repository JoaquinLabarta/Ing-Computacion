#include <stdio.h>
#include <stdlib.h>

int main() {
    // Abrir el archivo
    FILE *arch;
    arch = fopen("prueba.txt", "r");
    if (!arch) {
        printf("Error al abrir el archivo.\n");
        return 1;
    }

    // Crear contadores
    int mayus = 0, minus = 0, dig = 0;
    int c;

    // Leer caracteres del archivo
    while ((c = fgetc(arch)) != EOF) {
        if (c >= 'A' && c <= 'Z') {
            mayus++;
        } else if (c >= 'a' && c <= 'z') {
            minus++;
        } else if (c >= '0' && c <= '9') {
            dig++;
        }
    }

    // Cerrar el archivo
    fclose(arch);

    printf("Cantidad mayúsculas: %d, Cantidad minúsculas: %d, Cantidad dígitos: %d\n", mayus, minus, dig);
    return 0;
}
