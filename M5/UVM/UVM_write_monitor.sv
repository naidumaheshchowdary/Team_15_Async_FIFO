import uvm_pkg::*;
`include "uvm_macros.svh"
`include "UVM_driver.sv"

//Write Monitor
class wr_mn extends uvm_monitor;
`uvm_component_utils(wr_mn) 
 
virtual FIFO_int vif;
trans_wr txw;

uvm_analysis_port#(trans_wr) port_write;

int trans_count_wr;
int w_count;

function new (string name = "wr_mn", uvm_component parent);
super.new(name, parent);
`uvm_info("wr_mn", "Inside constructor",UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("wr_mn", "Inside build_phase",UVM_LOW)
port_write = new("port_write", this);

     if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
       `uvm_error("build_phase", "No virtual interface specified for this wr_mn instance")
     end
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
	`uvm_info("wr_mn", "Inside connect_phase",UVM_LOW)
endfunction 
 
task run_phase(uvm_phase phase);
	//bit write_complete_flag = 0;
	super.run_phase(phase);
	`uvm_info("wr_mn", "Inside run_phase",UVM_LOW)

    	 fork
        	begin : wr_mn
            		forever @(negedge vif.wclk) begin
             	
                	mon_write();
            		end
        	end

        	begin : write_completion

              wait (w_count == trans_count_wr);
        	end
    	join

endtask
        
task mon_write;
     
  trans_wr txw;

   	if (vif.winc==1) begin
	
 	txw=trans_wr::type_id::create("txw");  
 	txw.winc = vif.winc;
  	txw.wdata = vif.wdata;
	$display ("\t Monitor winc = %0h \t wData = %0h \t w_count=%0d", txw.winc, txw.wdata, w_count+1);
   	port_write.write(txw);
	w_count=w_count +1;
		 
	end
endtask
endclass

//Read Monitor
class rd_mn extends uvm_monitor;
`uvm_component_utils(rd_mn) 
 
virtual FIFO_int vif;
trans_rd txr;
bit write_complete_flag;

uvm_analysis_port#(trans_rd) port_read;

int trans_count_rd;
int r_count;

function new (string name = "rd_mn", uvm_component parent);
super.new(name, parent);
`uvm_info("READ_MONITOR_CLASS", "Inside constructor",UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
`uvm_info("READ_MONITOR_CLASS", "Inside build_phase",UVM_LOW)
port_read = new("port_read", this);

     if (!uvm_config_db#(virtual FIFO_int)::get(this, "", "vif", vif)) begin
       `uvm_error("build_phase", "No virtual interface specified for this rd_mn instance")
     end
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
	`uvm_info("READ_MONITOR_CLASS", "Inside connect_phase",UVM_LOW)
endfunction 
 

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info("READ_MONITOR_CLASS", "Inside run_phase",UVM_LOW)

			fork 
				begin : rd_mn					
	       				forever @(negedge vif.rclk)begin
        					mon_rd();
    					end
				end
				begin

                  wait (r_count == trans_count_rd);
                  
				end
			join_any
        
		
endtask
 
       
task mon_rd;
     
  trans_rd txr;

if (vif.rinc==1)begin
txr=trans_rd::type_id::create("txr"); 
		fork
			begin
				@(negedge vif.rclk);
				txr.rdata = vif.rdata; 
              $display ("\t Monitor rinc = 1 \t rdata = %0h \t \t rcount=%0d",  txr.rdata, r_count+1);

   				port_read.write(txr);
				r_count= r_count +1;
			end
		join_none	
  	end
endtask
endclass
