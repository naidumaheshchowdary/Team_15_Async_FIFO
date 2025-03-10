`include "packet.sv"
class monitor;

virtual FIFO_int inf;
write_packet w_pkt;
read_packet  r_pkt;
mailbox mon2scb_w,mon2scb_r;

function new(virtual FIFO_int inf, mailbox mon2scb_w, mailbox mon2scb_r);
	this.inf=inf;
	this.mon2scb_r=mon2scb_r;
	this.mon2scb_w=mon2scb_w;
endfunction

task mon_write();
	w_pkt=new();
	if(inf.winc) begin 
		w_pkt.wdata=inf.wdata;
		mon2scb_w.put(w_pkt);
		$display("Value monitored is %d",w_pkt.wdata);
	end
endtask

task mon_read();

	r_pkt=new();
	@(posedge inf.rclk);
	if(inf.rinc) begin 
	r_pkt.rdata=inf.rdata;
	mon2scb_r.put(r_pkt);
	$display("Value monitored read is %d",r_pkt.rdata);
	end
	
endtask


task main();
mon_write();
mon_read();

endtask



endclass