#include <stdio.h>
unsigned int Factorial(unsigned int);

int main(){
    int num,facto;
    printf("Ingrese un numero para calcular su factorial...\n");
    scanf("%d", &num);
    //solucion iterativa
    facto=num;
    if((num==0) || (num==1)) {
        printf("El factorial es: 1 \n");
    }
    else {
        for (int i=num-1; i>1; i--){
            facto*=i;
        }
        printf("El factorial es: %d \n", facto);
    }
    //solucion recursiva
    printf("El factorial es: %u", (Factorial(num)));
    return 0;
}

unsigned int Factorial(unsigned int n){
    if((n==0) || (n==1)) {
        return 1 ;
    }
    else return (n*Factorial(n-1));
}
