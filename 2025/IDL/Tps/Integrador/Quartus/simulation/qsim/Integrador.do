onerror {exit -code 1}
vlib work
vlog -work work Integrador.vo
vlog -work work pruebas.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Integrador_vlg_vec_tst -voptargs="+acc"
vcd file -direction Integrador.msim.vcd
vcd add -internal Integrador_vlg_vec_tst/*
vcd add -internal Integrador_vlg_vec_tst/i1/*
run -all
quit -f
