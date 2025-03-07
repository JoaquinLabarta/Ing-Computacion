    .data
    CONTROL: .word 0x10000
    DATA: .word 0x10008
    texto: .asciiz " "
    .text
    ; configuracion puertos
    ld $s0, DATA($0)
    ld $s1, CONTROL($0)

    ; limpio pantalla
    daddi $t0, $0, 6
    sd $t0, 0($s1)

    ; guardo la posicion texto
    daddi $s2, $0, texto  ; guardo dir texto
    daddi $t1, $0, 5      ; guardo dimf
  loop:
    daddi $t0, $0, 9      ; configuro control para leer char
    sd $t0, 0($s1)        ; le digo que lea
    ld $t0, 0($s0)        ; lo que leyo desde data lo guarda en t0
    daddi $t1, $t1, -1
    sd $t0, 0($s2)        ; guardo en texto
    daddi $s2, $s2, 8     ; incremento vector char
    bnez $t1, loop

    ; impresion
    daddi $t1, $0, 5      ; guardo dimf
    daddi $t2, $0, texto  ; vuelvo a cargar dir texto
  loop2: sd $t2, 0($s0) ; mando a data la dir de texto
    daddi $t0, $0, 4
    sd $t0, 0($s1)        ; configuro para imprimir e imprime la dir de texto guardada en data
    daddi $t2, $t2, 8
    daddi $t1, $t1, -1
    bnez $t1, loop2
    halt