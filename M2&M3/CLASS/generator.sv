`include "packet.sv"
class generator;

write_packet w_pkt;
read_packet  r_pkt;
mailbox gen2drv_w,gen2drv_r;

function new(mailbox gen2drv_w, mailbox gen2drv_r);
	this.gen2drv_w=gen2drv_w;
	this.gen2drv_r=gen2drv_r;
endfunction


task main();
repeat(1) begin
w_pkt = new();
if(w_pkt.randomize()) begin 
	$display("Randomization successful");
	gen2drv_w.put(w_pkt);
end
else begin 
	$display("Randomization not successful");
end

end
endtask

endclass