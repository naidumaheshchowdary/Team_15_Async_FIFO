 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_scoreboard.sv"

class environment extends uvm_env;
`uvm_component_utils(environment)

virtual FIFO_int vif;

wr_ag wa;
rd_ag ra;
scoreboard scb;

function new(string name, uvm_component parent);
      super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
     wa = wr_ag::type_id::create("wa", this);
     ra = rd_ag::type_id::create("ra", this);
     scb = scoreboard::type_id::create("scb", this);
  
     if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
       `uvm_fatal("build phase", "No virtual interface specified for this env instance")
     end

endfunction
  
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
   
     wa.wm.port_write.connect(scb.write_port);
     ra.rm.port_read.connect(scb.read_port);
    
endfunction

task run_phase (uvm_phase phase);
super.run_phase(phase);
endtask
endclass


