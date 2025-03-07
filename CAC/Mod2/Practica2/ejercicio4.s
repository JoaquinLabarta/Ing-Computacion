.data
peso: .double 20
altura: .double 1.85
imc: .double 0
valores: .double 18.5,25,30
estado: .word 0
.code
l.d f2, altura($0) ;cargo altura
daddi $a0, $0, 0 ;inicializo contador valores (gano tiempo para cargar f2)
mul.d f3,f2,f2 ;estatura^2
l.d f1, peso($0) ;cargo peso 
daddi $t0, $0, 3 ;inicializo cantidad
daddi $a1, $0, 1 ;inicializo estado
div.d f4,f1,f3 ;calculo imc
jal calcularEstado
halt

calcularEstado: beqz $t0, FIN ;si me quede sin valores me voy
l.d f5, valores($a0) ;cargo valor tabla
daddi $a0, $a0, 8 ;aumento corrimiento
daddi $t0, $t0, -1 ;decremento cant
c.le.d f4,f5 ;Compara f4 con f5, dejando flag FP=1 si f4 es menor o igual que f5
bc1t FIN ;si el flag esta en 1 salta
daddi $a1, $a1, 1 ;aumento estado
j calcularEstado

FIN: s.d f4, imc($0)
 sw $a1, estado($0)
jr $ra