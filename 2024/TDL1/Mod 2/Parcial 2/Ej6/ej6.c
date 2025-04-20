#include <stdio.h>
#include <string.h>

struct info {
    int lon;
    int pos;
};

int main() {
    FILE *file = fopen("datos.txt", "r"), *dat = fopen("datos.dat","w");
    if (file == NULL) {
        printf("No se pudo abrir el archivo\n");
        return 1;
    }

    char line[1024];
    int lineNumber = 0;
    struct info i;

    while (fgets(line, sizeof(line), file)) {
        lineNumber++;
        i.lon = strlen(line);
        i.pos = ftell(file);
        printf("Linea %d: longitud %d, posicion de fin de linea %d\n", lineNumber, i.lon, i.pos);
        fwrite(&i,sizeof(i),1,dat);
    }

    fclose(file);
    return 0;
}
