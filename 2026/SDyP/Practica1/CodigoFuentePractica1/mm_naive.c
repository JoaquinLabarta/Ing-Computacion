#include<stdio.h>
#include<stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <sys/time.h>

typedef enum {
	ORDENXFILAS,
	ORDENXCOLUMNAS
} TOrden;

// Multiplica dos matrices, A y B, de tamaño nxn y almacena el resultado en la matriz C
void matmul(double *A, double *B, double *C, int n);
// Valida el resultado. 0 si ok, sino -1
int validar(int n, double *c, char* fileR);
// Lee una matriz desde archivo de a datos consecutivos y la almacena en el mismo orden en memoria principal 
double* leerMatriz(double *m, int n, char * fullpath);
//Para calcular tiempo
double dwalltime(void);

int main(int argc,char*argv[]){
int N;

	// Chequeo de parametros
	if ( (argc < 5) || ((N = atoi(argv[1])) <= 0)){
		printf("\nError en los parametros. Usar: %s N  <ruta y archivo matriz A> <ruta y archivo matriz B> <ruta y archivo matriz resultado> \n", argv[0]);
		exit(1);
	}

	// Lee las rutas de los archivos
	char* fileA = argv[2];
	char* fileB = argv[3];
	char* fileR = argv[4];

	//Aloca memoria para las matrices
	double* A = (double*)malloc(sizeof(double)*N*N);
	double* B = (double*)malloc(sizeof(double)*N*N);
	double* C = (double*)malloc(sizeof(double)*N*N);

	// Lee las matrices a y b de archivos. Se almacenan en memoria linealmente tal como se encuentran en archivo
	printf("Leyendo matrices...\n");
	A = leerMatriz(A,N,fileA); // Asumimos ordenada en archivo por filas, en memoria la utilizamos por filas
	B = leerMatriz(B,N,fileB); // Asumimos ordenada en archivo por filas, en memoria la utilizamos por filas 

	//Realiza la multiplicacion
	printf("Multiplicando matrices...\n");
	double timetick = dwalltime();
		// Realiza la multiplicacion
		matmul(A, B, C, N);
	double workTime = dwalltime() - timetick;

	printf("mm_naive n = %d Tiempo en segundos %f\n", N, workTime);

	// Liberar memoria antes de validar
	free(A);
	free(B);
  
	// Valida
	printf("Validando...\n");
	if (validar(N,C,fileR) == 0)
		printf("Resultado correcto.\n");
	else
		printf("Error.\n");
  
	// Libera memoria restante
	free(C);
  
 return(0);
}

//-----------------------------------------------------------------

void matmul(double *A, double *B, double *C, int N){
int i, j, k;

	for(i=0;i<N;i++){
		for(j=0;j<N;j++){
			C[i*N+j] = 0;
			for(k=0;k<N;k++){
				double valor = C[i*N+j] + A[i*N+k]*B[k*N+j];
				C[i*N+j]=valor;
			}
		}
	} 
  
}

int validar(int n, double *c, char* fileR){
 int validacion = 0;
 double* r = (double *) malloc(n*n*sizeof(double));

	r = leerMatriz(r,n,fileR);

    if (memcmp(r, c, n*n*sizeof(double)) != 0) {      		
    	validacion = -1;
    }
	
	free(r);
	return validacion;
}

double* leerMatriz(double *m, int n, char * fullpath){
	int i, j;
	double val;
	FILE* archivo;

	archivo = fopen(fullpath, "rb");
	if (!archivo) {
		perror("Error al abrir el archivo\n");
		return NULL;
	}

	fread(m, sizeof(double), n * n, archivo);

	fclose(archivo);

	return m;
}

double dwalltime(void){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}
