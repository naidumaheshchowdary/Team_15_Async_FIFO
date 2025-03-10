module top;

initial begin 
	inf.rclk=0;
	inf.wclk=0;
end

always #33.33ns inf.wclk = ~inf.wclk;
always #50ns inf.rclk = ~inf.rclk;

FIFO_int inf();
Asynch_FIFO duv(inf.rdata, inf.wfull, inf.rempty, inf.wdata, inf.rinc, inf.rclk, inf.rrst, inf.winc, inf.wclk, inf.wrst);
test t1(inf);

covergroup fifo_coverage;
	coverpoint inf.wdata {
		bins write_bin[] = {0,255};
	}
	coverpoint inf.rdata {
		bins read_bin[] = {0,255};
	}
	
	coverpoint inf.rclk {
		bins rclk_bins[] = {0,1};
	}
	
	coverpoint inf.wclk {
		bins wclk_bins[] = {0,1};
	}
	
	coverpoint inf.rempty {
		bins empty_bin[] = {0,1};
	}
	
	coverpoint inf.wfull {
		bins full_bins[] = {0,1};
	}
	
	coverpoint inf.rclk {
		bins rclk_bins[] = {0,1};
	}
	
	coverpoint inf.wclk {
		bins wclk_bins[] = {0,1};
	}
	
	
	coverpoint inf.winc;
	coverpoint inf.rinc;

	coverpoint inf.rempty {
		bins empty_bin[] = {1};
	}
	
	coverpoint inf.wfull {
		bins full_bins[] = {0};
	}
	
endgroup

fifo_coverage fifo_cover;

initial begin
    fifo_cover = new();
    forever begin @(posedge inf.wclk or posedge inf.rclk)
      fifo_cover.sample();
    end
 end

endmodule
