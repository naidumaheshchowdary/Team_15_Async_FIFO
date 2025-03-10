import uvm_pkg::*;
`include "uvm_macros.svh"
`include "scoreboard.sv"

class environment extends uvm_env;

	`uvm_component_utils(environment)

	wr_ag wag;
	rd_ag rag;
	scoreboard scb;
	
	function new(string name = "environment", uvm_component parent);
		super.new(name,parent);
		`uvm_info("environment", "Inside constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("environment", "Inside build_phase", UVM_HIGH)
		
		wag = wr_ag::type_id::create("wag",this);
		rag = rd_ag::type_id::create("rag",this);
		scb = scoreboard::type_id::create("scb",this);
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("environment", "connect_phase", UVM_HIGH)
		
		wag.wm.wr_mn_port.connect(scb.sc_wr_port);
		rag.rm.rd_mn_port.connect(scb.sc_rd_port);
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask
	
endclass