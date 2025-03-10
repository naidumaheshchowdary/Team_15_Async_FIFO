module write_full #( parameter ADDRESS_BITS = 4 ) (winc, wclk, wrst, wq2_read_ptr, wfull, waddr, wptr);

  input   [ADDRESS_BITS :0] wq2_read_ptr;
  input   winc, wclk, wrst;
  output  logic [ADDRESS_BITS-1:0] waddr;
  output logic  wfull;
  output logic [ADDRESS_BITS :0] wptr;

   logic [ADDRESS_BITS:0] wbin;
   logic [ADDRESS_BITS:0] wgraynext, wbinnext;
   logic half_full,wfull_val;
   
  always_comb begin 
	waddr = wbin[ADDRESS_BITS-1:0];
	wbinnext = wbin + (winc & ~wfull);
	wgraynext = ( wbinnext >> 1 ) ^ wbinnext;
	wfull_val = (wgraynext=={~wq2_read_ptr[ADDRESS_BITS:ADDRESS_BITS-1], wq2_read_ptr[ADDRESS_BITS-2:0]});
	half_full = wq2_read_ptr >= 228;
  end
  
  always_ff @(posedge wclk or negedge wrst)
  begin
    if (!wrst)
      {wbin, wptr} <= '0;
    else
      {wbin, wptr} <= {wbinnext, wgraynext};
  end

  always_ff @(posedge wclk or negedge wrst)
  begin
    if (!wrst)
	
      wfull <= 1'b0;
	  
    else
      wfull <= wfull_val;
  end
  
endmodule