#include <stdio.h>
#include <math.h>

double Mayor(double,double,double);
int main(){
    double a,b,c;
    printf ("Ingrese los 3 numeros\n");
    scanf ("%lf %lf %lf", &a, &b, &c);
    printf ("\nEl mayor es: %lf", Mayor(a,b,c));
    return 0;
}

double Mayor(double a, double b, double c){
    double mayor = a;
    if (b>mayor) mayor = b;
    if (c>mayor) mayor = c;
    return mayor;
}
