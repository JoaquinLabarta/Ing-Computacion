#include <stdio.h>

int main() {
    char a, b;
    printf("Ingrese el primer caracter:\n");
    scanf("%c", &a);
    printf("Se leyo el caracter: %c\n", a);

    // Consumir el carácter de nueva línea en el búfer
    scanf(" %c", &b);

    printf("Ingrese el segundo caracter:\n");
    printf("Se leyo el caracter: %c\n", b);
    return 0;
}
