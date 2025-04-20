#include <stdio.h>

#define nPares(a, b) ({ \
    int cant = 0; \
    if ((a) % 2 == 0) { \
        cant++; \
    } \
    if ((b) % 2 == 0) { \
        cant++; \
    } \
    cant; \
})

int main() {
    int a, b;
    scanf("%d %d", &a, &b);
    int cantidadPares = nPares(a, b);
    printf("Cantidad de números pares: %d\n", cantidadPares);

    return 0;
}

/*Ejercicio 4
a) f (los dos valen 4 bytes) 
b) v 
c) v (hace xor) 
d) f (w+ borra todo lo que tenga el archivo) 
e) f 
f) f (a tambien lo crea)
g) v
h) v
i) f (solo te indica si se realizo una accion fuera del limite, no si esta parado sobre él)
j) f (indica cuantos se pudieron escribir en el archivo, no cuantos se desean escribir)
*/