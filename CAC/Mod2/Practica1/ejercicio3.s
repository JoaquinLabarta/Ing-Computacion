 .data 
 A: .word 1 
 B: .word 6  
 .code  
 ld  r1, A(r0)  
 ld  r2, B(r0) 
 loop: dsll  r1, r1, 1  ;aca aparece raw
    daddi  r2, r2, -1  ;aca aparece raw
    bnez  r2, loop 
halt 
;el branch taken aparece porque luego de estar comparando si r2 es cero
;ya se esta ejecutando el halt, para luego darse cuenta que no va.