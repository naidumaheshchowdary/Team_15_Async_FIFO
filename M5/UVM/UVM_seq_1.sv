 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_seq_item.sv"

//Write Sequence
class wr_sq extends uvm_sequence#(trans_wr);
`uvm_object_utils(wr_sq)

int tx_count_wr=913;
trans_wr txw;
    
function new(string name = "wr_sq");
       super.new(name);
       `uvm_info("wr_sq", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("wr_sq", "Inside body task",UVM_LOW)
  for (int i = 0; i < tx_count_wr; i++) begin
			txw = trans_wr::type_id::create("txw");
			start_item(txw);
    		if (!(txw.randomize() with {txw.winc == 1;}));
			//`uvm_error("TX_GENERATION_FAILED", "Failed to randomize trans_wr")
			finish_item(txw);
    
		end
  	
endtask
endclass


//Read Sequence
class rd_sq extends uvm_sequence#(trans_rd);
`uvm_object_utils(rd_sq)

int tx_count_rd=456;
trans_rd txr;
    
function new(string name = "rd_sq");
       super.new(name);
       `uvm_info("rd_sq", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("rd_sq", "Inside body task",UVM_LOW)
		for (int i = 0; i < tx_count_rd; i++) begin
			txr = trans_rd::type_id::create("txr");
			start_item(txr);
          if(!(txr.randomize() with {txr.rinc == 1;}));
			//`uvm_fatal("TX_GENERATION_FAILED", "Failed to randomize trans_rd")
			finish_item(txr);
		end
$display("SK_DEBUG2 entered the end of read sequence");	
endtask
endclass


//Write Sequence
class wr_sq_full extends uvm_sequence#(trans_wr);
  `uvm_object_utils(wr_sq_full)

int tx_count_wr=456;
trans_wr txw;
    
  function new(string name = "wr_sq_full");
       super.new(name);
       `uvm_info("wr_sq_full", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("wr_sq_full", "Inside body task",UVM_LOW)
  for (int i = 0; i < tx_count_wr; i++) begin
			txw = trans_wr::type_id::create("txw");
			start_item(txw);
    if (!(txw.randomize() with {txw.winc == 1;}));
			//`uvm_error("TX_GENERATION_FAILED", "Failed to randomize trans_wr")
			finish_item(txw);
    
		end
	
endtask
endclass

//Read Sequence
class rd_sq_full extends uvm_sequence#(trans_rd);
  `uvm_object_utils(rd_sq_full)

int tx_count_rd=0;
trans_rd txr;
    
  function new(string name = "rd_sq_full");
       super.new(name);
       `uvm_info("rd_sq_full", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("rd_sq_full", "Inside body task",UVM_LOW)
		for (int i = 0; i < tx_count_rd; i++) begin
			txr = trans_rd::type_id::create("txr");
			start_item(txr);
          if(!(txr.randomize() with {txr.rinc == 0;}));	
			//`uvm_fatal("TX_GENERATION_FAILED", "Failed to randomize trans_rd")
			finish_item(txr);
		end
	
endtask
endclass

//Write Sequence
class wr_sq_random extends uvm_sequence#(trans_wr);
  `uvm_object_utils(wr_sq_random)

int tx_count_wr=100;
trans_wr txw;
    
  function new(string name = "wr_sq_full");
       super.new(name);
       `uvm_info("wr_sq_random", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("wr_sq_random", "Inside body task",UVM_LOW)
  for (int i = 0; i < tx_count_wr; i++) begin
			txw = trans_wr::type_id::create("txw");
			start_item(txw);
    if (!(txw.randomize()));
			//`uvm_error("TX_GENERATION_FAILED", "Failed to randomize trans_wr")
			finish_item(txw);
    
		end
	
endtask
endclass


//Read Sequence
class rd_sq_random extends uvm_sequence#(trans_rd);
  `uvm_object_utils(rd_sq_random)

int tx_count_rd=100;
trans_rd txr;
    
  function new(string name = "rd_sq_random");
       super.new(name);
       `uvm_info("rd_sq_random", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("rd_sq_random", "Inside body task",UVM_LOW)
		for (int i = 0; i < tx_count_rd; i++) begin
			txr = trans_rd::type_id::create("txr");
			start_item(txr);
          if(!(txr.randomize()));	
			//`uvm_fatal("TX_GENERATION_FAILED", "Failed to randomize trans_rd")
			finish_item(txr);
		end
	
endtask
endclass

//Write Sequence
class wr_sq_half_empty extends uvm_sequence#(trans_wr);
  `uvm_object_utils(wr_sq_half_empty)

int tx_count_wr=229;
trans_wr txw;
    
  function new(string name = "wr_sq_half_empty");
       super.new(name);
       `uvm_info("wr_sq_half_empty", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("wr_sq_half_empty", "Inside body task",UVM_LOW)
  for (int i = 0; i < tx_count_wr; i++) begin
			txw = trans_wr::type_id::create("txw");
			start_item(txw);
    if (!(txw.randomize() with {txw.winc == 1;}));
			//`uvm_error("TX_GENERATION_FAILED", "Failed to randomize trans_wr")
			finish_item(txw);
    
		end
	
endtask
endclass


//Read Sequence
class rd_sq_half_empty extends uvm_sequence#(trans_rd);
  `uvm_object_utils(rd_sq_half_empty)

int tx_count_rd=1;
trans_rd txr;
    
  function new(string name = "rd_sq_half_empty");
       super.new(name);
       `uvm_info("rd_sq_half_empty", "Inside constructor",UVM_LOW)
endfunction

task body();
        `uvm_info("rd_sq_half_empty", "Inside body task",UVM_LOW)
		for (int i = 0; i < tx_count_rd; i++) begin
			txr = trans_rd::type_id::create("txr");
			start_item(txr);
          if(!(txr.randomize() with {txr.rinc == 0;}));	
			//`uvm_fatal("TX_GENERATION_FAILED", "Failed to randomize trans_rd")
			finish_item(txr);
		end
	
endtask
endclass


//Write Sequence
class wr_sq_bug extends uvm_sequence #(trans_wr);
   
  `uvm_object_utils(wr_sq_bug)

  function  new(string name= "wr_sq_bug");
    super.new(name);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    `uvm_info("wr_sq_bug","Inside the build_phase of w_sq_bug",UVM_MEDIUM)
  endfunction

  virtual task body();
    for (int i=0; i<20; i++) begin
      `uvm_do_with(req,{req.winc == 1;})
      `uvm_info(get_type_name(),$sformatf(" winc: %0d, wdata: %0d",req.winc, req.wdata),UVM_LOW)
      
    end
    `uvm_do_with(req,{req.winc == 0; req.wdata == 0;})
  endtask 

endclass

class rd_sq_bug extends uvm_sequence #(trans_rd);
   
  `uvm_object_utils(rd_sq_bug)

  function  new(string name= "rd_sq_bug");
    super.new(name);
  endfunction 
  
  function void build_phase(uvm_phase phase);
    `uvm_info("rd_sq_bug","Inside the build_phase of rd_sq_bug",UVM_MEDIUM)
  endfunction

  virtual task body();
    for (int i=0; i<20; i++) begin
      `uvm_do_with(req,{req.rinc == 1;})
      `uvm_info(get_type_name(),$sformatf("rinc: %0d, rdata: %0d", req.rinc, req.rdata),UVM_LOW)
    end
    `uvm_do_with(req,{req.rinc == 0;})
  endtask 

endclass