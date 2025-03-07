#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SQUAREOF(x) x*x

int main() { //tuve que agregar parentesis en los argumentos, sino la macro hacia cualquier cosa
 int xin=3;
 printf("\nxin=%i",xin);
 printf("\nSQUAREOF(xin)=%i", SQUAREOF(xin));
 printf("\nSQUAREOF((xin+4))=%i", SQUAREOF((xin+4)));
 printf("\nSQUAREOF((xin+xin))=%i", SQUAREOF((xin+xin)));
 return 0;
}
