
module memory_element #( parameter DSIZE = 8, parameter ADDRESS_SIZE = 4) 
(
  input   winc, wfull, wclk,
  input   [ADDRESS_SIZE-1:0] raddr,waddr,
  input   [DSIZE-1:0] wdata,
  output  logic [DSIZE-1:0] rdata
);


  localparam DEPTH = 2**ADDRESS_SIZE;

  logic [DSIZE-1:0] memory [0: DEPTH-1];

  assign rdata = memory[raddr];

  always_ff @(posedge wclk)
  
    if (winc && !wfull)
      memory[waddr] <= wdata;

endmodule



