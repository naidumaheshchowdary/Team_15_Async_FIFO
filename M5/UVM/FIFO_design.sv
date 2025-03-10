module Asynch_FIFO  #( parameter DATASIZE = 8,parameter ADDRESS_BITS = 9,BUG=0) (rdata,wfull,rempty,wdata,rinc,rclk,rrst,winc,wclk,wrst);
 
  input  logic  winc, wclk, wrst,rinc, rclk, rrst;
  input   logic [DATASIZE-1:0] wdata;
  output  logic [DATASIZE-1:0] rdata;
  output  logic wfull,rempty;


  wire [ADDRESS_BITS-1:0] waddr, raddr;
  wire [ADDRESS_BITS:0] wq2_read_ptr, rq2_write_ptr;
  wire [ADDRESS_BITS:0] wptr, rptr;

  sync_r_to_w sync_r_to_w (wclk, wrst, rptr,wq2_read_ptr);
  
  sync_w_to_r sync_w_to_r (rclk, rrst,wptr,rq2_write_ptr );
  
  memory_element #(DATASIZE, ADDRESS_BITS,BUG) MEM (winc, wfull, wclk,waddr, raddr,wdata,rdata,rinc,rclk,rempty);
  
  read_empty #(ADDRESS_BITS) Read_emp_ptr (rinc, rclk, rrst, rq2_write_ptr,rempty,raddr,rptr);
  
  write_full #(ADDRESS_BITS) wfull_ptr (winc, wclk, wrst, wq2_read_ptr, wfull, waddr, wptr);

initial begin
if(BUG) $display("bug found!!");
end
  

endmodule


module sync_r_to_w #( parameter ADDRESS_BITS = 9 )(wclk, wrst, rptr,wq2_read_ptr);

  input   wclk, wrst;
  input   [ADDRESS_BITS:0] rptr;
  output logic  [ADDRESS_BITS:0] wq2_read_ptr;
   logic [ADDRESS_BITS:0] wq1_read_ptr;

  always_ff @(posedge wclk or negedge wrst)
  begin
    if (!wrst) 
	{wq2_read_ptr,wq1_read_ptr} <= 0;
    else 
	{wq2_read_ptr,wq1_read_ptr} <= {wq1_read_ptr,rptr};
  end

endmodule


module sync_w_to_r #( parameter ADDRESS_BITS = 9 )(rclk, rrst,wptr,rq2_write_ptr );
  input   rclk, rrst;
  input   [ADDRESS_BITS:0] wptr;
  output logic [ADDRESS_BITS:0] rq2_write_ptr;
  logic [ADDRESS_BITS:0] rq1_write_ptr;

  always_ff @(posedge rclk or negedge rrst)
  begin
    if (!rrst)
      {rq2_write_ptr,rq1_write_ptr} <= 0;
    else
      {rq2_write_ptr,rq1_write_ptr} <= {rq1_write_ptr,wptr};
 end
endmodule


module memory_element #( parameter DATASIZE = 8, parameter ADDRESS_BITS = 9,parameter BUG=0) (winc, wfull, wclk,waddr, raddr,wdata,rdata,rinc,rclk,rempty);

  input   winc, wfull, wclk,rclk,rinc,rempty;
  input   [ADDRESS_BITS-1:0] raddr,waddr ;
  input   [DATASIZE-1:0] wdata;
  output  logic [DATASIZE-1:0] rdata;


  localparam DEPTH = 1 <<  ADDRESS_BITS;

  logic [DATASIZE-1:0] mem [0:DEPTH-1];

  //assign rdata = mem[raddr];

  always_ff @(posedge wclk) begin 
  
    if (winc && !wfull)
      mem[waddr] <= wdata;

	end
	
	always_ff @(posedge rclk)  begin 
	if(rinc && !rempty) 
		rdata<= mem[raddr]+BUG;
	end

endmodule


module read_empty #(parameter ADDRESS_BITS = 9 ) (rinc, rclk, rrst, rq2_write_ptr,rempty,raddr,rptr);

  input   [ADDRESS_BITS :0] rq2_write_ptr;
  input   rinc, rclk, rrst;
  
  
  output  logic [ADDRESS_BITS-1:0] raddr;
  output logic  rempty;
  output logic [ADDRESS_BITS :0] rptr;


  logic [ADDRESS_BITS:0] rbin;
  logic [ADDRESS_BITS:0] rgraynext, rbinnext;
  logic rempty_val,half_empty;

   always_ff @(posedge rclk or negedge rrst)
    if (!rrst)
      {rbin, rptr} <= '0;
    else
      {rbin, rptr} <= {rbin + (rinc & ~rempty), rgraynext}; // debugged 
  
 always_comb begin 
		raddr = rbin[ADDRESS_BITS-1:0];
		rbinnext = rbin + (rinc & ~rempty);
		rgraynext = (rbinnext>>1) ^ rbinnext;
		rempty_val = (rgraynext == rq2_write_ptr);
		half_empty = (rq2_write_ptr == 228);
  end

  always_ff @(posedge rclk or negedge rrst) begin
    if (!rrst)
      rempty <= 1'b1;
    else
      rempty <= rempty_val;
	end
endmodule



module write_full #(parameter ADDRESS_BITS = 9 ) (winc, wclk, wrst, wq2_read_ptr, wfull, waddr, wptr);

  input   [ADDRESS_BITS :0] wq2_read_ptr;
  input   winc, wclk, wrst;
  output  logic [ADDRESS_BITS-1:0] waddr;
  output logic  wfull;
  output logic [ADDRESS_BITS :0] wptr;

   logic [ADDRESS_BITS:0] wbin;
   logic [ADDRESS_BITS:0] wgraynext, wbinnext;
   logic half_full,write_full_val;
   
  always_comb begin 
	waddr = wbin[ADDRESS_BITS-1:0];
	wbinnext = wbin + (winc & ~wfull);
	wgraynext = ( wbinnext >> 1 ) ^ wbinnext;
	write_full_val = (wgraynext=={~wq2_read_ptr[ADDRESS_BITS:ADDRESS_BITS-1], wq2_read_ptr[ADDRESS_BITS-2:0]});
	half_full = wq2_read_ptr == 228;
  end
  
  always_ff @(posedge wclk or negedge wrst)
  begin
    if (!wrst)
      {wbin, wptr} <= '0;
    else
      {wbin, wptr} <= {wbin + (winc & ~wfull), wgraynext}; //debugged
  end

  always_ff @(posedge wclk or negedge wrst)
  begin
    if (!wrst)
	
      wfull <= 1'b0;
	  
    else
      wfull <= write_full_val;
  end
  
endmodule
