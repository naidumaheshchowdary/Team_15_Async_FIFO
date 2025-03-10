vlib Asyncr_FIFO
vmap work Asyncr_FIFO


vlog -work Asyncr_FIFO -coveropt 3 +cover +acc +define+BUG=0 FIFO_design.sv

#Remove the below coment to get bug 
#vlog -work Asyncr_FIFO -coveropt 3 +cover +acc +define+BUG=1 FIFO_design.sv


vlog -work Asyncr_FIFO -coveropt 3 +cover +acc TOP.sv 
vlog -work Asyncr_FIFO -coveropt 3 +cover +acc UVM_test1.sv
vlog -work Asyncr_FIFO -coveropt 3 +cover +acc UVM_scoreboard.sv
vlog -work Asyncr_FIFO  UVM_environment.sv
vlog -work Asyncr_FIFO  UVM_driver.sv
vlog -work Asyncr_FIFO  interface.sv
vlog -work Asyncr_FIFO  UVM_seq_item.sv
vlog -work Asyncr_FIFO  UVM_seq_1.sv
vlog -work Asyncr_FIFO  UVM_sequencer.sv
vlog -work Asyncr_FIFO  UVM_write_agent.sv
vlog -work Asyncr_FIFO  UVM_coverage.sv
vlog -work Asyncr_FIFO  UVM_write_monitor.sv

vsim -coverage -vopt Asyncr_FIFO.tb_top -do "coverage save -onexit -directive -codeAll file1; run -all;exit"
coverage exclude -src N:/work/work/FIFO_design.sv -line 82
coverage exclude -src N:/work/work/FIFO_design.sv -line 88
coverage exclude -src N:/work/work/FIFO_design.sv -line 89
coverage exclude -src N:/work/work/FIFO_design.sv -line 150
vcover report -details -codeAll -html file1
coverage report -assert -binrhs -details -cvg

