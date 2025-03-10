import uvm_pkg::*;
`include "uvm_macros.svh"

//Write Sequence item


class trans_wr extends uvm_sequence_item;
`uvm_object_utils(trans_wr)

randc bit [7:0] wdata;
rand bit winc;
bit wfull;

constraint w1data {wdata dist {8'h00:=1, 8'hFF:=1, [8'h01:8'hFE]:/1};}
function new(string name = "trans_wr");
        super.new(name);
		`uvm_info("trans_wr", "Inside Constructor",UVM_LOW)
endfunction
endclass



//Read Sequence item
class trans_rd extends uvm_sequence_item;
`uvm_object_utils(trans_rd)

rand bit rinc;
logic [7:0] rdata;
bit rempty;

function new(string name = "trans_rd");
        super.new(name);
		`uvm_info("trans_rd", "Inside Constructor",UVM_LOW)
endfunction
endclass
