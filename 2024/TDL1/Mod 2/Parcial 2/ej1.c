#include <stdio.h>
#define EXCLUIR 0
int main(){
    int i;
    for (i = 0; i < 5; i++)
    {
        #ifdef EXCLUIR  
            printf("%d",3-i);
            #undef EXCLUIR
        #else
            printf("%d",i);
        #endif
    }
    return 0;
}

/* IMPRIME:
    3 1 2 3 4, deberia imprimir eso, pero nose por que no toma el undef
*/