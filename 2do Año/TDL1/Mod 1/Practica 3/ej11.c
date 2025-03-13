/*. Se requiere la implementación de un tipo de datos para almacenar el horario de manera compacta
utilizando 16 bits. Debido a que el tamaño de los datos es más importante que la precisión, puede
admitirse pérdida de precisión en los segundos. Desarrolle un programa que implemente este tipo de
datos y funciones para leer la hora por teclado e imprimirla por pantalla.*/

#include <stdio.h>
typedef struct horario{
    unsigned int hora : 5; //0--23
    unsigned int min : 6; //0--59
    unsigned int seg : 5; //0--31
} horario;

void leerHorario(horario *);
int main(){
    horario h;
    leerHorario(&h);
    printf("\nLa hora ingresada es %u:%u:%u\n",h.hora,h.min,(h.seg*2));
}

void leerHorario(horario * h){
    int auxhora,auxmin,auxseg;
    printf("Ingrese hora: ");
    scanf("%d",&auxhora);
    printf("\nIngrese minutos: ");
    scanf("%d",&auxmin);
    printf("\nIngrese seg/2: ");
    scanf("%d",&auxseg);

    h->hora = auxhora;
    h->min = auxmin;
    h->seg = auxseg;
    return;
}