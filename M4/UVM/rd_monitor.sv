import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rd_driver.sv"

class rd_mn extends uvm_monitor;

	`uvm_component_utils(rd_mn)
	
	virtual FIFO_int vif;
	rd_sq_item rd_item;
	
	uvm_analysis_port #(rd_sq_item) rd_mn_port;
	
	function new(string name = "rd_mn", uvm_component parent);
		super.new(name,parent);
		`uvm_info("rd_mn", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("rd_mn", "Inside build_phase", UVM_HIGH)
		rd_mn_port = new("rd_mn_port", this);
		
		if(!(uvm_config_db #(virtual FIFO_int)::get(this,"*","vif",vif))) begin
			`uvm_error("Monitor_Class", "Failed to get VIF from config DB!")
		end
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("rd_mn", "Inside connect_phase", UVM_HIGH)
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("rd_mn", "Inside run_phase", UVM_HIGH)
		
		forever begin
			rd_item = rd_sq_item::type_id::create("rd_item");
			wait(vif.rrst);
			wait(!vif.rempty);
			rd_item.rdata = vif.rdata;
			rd_item.rinc = vif.rinc;
			rd_mn_port.write(rd_item);
		end
	endtask
	
endclass
			