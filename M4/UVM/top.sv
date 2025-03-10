//import uvm_pkg::*;
/*`include "interface.sv"
`include "wr_sequence_items.sv"
`include "rd_sequence_items.sv"
`include "wr_sequence.sv"
`include "rd_sequence.sv"
`include "wr_sequencer.sv"
`include "rd_sequencer.sv"
`include "wr_driver.sv"
`include "rd_driver.sv"
`include "wr_monitor.sv"
`include "rd_monitor.sv"*/
//`include "wr_agent.sv"
//`include "rd_agent.sv"
//`include "scoreboard.sv"
//`include "environment.sv"
`include "test.sv"

module top;

	logic wclk;
	logic rclk;
	logic wrst;
	logic rrst;
	
	FIFO_int inf(wclk,rclk,wrst,rrst);
	
	Asynch_FIFO DUT (.rdata(inf.rdata),.wfull(inf.wfull),.rempty(inf.rempty),.wdata(inf.wdata),.rinc(inf.rinc),.rclk(rclk),.rrst(rrst),.winc(inf.winc),.wclk(wclk),.wrst(wrst));
	
	initial begin
		uvm_config_db #(virtual FIFO_int)::set(null,"*","vif",inf);
	end
	
	initial begin
		run_test("test");
	end
	
	always #33.33ns wclk = ~wclk;
	always #50ns rclk = ~rclk;
	
	initial begin
		wclk = 1'b0;
		wrst = 1'b1;
		rclk = 1'b0;
		rrst = 1'b1;
		fork 
			begin
				repeat(18)
					begin
						@(negedge wclk)
						wrst = 1'b1;
					end
				@(posedge wclk)
				wrst = 1'b0;
			end
		
			begin
				repeat(5)
					begin
						@(negedge rclk)
						rrst = 1'b1;
					end
					
					begin
						@(posedge rclk)
						rrst = 1'b0;
					end
			end
			
		join
	end
	
	initial begin
		#5000;
		$display("Sorry! Ran out of clock cycles!");
		$finish();
	end
	
endmodule