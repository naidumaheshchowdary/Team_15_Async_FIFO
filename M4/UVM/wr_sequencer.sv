import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wr_sequence.sv"

class wr_sqr extends uvm_sequencer#(wr_sq_item);

	`uvm_component_utils(wr_sqr)
	
	function new (string name = "wr_sqr", uvm_component parent);
		super.new(name,parent);
		`uvm_info("wr_sqr", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//BuildPhase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("wr_sqr", "Inside BuildPhase", UVM_HIGH)
	endfunction
	
	//ConnectPhase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("wr_sqr", "Inside ConnectPhase", UVM_HIGH)
	endfunction
	
endclass