/*Escriba un programa que lea desde teclado números enteros de una cifra (del 0 al 9) y que cree dos
archivos, los cuales almacenen los números leídos. El primer archivo debe llamarse “numeros.txt” y
contener en formato texto todos los números leídos en forma consecutiva. El segundo archivo debe
llamarse “numeros.dat” y contener todos los números leídos en formato binario.*/
#include <stdio.h>
#include <stdlib.h>
int main()
{
    //creo archivos
    FILE * f,* arch;
    char nom1[12] = "numeros.txt";
    char nom2[12] = "numeros.dat";
    f = fopen(nom1,"w");

    if(f==NULL){
        printf("No se pudo abrir el archivo\n");
    }

    arch = fopen(nom2,"wb");
    if(arch==NULL){
        printf("No se pudo abrir el archivo\n");
    }

    //lectura de numeros
    int n;
    printf("\nIngrese un numero del 0 al 9 ");
    scanf("%d",&n);
    while (n >= 0 && n <= 9) {
        fprintf(f," %d ",n);
        fwrite(&n,sizeof(int),1,arch);
        printf("\nIngrese un numero del 0 al 9 ");
        scanf("%d", &n);
    }
    
    //cierre de archivos
    fclose(f);
    fclose(arch);
    return 0;
}