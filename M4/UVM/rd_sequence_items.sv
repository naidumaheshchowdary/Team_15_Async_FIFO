import uvm_pkg::*;
import  data_fields::*;
`include "uvm_macros.svh"
`include "data_fields.sv"

class rd_sq_item extends uvm_sequence_item;
	
	`uvm_object_utils(rd_sq_item)
	
	logic [DATASIZE-1:0]rdata;
	rand bit rinc;
	logic rempty;
	
	constraint data { 
				rinc dist {0 := 2, 1:= 8};
				};
	
	function new(string name = "rd_sq_item");
		super.new(name);
	endfunction
	
endclass
