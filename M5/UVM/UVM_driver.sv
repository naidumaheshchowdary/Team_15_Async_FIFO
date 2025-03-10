import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_sequencer.sv"
/*`include "UVM_seq_2.sv"
`include "UVM_seq_3.sv"
`include "UVM_seq_4.sv"
`include "UVM_seq_5.sv"*/

//Write Driver
class wr_dr extends uvm_driver#(trans_wr);
`uvm_component_utils(wr_dr)

virtual FIFO_int fint;
trans_wr txw;
int trans_count_wr;

function new (string name = "wr_dr", uvm_component parent);
super.new(name, parent);
`uvm_info("WRITE_DRIVER_CLASS", "Inside constructor",UVM_LOW)
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
`uvm_info("WRITE_DRIVER_CLASS", "Inside Build Phase",UVM_LOW)
		if(!(uvm_config_db #(virtual FIFO_int)::get (this, "*", "vif", fint))) 
		`uvm_error("WRITE_DRIVER_CLASS", "FAILED to get int from config DB")
endfunction

function void connect_phase (uvm_phase phase);
super.connect_phase(phase);
`uvm_info("WRITE_DRIVER_CLASS", "Inside Connect Phase",UVM_LOW)
endfunction

task drive_wr(trans_wr txw);
	@(posedge fint.wclk);
  	this.fint.winc = txw.winc;
        this.fint.wdata = txw.wdata;

	
endtask

task run_phase (uvm_phase phase);
super.run_phase(phase);
`uvm_info("DRIVER_CLASS", "Inside Run Phase",UVM_LOW)
this.fint.wdata <=0;
this.fint.winc <=0;

repeat(10) @(posedge fint.wclk);
  		
  for (integer i = 0; i < trans_count_wr ; i++) begin

   // #5
       //$display("Write transaction count= %0d--------------------",i+1);
   			 
			txw=trans_wr::type_id::create("txw");
			seq_item_port.get_next_item(txw);
	    $display("SK_DEBUG4 entered before wait statement wr_driver");	    
            wait(fint.wfull ==0);
	    $display("SK_DEBUG5 entered after wait statement wr_driver");
            drive_wr(txw);
            seq_item_port.item_done();

	end
			@(posedge fint.wclk);
			this.fint.winc =0;   	
endtask
endclass





//Read Driver
class rd_dr extends uvm_driver#(trans_rd);
`uvm_component_utils(rd_dr)

virtual FIFO_int fint;
trans_rd txr;
int trans_count_rd;

function new (string name = "rd_dr", uvm_component parent);
super.new(name, parent);
`uvm_info("READ_DRIVER_CLASS", "Inside constructor",UVM_LOW)
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
`uvm_info("READ_DRIVER_CLASS", "Inside Build Phase",UVM_LOW)
		if(!(uvm_config_db #(virtual FIFO_int)::get (this, "*", "vif", fint))) 
		`uvm_error("READ_DRIVER_CLASS", "FAILED to get int from config DB")
endfunction

function void connect_phase (uvm_phase phase);
super.connect_phase(phase);
`uvm_info("READ_DRIVER_CLASS", "Inside Connect Phase",UVM_LOW)
endfunction

task drive_rd(trans_rd txr);
 	 @(posedge fint.rclk);
  	this.fint.rinc = txr.rinc;
        
  	
endtask

task run_phase (uvm_phase phase);
super.run_phase(phase);
`uvm_info("DRIVER_CLASS", "Inside Run Phase",UVM_LOW)
this.fint.rinc <=0;

          	repeat(10) @(posedge fint.rclk);
			
          		for (integer j = 0; j < trans_count_rd; j++) begin
                  //#11
            		//$display("Read transaction count= %0d--------------------",j+1);
			txr=trans_rd::type_id::create("txr");
						
			seq_item_port.get_next_item(txr);
			
            		wait(fint.rempty==0);

            		drive_rd(txr);
            
            		seq_item_port.item_done();
			
    			end
			@(posedge fint.rclk);
			this.fint.rinc =0;
    	
endtask
endclass



