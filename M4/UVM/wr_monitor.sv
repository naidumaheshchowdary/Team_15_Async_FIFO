import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wr_driver.sv"

class wr_mn extends uvm_monitor;

	`uvm_component_utils(wr_mn)
	
	virtual FIFO_int vif;
	wr_sq_item wr_item;
	
	uvm_analysis_port #(wr_sq_item) wr_mn_port;
	
	function new(string name = "wr_mn", uvm_component parent);
		super.new(name,parent);
		`uvm_info("wr_mn", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("wr_mn", "Inside build_phase", UVM_HIGH)
		wr_mn_port = new("wr_mn_port", this);
		
		if(!(uvm_config_db #(virtual FIFO_int)::get(this,"*","vif",vif))) begin
			`uvm_error("Monitor_Class", "Failed to get VIF from config DB!")
		end
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("wr_mn", "Inside connect_phase", UVM_HIGH)
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("wr_mn", "Inside run_phase", UVM_HIGH)
		
		forever begin
			wr_item = wr_sq_item::type_id::create("wr_item");
			wait(vif.wrst);
			@(posedge vif.wclk);
			wait(!vif.wfull);
			wr_item.wdata = vif.wdata;
			wr_item.winc = vif.winc;
			wr_mn_port.write(wr_item);
		end
	endtask
	
endclass
			