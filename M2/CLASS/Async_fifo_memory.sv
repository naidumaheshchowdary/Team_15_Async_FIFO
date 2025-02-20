module FIFO_memory #( parameter DSIZE = 8, parameter ADDRESS_BITS = 9) (winc, wfull, wclk,waddr, raddr,wdata,rdata);

  input   winc, wfull, wclk;
  input   [ADDRESS_BITS-1:0] raddr,waddr ;
  input   [DSIZE-1:0] wdata;
  output  logic [DSIZE-1:0] rdata;


  localparam DEPTH = 1 <<  ADDRESS_BITS;

  logic [DSIZE-1:0] mem [0:DEPTH-1];

  assign rdata = mem[raddr];

  always_ff @(posedge wclk)
  
    if (winc && !wfull)
      mem[waddr] <= wdata;

endmodule