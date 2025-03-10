import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rd_sequence.sv"

class rd_sqr extends uvm_sequencer#(rd_sq_item);

	`uvm_component_utils(rd_sqr)
	
	function new (string name = "rd_sqr", uvm_component parent);
		super.new(name,parent);
		`uvm_info("rd_sqr", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//BuildPhase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("rd_sqr", "Inside BuildPhase", UVM_HIGH)
	endfunction
	
	//ConnectPhase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("rd_sqr", "Inside ConnectPhase", UVM_HIGH)
	endfunction
	
endclass