/*El archivo de texto “Habitantes.txt” contiene
información de la cantidad de habitantes de ciertas localidades
argentinas. En cada línea del archivo se encuentra: el código de
provincia, el código de Localidad, el nombre de localidad y la
cantidad de habitantes. Estos cuatro valores se encuentran separados
por un único blanco. Escriba un programa que lea la información del archivo
“Habitantes.txt” y la utilice para generar el archivo binario
“Habitantes.dat” con la siguiente estructura:
struct destino {
 int codProv;
 int codLoc;
 char nomLoc[30];
 int nHab;
};
Al finalizar la carga del archivo binario, deberá calcular y mostrar el código y el nombre de localidad con mayor
cantidad de habitantes.*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct destino {
 int codProv;
 int codLoc;
 char nomLoc[30];
 int nHab;
};

int main(){
    FILE * txt, * dat;
    txt = fopen("Habitantes.txt","r");
    if(txt == NULL){
        printf("Error al abrir archivo\n");
        return 1;
    }

    struct destino hab, maxHab;
    maxHab.nHab = 0;

    dat = fopen("Habitantes.dat", "wb");

    while (fscanf(txt,"%d %d %s %d",&hab.codProv,&hab.codLoc,hab.nomLoc,&hab.nHab) != EOF){
        fwrite(&hab,sizeof(struct destino),1,dat);
        if(hab.nHab > maxHab.nHab){
            maxHab = hab;
        }
    }
    
    fclose(txt);
    fclose(dat);

    printf("La localidad con mayor cantidad de habitantes es %s con el código %d y tiene %d habitantes.\n", maxHab.nomLoc, maxHab.codLoc, maxHab.nHab);

    return 0;
}
