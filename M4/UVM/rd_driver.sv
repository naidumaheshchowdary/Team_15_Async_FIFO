import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rd_sequencer.sv"
`include "interface.sv"

class rd_dr extends uvm_driver#(rd_sq_item);

	`uvm_component_utils(rd_dr)
	
	virtual FIFO_int vif;
	rd_sq_item rd_item;
	
	function new(string name = "rd_dr", uvm_component parent);
		super.new(name,parent);
		`uvm_info("rd_dr", "Inside Constructor", UVM_HIGH)
	endfunction
	
	//build_phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db #(virtual FIFO_int)::get(this,"*","vif",vif))) begin
			`uvm_error("Rd_Driver_Class", "Failed to get VIF from config DB!")
		end
	endfunction
	
	//connect_phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info("read_driver", "Inside connect_phase", UVM_HIGH)
	endfunction
	
	//run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("read_driver", "Inside run_phase", UVM_HIGH)
		forever begin
			rd_item = rd_sq_item::type_id::create("rd_item");
			seq_item_port.get_next_item(rd_item);
			drive(rd_item);
			seq_item_port.item_done();
		end
	endtask
	
	task drive(rd_sq_item rd_item);
		wait(!vif.wrst);
		@(posedge vif.wclk);
		vif.rinc = rd_item.rinc;
	endtask
	
endclass
	