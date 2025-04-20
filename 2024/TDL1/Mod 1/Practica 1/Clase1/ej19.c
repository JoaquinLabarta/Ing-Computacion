#include <stdlib.h>
#include <stdio.h>
int main(){
    srand(time(NULL));
    int pt = 0,rta,n1,n2;
    char nota;
    for (int i =0;i<4;i++){
        n1=(rand()%100);
        n2=(rand()%100);
        printf("Resuelva: %d + %d\n",n1,n2);
        scanf("%d",&rta);
        if(rta==(n1+n2)){
            pt=pt+1;
            printf("Muy bien!\n");
        }
        else ("Incorrecta\n");
    }
    switch(pt){
    case 0:
        nota='E'; break;
    case 1:
        nota='D'; break;
    case 2:
        nota='C'; break;
    case 3:
        nota='B'; break;
    case 4:
        nota='A'; break;
    }
    printf("La nota es: %c",nota);
    return 0;
}
