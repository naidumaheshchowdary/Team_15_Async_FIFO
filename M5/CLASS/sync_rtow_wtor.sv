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
