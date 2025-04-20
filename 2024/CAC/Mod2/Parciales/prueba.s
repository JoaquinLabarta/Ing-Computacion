.data
y: .byte 24
color: .byte 255,0,255,0
control: .word32 0x10000
data: .word32 0x10008
.code
lwu $s6, control($0)
lwu $s7, data($0)

daddi $t0, $0, 7
sw $t0, 0($s6)

daddi $t1, $0, 1
daddi $t2, $0, 11
loop: sb $t1, 5($s7)
 lbu $s1, y($0)
 sb $s1, 4($s7)
 lbu $s2, color($0)
 sw $s2, 0($s7)
 daddi $t0, $0, 5
 sw $t0, 0($s6)
 daddi $t1, $t1, 1
 bne $t1,$t2,loop
FIN: halt