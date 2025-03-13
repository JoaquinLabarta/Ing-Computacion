/*Escriba un programa que lea información de 20 jugadores de tenis. De cada jugador se lee nombre y
apellido, edad, cantidad de títulos, ranking actual y fortuna acumulada. Defina una estructura de
datos adecuada para la información y almacene la misma en un archivo binario. Finalizada la
lectura, procese los datos almacenados en el archivo e informe:
a) Nombre y apellido del jugador con mejor ranking.
b) Nombre y apellido del jugador que más títulos ha ganado.*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NUM_JUGADORES 3

// Definición de la estructura para la información del jugador
struct Jugador {
    char nombre[50];
    char apellido[50];
    int edad;
    int titulos;
    int ranking;
    float fortuna;
};

typedef struct Jugador Jugador;

int main() {
    FILE *archivo;
    Jugador jugadores[NUM_JUGADORES];
    Jugador mejorRanking, masTitulos;

    // Llenar información de los jugadores
    for (int i = 0; i < NUM_JUGADORES; i++) {
        printf("Ingrese el nombre del jugador %d: ", i + 1);
        scanf("%s", jugadores[i].nombre);

        printf("Ingrese el apellido del jugador %d: ", i + 1);
        scanf("%s", jugadores[i].apellido);

        printf("Ingrese la edad del jugador %d: ", i + 1);
        scanf("%d", &jugadores[i].edad);

        printf("Ingrese la cantidad de títulos del jugador %d: ", i + 1);
        scanf("%d", &jugadores[i].titulos);

        printf("Ingrese el ranking actual del jugador %d: ", i + 1);
        scanf("%d", &jugadores[i].ranking);

        printf("Ingrese la fortuna acumulada del jugador %d: ", i + 1);
        scanf("%f", &jugadores[i].fortuna);
    }

    // Abre el archivo binario para escritura
    archivo = fopen("jugadores.bin", "wb");
    if (archivo == NULL) {
        perror("Error al abrir el archivo");
        return 1;
    }

    // Escribe la información de los jugadores en el archivo
    fwrite(jugadores, sizeof(Jugador), NUM_JUGADORES, archivo);

    // Cierra el archivo
    fclose(archivo);

    // Abre el archivo binario para lectura
    archivo = fopen("jugadores.bin", "rb");
    if (archivo == NULL) {
        perror("Error al abrir el archivo");
        return 1;
    }

    // Lee la información de los jugadores desde el archivo
    fread(jugadores, sizeof(Jugador), NUM_JUGADORES, archivo);

    // Inicializa las estructuras para el mejor ranking y los más títulos
    mejorRanking = jugadores[0];
    masTitulos = jugadores[0];

    for (int i = 1; i < NUM_JUGADORES; i++) {
        if (jugadores[i].ranking > mejorRanking.ranking) {
            mejorRanking = jugadores[i];
        }

        if (jugadores[i].titulos > masTitulos.titulos) {
            masTitulos = jugadores[i];
        }
    }

    // Cierra el archivo
    fclose(archivo);

    // Informa los resultados
    printf("Nombre y apellido del jugador con mejor ranking: %s %s\n", mejorRanking.nombre, mejorRanking.apellido);
    printf("Nombre y apellido del jugador que más títulos ha ganado: %s %s\n", masTitulos.nombre, masTitulos.apellido);

    return 0;
}
