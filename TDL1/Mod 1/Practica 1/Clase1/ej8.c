#include <stdio.h>
int main(){
    int total, x = 1;
    while (x <= 10) {
        total += x;
        ++x;
    }
    printf("Total = %d",total);
}
