
/*
module read_empty #( 
    parameter ADDRESS_SIZE = 4 
) (
    input logic [ADDRESS_SIZE:0] rq2_write_ptr, 
    input logic rinc, rclk, rrst, 
    
    output logic [ADDRESS_SIZE -1:0] raddr, 
    output logic rempty, 
    output logic [ADDRESS_SIZE:0] rptr
);

    reg [ADDRESS_SIZE:0] rbin, rgraynext, rbinnext;
    reg rempty_val, half_empty;


    always_ff @(posedge rclk or negedge rrst) begin
        if (!rrst) begin
            rbin <= 1'b0;
            rptr <= 1'b0;
        end else begin
            rbin <= rbinnext;
            rptr <= rgraynext;
        end
    end

    always_comb begin
        raddr = rbin[ADDRESS_SIZE-1:0]; 
        rbinnext = rbin + (rinc & ~rempty); 
        rgraynext = (rbinnext >> 1) ^ rbinnext; 
        
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
*/

module read_empty #( parameter ADDRESS_SIZE = 4 ) 
(
  input   [ADDRESS_SIZE :0] rq2_write_ptr,  
  input   rinc, rclk, rrst,
  
  output  logic [ADDRESS_SIZE-1:0] raddr, 
  output logic  rempty,                   
  output logic [ADDRESS_SIZE :0] rptr 
  );

  logic [ADDRESS_SIZE:0] rbin, rbinnext;
  logic rempty_val;

 

  always_comb begin
    raddr = rbin[ADDRESS_SIZE-1:0]; 
    rbinnext = rbin + (rinc & ~rempty);  
    rempty_val = (rbin == rq2_write_ptr);  
  end

  
always_ff @(posedge rclk or negedge rrst) begin
	case(rrst)
	1'b0: begin rempty <= 1'b1;rbin <= 1'b0 ; end
   	1'b1: begin rempty <= rempty_val;rbin <= rbinnext; end
	default: begin rempty <= rempty_val;rbin <= rbinnext;   end
  endcase
end


  // Read pointer output
  assign rptr = rbin;

endmodule

