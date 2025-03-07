.data 
A: .word  1 
B: .word  2  
.code  
ld  r1, A(r0)  
ld  r2, B(r0) 
sd  r2, A(r0)  ;esta instruccion genera raw
sd  r1, B(r0) 
halt 
;sin forwarding 3k cpi, con 1,8k cpi