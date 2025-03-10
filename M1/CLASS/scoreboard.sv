`include "packet.sv"
class scoreboard;


write_packet w_pkt;
read_packet  r_pkt;
mailbox scb_w,scb_r;

function new(mailbox scb_w, mailbox scb_r);
	this.scb_w=scb_w;
	this.scb_r=scb_r;
endfunction

task main();

scb_w.get(w_pkt);
scb_r.get(r_pkt);

if(w_pkt.wdata == r_pkt.rdata) begin 
$display("Correct data");
end

else begin 
$display("Incorrect data");
$display("wdata %d rdata %d",w_pkt.wdata,r_pkt.rdata);
end

endtask


endclass