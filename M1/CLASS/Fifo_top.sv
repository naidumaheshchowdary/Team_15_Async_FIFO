
module Asynchronous_FIFO  #( parameter DSIZE = 8,parameter ADDRESS_SIZE = 4 )( 
 
  input  logic  winc, wclk, wrst,rinc, rclk, rrst,
  input   logic [DSIZE-1:0] wdata,
  output  logic [DSIZE-1:0] rdata,
  output  logic wfull, rempty
);

  logic [ADDRESS_SIZE-1:0] waddr, raddr;
  logic [ADDRESS_SIZE:0] wq2_read_ptr, rq2_write_ptr;
  logic [ADDRESS_SIZE:0] wptr, rptr;

  sync_r_to_w call_sync_r_to_w  (.wclk(wclk), .wrst(wrst), .rptr(rptr),.wq2_read_ptr(wq2_read_ptr));
  
  sync_w_to_r call_sync_w_to_r  (.rclk(rclk), .rrst(rrst),.wptr(wptr) ,.rq2_write_ptr(rq2_write_ptr));
  
  memory_element #(DSIZE, ADDRESS_SIZE) Call_memory_element (winc, wfull, wclk,waddr, raddr,wdata,rdata);
  
  read_empty #(ADDRESS_SIZE) call_read_empty (.rinc(rinc), .rclk(rclk), .rrst(rrst), .rq2_write_ptr(rq2_write_ptr), .rempty(rempty), .raddr(raddr),.rptr(rptr));
  
  write_full #(ADDRESS_SIZE) call_Write_full (.winc(winc), .wclk(wclk), .wrst(wrst), .wq2_read_ptr(wq2_read_ptr), .wfull(wfull), .waddr(waddr), .wptr(wptr));
 
 

endmodule




