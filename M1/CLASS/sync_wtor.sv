

module sync_w_to_r #( parameter ADDRESS_BITS = 4) (
  input   rclk, rrst, //rclk -> read clock, rrst -> read reset
  input   [ADDRESS_BITS:0] wptr,
  output logic [ADDRESS_BITS:0] rq2_write_ptr
);
  logic [ADDRESS_BITS:0] rq1_write_ptr;


  always_ff @(posedge rclk or negedge rrst) begin
	case(rrst)
		1'b0: begin rq2_write_ptr <= 1'b0; rq1_write_ptr <= 1'b0; end
		1'b1: begin rq2_write_ptr <= rq1_write_ptr; rq1_write_ptr <= wptr; end
		default: begin
           	rq2_write_ptr <= rq1_write_ptr; rq1_write_ptr <= wptr; // Default case to handle any other unexpected values
       		 end
 endcase
end
endmodule


