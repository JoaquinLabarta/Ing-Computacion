/*Desarrolle una función llamada damePar(), la cual debe retornar un número entero. damePar() devuelve 0 en el primer llamado,
2 en el segundo, 4 en el tercero, y así sucesivamente. Luego, escriba un programa que lea un número entero positivo n desde teclado
y utilizando damePar() imprima los primeros n números pares. No utilice variables globales. */
#include <stdio.h>
int damePar();
int main(){
  int n;
  printf("Ingrese un valor \n");
  scanf("%d",&n);
  for(int i=1;i<=n;i++){
    printf("%d\n",damePar());
  }
  return 0;
}

int damePar() {
    static int contador = 0;
    int par = contador;
    contador += 2;
    return par;
}
