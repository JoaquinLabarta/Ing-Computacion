/*3. a. Investigue las funciones de conversión de texto a número y escriba un programa “calculadora.c” que
reciba dos números enteros y un operador como argumentos a la función main e imprima en pantalla el
resultado de la operación. El operador debe ser: “+”, “-”, “/”, “.”. Si el operador recibido no es uno de los
mencionados anteriormente, entonces el programa debe imprimir un mensaje de error.
b. Utilice una terminal para compilar el programa a través de la línea de comandos.*/
#include <stdio.h>
#include <stdlib.h>

//para ejecutar, abro la terminal en mi carpeta, y uso primero gcc -o ej3 main.c y desp ./ej3 nro1 nro2 operador
int main(int argc, char *argv[]) {
    if (argc != 4) {
        printf("Error: Debes proporcionar dos números y un operador.\n");
        return 1;
    }

    int n1 = atoi(argv[1]);
    int n2 = atoi(argv[2]);
    char op = argv[3][0]; //uso argv[3][0], esto hace que tome el primer caracter de la cadena ingresada(en caso de errores de tipeo)

    switch (op) {
        case '+':
            printf("Resultado: %d\n", n1 + n2);
            break;
        case '-':
            printf("Resultado: %d\n", n1 - n2);
            break;
        case '*':
            printf("Resultado: %d\n", n1 * n2);
            break;
        case '/':
            if (n2 != 0) {
                printf("Resultado: %.2f\n", (float)n1 / n2);
            } else {
                printf("Error: No se puede dividir por cero.\n");
            }
            break;
        default:
            printf("Error: Operador no válido.\n");
            break;
    }

    return 0;
}
 