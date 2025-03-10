import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wr_monitor.sv"

class wr_ag extends uvm_agent;
	
	`uvm_component_utils(wr_ag)
	
	wr_sqr wsr;
	wr_dr wd;
	wr_mn wm;
	
	function new(string name = "wr_ag", uvm_component parent);
		super.new(name,parent);
		`uvm_info("write_agent", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("write_agent", "Inside build_phase", UVM_HIGH)
		wd = wr_dr::type_id::create("wd",this);
		wm = wr_mn::type_id::create("wm",this);
		wsr = wr_sqr::type_id::create("wsr",this);
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("write_agent", "Inside connect_phase", UVM_HIGH)
		wd.seq_item_port.connect(wsr.seq_item_export);
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
	
endclass