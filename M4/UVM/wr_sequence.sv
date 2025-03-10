import uvm_pkg::*;
`include "uvm_macros.svh"
`include "wr_sequence_items.sv"


class wr_sq extends uvm_sequence #(wr_sq_item);

	`uvm_object_utils(wr_sq)

	wr_sq_item wr_item;

	function new(input string name="wr_sq");
		super.new(name);
		`uvm_info("Write Sequence", "New Constructor", UVM_HIGH)
	endfunction



	task body();
		wr_item=wr_sq_item::type_id::create("wr_item");

		repeat(10) begin
			start_item(wr_item);
			assert(wr_item.randomize());
			finish_item(wr_item);
		end

	endtask


endclass