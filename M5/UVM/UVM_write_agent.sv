 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_write_monitor.sv"


//Write Agent
class wr_ag extends uvm_agent;
`uvm_component_utils(wr_ag)

wr_sqr wsr;
wr_dr wd;
wr_mn wm;

function new (string name = "wr_ag", uvm_component parent);
super.new(name, parent);
`uvm_info("wr_ag", "Inside constructor",UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("wr_ag", "Inside build_phase",UVM_LOW)
	
		wsr = wr_sqr::type_id::create("wsr", this);
		wd = wr_dr::type_id::create("wd", this);
		wm = wr_mn::type_id::create("wm", this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("wr_ag", "Inside connect_phase",UVM_LOW)
wd.seq_item_port.connect(wsr.seq_item_export);

endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info("wr_ag", "Inside run_phase",UVM_LOW)
endtask
endclass

class rd_ag extends uvm_agent;
`uvm_component_utils(rd_ag)


rd_sqr rsr;
rd_dr rd;
rd_mn rm;

function new (string name = "rd_ag", uvm_component parent);
super.new(name, parent);
`uvm_info("READ_AGENT_CLASS", "Inside constructor",UVM_LOW);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
		`uvm_info("READ_AGENT_CLASS", "Inside build_phase",UVM_LOW);
		rsr = rd_sqr::type_id::create("rsr", this);
		rd = rd_dr::type_id::create("rd", this);
		rm = rd_mn::type_id::create("rm", this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
`uvm_info("READ_AGENT_CLASS", "Inside connect_phase",UVM_LOW);
rd.seq_item_port.connect(rsr.seq_item_export);

endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);
`uvm_info("READ_AGENT_CLASS", "Inside run_phase",UVM_LOW);
endtask
endclass