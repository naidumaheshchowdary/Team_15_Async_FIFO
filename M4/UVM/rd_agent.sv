import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rd_monitor.sv"

class rd_ag extends uvm_agent;
	
	`uvm_component_utils(rd_ag)
	
	rd_sqr rsr;
	rd_dr rd;
	rd_mn rm;
	
	function new(string name = "rd_agnt", uvm_component parent);
		super.new(name,parent);
		`uvm_info("rd_agent", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("rd_agent", "Inside build_phase", UVM_HIGH)
		rd = rd_dr::type_id::create("rd",this);
		rm = rd_mn::type_id::create("rm",this);
		rsr = rd_sqr::type_id::create("rsr",this);
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("rd_agent", "Inside connect_phase", UVM_HIGH)
		rd.seq_item_port.connect(rsr.seq_item_export);
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
	
endclass