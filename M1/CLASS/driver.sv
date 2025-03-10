`include "packet.sv"
class driver;

virtual FIFO_int inf;
write_packet w_pkt;
read_packet  r_pkt;
mailbox gen2drv_w,gen2drv_r;

function new(virtual FIFO_int inf,mailbox gen2drv_w,mailbox gen2drv_r);
	this.inf=inf;
	this.gen2drv_r=gen2drv_r;
	this.gen2drv_w=gen2drv_w;
endfunction

task write_reset();
	inf.wrst<=1'b1;
	repeat (1) @(posedge inf.wclk);
	inf.wrst<=1'b0;
	$display("Write reset initiated");
endtask

task read_reset();
	inf.rrst<=1'b1;
	repeat (1) @(posedge inf.rclk);
	inf.rrst<=1'b0;
	$display("Read reset initiated");
endtask

task drive_write();
	w_pkt=new();
	gen2drv_w.get(w_pkt);
	inf.winc<='1;
	inf.wdata=w_pkt.wdata;
	$display("task driver write is %d",w_pkt.wdata);
	$display("task driver write at interface %d",inf.wdata);
	repeat(2) @(posedge inf.wclk);
endtask

task drive_read();
	inf.rinc<='1;
	$display("drive_read initiated");
	repeat(2) @(posedge inf.rclk);
endtask

task main();
	fork
	write_reset();
	read_reset();
	join
	
	drive_write();
	drive_read();
	
endtask


endclass
