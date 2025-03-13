/*Defina un enumerativo que permita representar los días de la semana (domingo a sábado).
b. Realice dos implementaciones diferentes de una función que imprima el texto asociado a un día
de la semana del enumerativo.
Nota: si bien una función para la impresión no es necesaria, favorece la reutilización,
encapsulamiento, validación del rango del dato y minimiza la posibilidad de errores futuros*/

#include <stdio.h>
enum dias {DOM, LUN, MAR, MIE, JUE, VIE, SAB};
int main(){
    enum dias dia;
    char * d[] = {"Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"};
    for (dia = DOM;dia<=SAB;dia++){
        printf("El numero %d representa al dia %s\n",dia,d[dia]);
    }
    
}