#include <stdio.h>
int darVuelta();
int main(){
    int num, contador, resultado;
    printf("Ingrese un numero entero (solo hasta 9 digitos): \n");
    scanf("%d",&num);
    contador = (log10(num) + 1);
    printf("El numero tiene %d digitos\n",contador);
    resultado = darVuelta(num,contador);
    printf("Los numeros invertidos son: %d",resultado);
    return 0;
}
int darVuelta(int n,int cant){
    int dig,elevar,resultado;
    resultado=0;
    while (n!=0){
        dig=n%10; //obtengo ultimo numero
        elevar = pow(10,cant-1); //obtengo tantos ceros como necesito
        dig=dig*elevar; //agrego cantidad de ceros
        resultado=(resultado/elevar); //obtengo el primer numero del resultado
        resultado= (resultado*elevar)+dig; //agrego ceros al primer numero y sumo digitos
        n=n/10; //descompongo numero principal
        cant=cant-1;
    }
    return resultado;
}
