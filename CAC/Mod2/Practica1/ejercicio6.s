.data
A: .word 5
B: .word 5
C: .word 10
D: .word 0
.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r10, r0, r0

beq r1, r2, sumarAB
beq r2, r3, sumarBC
beq r1, r3, sumarCA

j cargar
sumarAB: daddi r10,r10, 1
 beq r1,r3, sumar
j cargar
sumarBC: daddi r10,r10, 1
 beq r2,r1, sumar
j cargar
sumarCA: daddi r10,r10, 1
 beq r3,r2, sumar
j cargar

sumar: daddi r10,r10, 1

cargar: sd r10, D(r0)
fin: halt