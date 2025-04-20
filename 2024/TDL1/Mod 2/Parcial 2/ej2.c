#include <stdio.h>

#define VALOR_ABSOLUTO_DE_DOS(x, y) { \
    x = (x < 0) ? -(x) : (x); \
    y = (y < 0) ? -(y) : (y); \
}

#define DISTANCIA(a,b) ((a+b) < 0 ? -(a+b) : (a+b))

int main() {
    int a = -5;
    int b = 10;

    VALOR_ABSOLUTO_DE_DOS(a, b);

    printf("Valor absoluto de a: %d\n", a);
    printf("Valor absoluto de b: %d\n", b);
    
    int Px = 2, Py = -3, Qx = -4, Qy = 5;
    VALOR_ABSOLUTO_DE_DOS(Px,Py);
    VALOR_ABSOLUTO_DE_DOS(Qx,Qy);

    int distancia = DISTANCIA((Px-Qx),(Py-Qy));
    printf("DISTANCIA: %d\n",distancia);

    return 0;
}