#include <stdio.h>
#include <stdlib.h>

int main()
{   int ** MD;
    const int FIL = 4, COL = 2;
    int f, c;

    MD = (int **) malloc(FIL * sizeof(int *));
    for (f=0; f<FIL; f++){
        MD[f] = (int*) malloc( COL*sizeof(int) );
    }

    for (f=0; f<FIL;f++)
        for (c=0; c<COL;c++)
            MD[f][c] = COL*f+c;


    for (f=0; f<FIL;f++){
        for (c=0; c<COL;c++)
            printf("%2d  ", MD[f][c]);
        printf("\n");
    }

    for (f=0; f<FIL; f++){
        free(MD[f]) ;
    }
    free(MD);

    return 0;
}
