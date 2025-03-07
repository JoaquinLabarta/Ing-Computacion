#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *f;
    f = fopen("diccionario.txt", "r");
    if (f == NULL) {
        printf("Error al abrir el archivo.\n");
        return 1;
    }

    // Crear una estructura de datos dinámica para almacenar las palabras del diccionario
    char **diccionario = NULL;
    int num_palabras = 0;

    char palabra[15];

    // Leer el diccionario y almacenar las palabras en la estructura dinámica
    while (fscanf(f, "%s", palabra) != EOF) {
        num_palabras++;
        // Añadir la palabra al diccionario
        diccionario = (char **)realloc(diccionario, num_palabras * sizeof(char *));
        diccionario[num_palabras] = strdup(palabra);
    }

    fclose(f);

    // Consultar palabras hasta que se ingrese "ZZZ"
    printf("Ingrese una palabra (o 'ZZZ' para salir): ");
    while (1) {
        scanf("%s", palabra);
        if (strcmp(palabra, "ZZZ") == 0) {
            break;
        }

        int encontrado = 0;

        // Buscar la palabra en el diccionario en memoria
        for (int i = 0; i < num_palabras; i++) {
            if (strcmp(palabra, diccionario[i]) == 0) {
                encontrado = 1;
                break;
            }
        }

        if (encontrado) {
            printf("La palabra \"%s\" pertenece al diccionario.\n", palabra);
        } else {
            printf("La palabra \"%s\" no pertenece al diccionario.\n", palabra);
        }

        printf("Ingrese una palabra (o 'ZZZ' para salir): ");
    }

    // Liberar la memoria de la estructura dinámica
    for (int i = 0; i < num_palabras; i++) {
        free(diccionario[i]);
    }
    free(diccionario);

    return 0;
}
