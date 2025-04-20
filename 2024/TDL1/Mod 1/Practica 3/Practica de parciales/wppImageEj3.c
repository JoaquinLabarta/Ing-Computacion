#include <stdio.h>
int main(){
    char * p, i=1, c='I', s[]="Malo";
    *(s+1) =* (&c);
    p = s+3;
    *(s+i) = *p;
    p[0] = 's';
    *s = --(*&c);
    printf("%s",s);
    return 0;
}