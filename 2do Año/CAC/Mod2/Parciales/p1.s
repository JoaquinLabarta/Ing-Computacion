.data 
control: .word 0x10000
data: .word 0x10008
color: .byte 0, 255, 0, 0

.text
ld $s6, control($zero)
ld $s7, data($zero)
daddi $t0, $zero, 8
sd $t0, 0($s6) ;lee
ld $a0, 0($s7) ;guarda
sd $t0, 0($s6) ;lee
ld $a1, 0($s7) ;guarda
jal dibujar
halt

dibujar: 
    lwu $t0, color($zero)
    sw $t0, 0($s7)
    daddi $t7, $zero, 5
    daddi $t1, $zero, 5
    daddi $t2, $zero, 5
    dadd $t1, $t1, $a0
    dadd $t2, $t2, $a1

    lazo1: 
        sb $t1, 5($s7)
        sb $t2, 4($s7)
        sd $t7, 0($s6)
        daddi $t1, $t1, -1
        slti $t0, $t1, 5
        beqz $t0, lazo1
        daddi $t2, $t2, -1
        slti $t0, $t2, 5
        bnez $t0, retornar
        daddi $t1, $a0, 5
        j lazo1
retornar: jr $ra