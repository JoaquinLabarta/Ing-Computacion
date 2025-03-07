;Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm.
.data
base: .double 5.85
altura: .double 13.47 
divisor: .double 2
res: .double 0
.code
l.d f1, base($0)
l.d f2, altura($0)
mul.d f3, f1, f2
l.d f4, divisor($0)
div.d f3, f3, f4
s.d f3, res($0)
halt

;opcion 2 menos (0.7 ciclos menos)
.data
base: .double 5.85
altura: .double 13.47 
res: .double 0
.code
l.d f1, base($0)
l.d f2, altura($0)
mul.d f3, f1, f2
daddi $t0, $0, 2
mtc1 $t0, f4
div.d f3, f3, f4
s.d f3, res($0)
halt