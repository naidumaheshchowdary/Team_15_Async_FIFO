import uvm_pkg::*;
import  data_fields::*;
`include "uvm_macros.svh"
`include "rd_sequence_items.sv"


class rd_sq extends uvm_sequence#(rd_sq_item);
	
	`uvm_object_utils(rd_sq)
	
	rd_sq_item rd_item;
	
	function new(string name = "rd_sq");
		super.new(name);
		`uvm_info("rd_sq", "Inside Constructor", UVM_HIGH)
	endfunction
	
	task body();
		rd_item=rd_sq_item::type_id::create("rd_item");
		
		repeat(10) begin
			start_item(rd_item);
			assert(rd_item.randomize());
			finish_item(rd_item);
		end
	endtask
	
endclass