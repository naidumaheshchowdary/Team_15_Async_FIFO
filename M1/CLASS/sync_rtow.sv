
module sync_r_to_w #( parameter ADDRESS_SIZE = 4 )(

  input   wclk, wrst,
  input   [ADDRESS_SIZE:0] rptr,
  output logic [ADDRESS_SIZE:0] wq2_read_ptr
);

   logic [ADDRESS_SIZE:0] wq1_read_ptr;
  always_ff @(posedge wclk or negedge wrst) begin
	case(wrst)
	1'b0: begin wq2_read_ptr <= 0; wq1_read_ptr <= 0; end
   	1'b1: begin wq2_read_ptr <= wq1_read_ptr; wq1_read_ptr <= rptr;end
	default: begin
		wq2_read_ptr <= wq1_read_ptr; wq1_read_ptr <= rptr; // Default case to handle any other unexpected values
        end
  endcase
end

endmodule


