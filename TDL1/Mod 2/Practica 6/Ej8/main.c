/*
a) ¿El código compila? ¿Por qué?
b) ¿Qué sucedería al cambiar la constante simbólica DEBUG al valor 1? Evalúe el comportamiento del
código. ¿Qué beneficios trae en este caso la compilación condicional?
c) ¿Es posible cambiar el valor de la constante simbólica DEBUG en tiempo de ejecución?
d) ¿Qué sucede si en lugar de utilizar la directiva #if se emplea #ifdef? ¿Incide el valor de la
constante simbólica DEBUG en el resultado de la compilación?*/
#include <stdio.h>
#include <stdlib.h>
#define DEBUG 0
int main(){
 int x= 15;
 while (x<50){
    #if DEBUG
    printf("x= %d", x);
    int y= y+1; //b: si cambio a debug 1 tengo que declarar la variable y
    #endif
    x++;
 }
 return 0;
}

/* Respuestas
a: si, compila, no hay ningun error mientras sea DEBUG 0
c: no se puede cambiar una directiva del preprocesador en tiempo de ejecucion
d: si se utiliza ifdef el printf se queda, y tengo que declarar y
*/