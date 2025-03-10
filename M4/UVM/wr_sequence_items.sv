import uvm_pkg::*;
import  data_fields::*;
`include "uvm_macros.svh"
`include "data_fields.sv"

class wr_sq_item extends uvm_sequence_item;

	`uvm_object_utils(wr_sq_item)

	rand logic [DATASIZE-1:0]wdata;
	rand bit winc;
	bit write_full;
	//rand bit write_rst;

	constraint data { wdata inside {[0:255]};
				winc dist {0 := 2, 1:= 8};
				};

endclass



