if [file exists "work"] {vdel -all}
vlib work
vlog *.sv +acc
vsim async_fifo_tb -voptargs="+cover=bcesf"


run -all
#coverage report -code bcesf
#coverage report -codeAll
#coverage report -assert -binrhs -details -cvg

