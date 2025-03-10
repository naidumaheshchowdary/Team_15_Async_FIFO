import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_seq_1.sv"

//Write Sequencer 
class wr_sqr extends uvm_sequencer #(trans_wr);
`uvm_component_utils(wr_sqr)

function new (string name = "wr_sqr", uvm_component parent);
super.new(name, parent);
`uvm_info("wr_sqr", "Inside constructor",UVM_LOW)
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
`uvm_info("wr_sqr", "Build Phase",UVM_LOW)
endfunction

function void connect_phase (uvm_phase phase);
super.connect_phase(phase);
`uvm_info("wr_sqr", "Connect Phase",UVM_LOW)
endfunction

endclass


//Read Sequencer 
class rd_sqr extends uvm_sequencer #(trans_rd);
`uvm_component_utils(rd_sqr)

function new (string name = "rd_sqr", uvm_component parent);
super.new(name, parent);
`uvm_info("rd_sqr", "Inside constructor",UVM_LOW)
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
`uvm_info("rd_sqr", "Build Phase",UVM_LOW)
endfunction

function void connect_phase (uvm_phase phase);
super.connect_phase(phase);
`uvm_info("rd_sqr", "Connect Phase",UVM_LOW)
endfunction

endclass

