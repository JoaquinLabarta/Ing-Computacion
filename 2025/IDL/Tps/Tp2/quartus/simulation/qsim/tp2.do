onerror {exit -code 1}
vlib work
vlog -work work tp2.vo
vlog -work work FIN.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.tp2_vlg_vec_tst -voptargs="+acc"
vcd file -direction tp2.msim.vcd
vcd add -internal tp2_vlg_vec_tst/*
vcd add -internal tp2_vlg_vec_tst/i1/*
run -all
quit -f
