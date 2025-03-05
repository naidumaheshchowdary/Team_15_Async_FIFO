module read_empty #( parameter ADDRESS_BITS = 4 ) (rinc, rclk, rrst, rq2_write_ptr,rempty,raddr,rptr);

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
      {rbin, rptr} <= {rbinnext, rgraynext};
  
 always_comb begin 
		raddr = rbin[ADDRESS_BITS-1:0];
		rbinnext = rbin + (rinc & ~rempty);
		rgraynext = (rbinnext>>1) ^ rbinnext;
		rempty_val = (rgraynext == rq2_write_ptr);
		half_empty = (rq2_write_ptr >= 228);
  end

  always_ff @(posedge rclk or negedge rrst) begin
    if (!rrst)
      rempty <= 1'b1;
    else
      rempty <= rempty_val;
	end
endmodule

