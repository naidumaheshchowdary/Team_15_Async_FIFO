import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wr_sequencer.sv"
`include "interface.sv"

class wr_dr extends uvm_driver#(wr_sq_item);

	`uvm_component_utils(wr_dr)
	
	virtual FIFO_int vif;
	wr_sq_item wr_item;
	
	function new(string name = "wr_dr", uvm_component parent);
		super.new(name,parent);
		`uvm_info("wr_dr", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db #(virtual FIFO_int)::get(this,"*","vif",vif))) begin
			`uvm_error("Driver_Class", "Failed to get VIF from config DB!")
		end
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("wr_dr", "Inside connect_phase", UVM_HIGH)
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("wr_dr", "Inside run_phase", UVM_HIGH)
		forever begin
			wr_item = wr_sq_item::type_id::create("wr_item");
			seq_item_port.get_next_item(wr_item);
			drive(wr_item);
			seq_item_port.item_done();
		end
	endtask
	
	task drive(wr_sq_item wr_item);
		wait(vif.wrst);
		@(posedge vif.wclk);
		vif.wdata = wr_item.wdata;
		vif.winc = wr_item.winc;
	endtask
	
endclass
	