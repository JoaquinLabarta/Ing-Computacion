/*Defina la estructura pun3D, la cual representa una posición en el espacio. La misma debe
contener los campos x (float), y (float) y z (float). Luego:
a. Renombre la estructura pun3D a punto3D utilizando la palabra clave typedef.
b. Imprima en pantalla el tamaño del tipo struct pun3D. ¿Cuánto ocupa? ¿Por qué?
c. Imprima en pantalla el tamaño del tipo punto3D. ¿Cuánto ocupa? ¿Es igual al de struct
pun3D? ¿Por qué?
d. Defina un arreglo de 4 elementos de tipo punto3D e imprima en pantalla el espacio ocupado
por el mismo. ¿Cuánto ocupa? ¿Por qué?*/

#include <stdio.h>
typedef struct pun3D {
    float x;
    float y;
    float z;
} punto3D;

int main(){
    punto3D punto[4];
    struct pun3D pun2;
    printf("\n%d",sizeof(punto));
    printf("\n%d",sizeof(pun2));
    return 0;
}