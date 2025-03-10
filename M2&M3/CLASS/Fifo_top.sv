module Asynch_FIFO  #( parameter DSIZE = 8,parameter ADDRESS_BITS = 9 ) (rdata,wfull,rempty,wdata,rinc,rclk,rrst,winc,wclk,wrst );
 
  input  logic  winc, wclk, wrst,rinc, rclk, rrst;
  input   logic [DSIZE-1:0] wdata;
  output  logic [DSIZE-1:0] rdata;
  output  logic wfull,rempty; 


  wire [ADDRESS_BITS-1:0] waddr, raddr;
  wire [ADDRESS_BITS:0] wq2_read_ptr, rq2_write_ptr;
  wire [ADDRESS_BITS:0] write_ptr, read_ptr;

  sync_r_to_w sync_r_to_w (wclk, wrst, read_ptr,wq2_read_ptr);
  
  sync_w_to_r sync_w_to_r (rclk, rrst,write_ptr,rq2_write_ptr );
  
  FIFO_memory #(DSIZE, ADDRESS_BITS) MEM (winc, wfull, wclk,waddr, raddr,wdata,rdata);
  
  read_empty #(ADDRESS_BITS) Read_emp_ptr (rinc, rclk, rrst, rq2_write_ptr,rempty,raddr,read_ptr);
  
  write_full #(ADDRESS_BITS) wfull_ptr (winc, wclk, wrst, wq2_read_ptr, wfull, waddr, write_ptr);


endmodule
