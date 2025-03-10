import uvm_pkg::*;
`include "uvm_macros.svh"
`include "environment.sv"

class test extends uvm_test;

	`uvm_component_utils(test)
	
	environment env;
	wr_sq pkt_wr_sqr;
	rd_sq pkt_rd_sqr;
	
	function new(string name = "test", uvm_component parent);
		super.new(name,parent);
		`uvm_info("test", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("test", "Insede build_phase", UVM_HIGH)
		
		env = environment::type_id::create("env",this);
	endfunction
	
	//end_of_elaboration_phase
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("test", "run_phase", UVM_HIGH)
		
		phase.raise_objection(this);
		repeat(10) begin
			pkt_wr_sqr = wr_sq::type_id::create("pkt_wr_sqr");
			pkt_rd_sqr = rd_sq::type_id::create("pkt_rd_sqr");
			pkt_wr_sqr.start(env.wag.wsr);
			pkt_rd_sqr.start(env.rag.rsr);
		end
	endtask
	
endclass