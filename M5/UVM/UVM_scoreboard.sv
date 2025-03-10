import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_write_agent.sv"

`uvm_analysis_imp_decl(_port_a)
`uvm_analysis_imp_decl(_port_b)

int empty_count;

class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)
 uvm_analysis_imp_port_a#(trans_wr,scoreboard) write_port;
 uvm_analysis_imp_port_b#(trans_rd,scoreboard) read_port; 

trans_wr tw[$];
trans_rd tr[$];     
  
function new(string name,uvm_component parent);
	super.new(name,parent);
	`uvm_info("SCOREBOARD", "Inside constructor",UVM_LOW)
endfunction  
               
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("SCOREBOARD", "Inside build_phase",UVM_LOW)
	write_port= new("write_port",this);
	read_port= new("read_port",this);  
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	`uvm_info("SCOREBOARD", "Inside connect_phase",UVM_LOW)
endfunction 
 
function void write_port_a(trans_wr txw); 
	tw.push_back(txw);
	$display ("\t Scoreboard wdata = %0h", txw.wdata);
endfunction

function void write_port_b(trans_rd txr);

logic [11:0] popped_wdata;
empty_count = tw.size;
  
	if (tw.size() > 0) 
	begin
    		popped_wdata = tw.pop_front().wdata;
    
    		if (popped_wdata == txr.rdata)
      			`uvm_info("SCOREBOARD", $sformatf("PASSED Design Read Data: %0h --- Expected Data : %0h", txr.rdata, popped_wdata), UVM_MEDIUM)
    		else
      			`uvm_error("SCOREBOARD", $sformatf("ERROR Design Read Data: %0h Does not match Expected Data:  %0h", txr.rdata, popped_wdata))
  	end     
endfunction


task compare_flags(); 
	if (tw.size >= 228) 
	begin
        	`uvm_info("SCOREBOARD", "FIFO IS HALFFULL", UVM_NONE);
  	end 
	if (tw.size >= 456) 
	begin
        	`uvm_info("SCOREBOARD", "FIFO IS FULL", UVM_MEDIUM);
  	end 
	
    	if (empty_count == 1) 
	begin
    		`uvm_info("SCOREBOARD", "FIFO IS EMPTY", UVM_MEDIUM);
    	end
  
endtask
    



task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info("SCOREBOARD", "Inside run_phase",UVM_LOW)
  
endtask
  
endclass
