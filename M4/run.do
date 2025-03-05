vlog -lint data_fields.sv
vlog -lint design.sv
#vlog -lint interface.sv
vlog -lint top.sv

#vlog -lint wr_sequence_items.sv
#vlog -lint wr_sequence.sv
#vlog -lint wr_sequencer.sv
#vlog -lint wr_driver.sv
#vlog -lint wr_monitor.sv
#vlog -lint wr_agent.sv

#vlog -lint rd_sequence_items.sv
#vlog -lint rd_sequence.sv
#vlog -lint rd_sequencer.sv
#vlog -lint rd_driver.sv
#vlog -lint rd_monitor.sv
#vlog -lint rd_agent.sv

#vlog -lint scoreboard.sv
#vlog -lint environment.sv
#vlog -lint test.sv
#vlog -lint top.sv

vsim work.top
#add wave sim:/top/*
#add wave sim:/top/DUT.*

run -all

