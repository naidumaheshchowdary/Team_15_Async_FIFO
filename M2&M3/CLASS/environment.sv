`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

generator gen;
driver drv;
monitor mon;
scoreboard scb;
virtual FIFO_int inf;
mailbox b1_w,b1_r,b2_w,b2_r;

function new(virtual FIFO_int inf);
	b1_w=new();
	b1_r=new();
	b2_w=new();
	b2_r=new();
	this.inf=inf;
	gen=new(b1_w,b1_r);
	drv=new(inf,b1_w,b1_r);
	mon=new(inf,b2_w,b2_r);
	scb=new(b2_w,b2_r);
endfunction


task build();
repeat(5000) begin 
gen.main();
drv.main();
mon.main();
scb.main();
end
endtask

task run();
build();
endtask





endclass