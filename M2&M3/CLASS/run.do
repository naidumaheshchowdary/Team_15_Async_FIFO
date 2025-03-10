vlib test1
vmap work test1 
vlog data_fields.sv
vlog Async_fifo_memory.sv
vlog rempty.sv
vlog sync_rtow_wtor.sv
vlog Wfull.sv
vlog  -work test1  -coveropt 3 +cover +acc Fifo_top.sv
vlog  -work test1  -coveropt 3 +cover +acc interface.sv
vlog  -work test1  -coveropt 3 +cover +acc test.sv
vlog  -work test1 -coveropt 3 +cover +acc top.sv
vsim work.top
vsim -coverage top -voptargs="+cover=becsf"
vsim -vopt -coverage test1.top -do "coverage save -onexit -directive -codeAll file1; run -all;exit"


vcover report -details -codeAll -html file1
coverage report -assert -binrhs -details -cvg
run -all
