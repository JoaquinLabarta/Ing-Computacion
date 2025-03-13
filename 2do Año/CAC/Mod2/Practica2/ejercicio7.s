;Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo
;de una tabla que contenga valores numéricos de 64 bits sin signo y la cantidad de valores almacenados en 
;dicha tabla. La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla. 
.data
M: .word 10
tabla: .word 20,12,41,121,21,12,1,31,3
cant: .word 9
total: .word 0
.code
ld $a0, cant($0)
ld $a1, M($0)
daddi $t2, $0, 0 ;contador
daddi $v0, $0, 0 ;total
daddi $a2, $0, 1 ;comparador
jal contar
halt

contar:
 beqz $a0, FIN 
 ld $t0, tabla($t2)
 daddi $t2, $t2, 8 ;aumento el corrimiento
 daddi $a0, $a0, -1 ;resto diml
 slt $t1, $a1, $t0 ;guarda 1 en $t1 si M es mas chico que valor
 bne $t1, $a2, contar ;si $t1 no es 1 (mayor que M) salta
 daddi $v0, $v0, 1
 j contar
FIN: sd $v0, total($0)
jr $ra