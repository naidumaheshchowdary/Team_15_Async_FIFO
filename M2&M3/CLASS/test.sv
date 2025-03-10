`include "environment.sv"
program test (FIFO_int inf);
	environment env;
	
	initial begin 
	env=new(inf);
	env.run();
	$finish;
	end

endprogram