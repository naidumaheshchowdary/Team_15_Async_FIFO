
module write_full #( 
    parameter ADDRESS_SIZE = 4 
) (
    input logic [ADDRESS_SIZE:0] wq2_read_ptr, 
    input logic winc, wclk, wrst, 
    
    output logic [ADDRESS_SIZE-1:0] waddr, 
    output logic wfull, 
    output logic [ADDRESS_SIZE:0] wptr
);

   
    reg [ADDRESS_SIZE:0] wbin, wbinnext, wr_ptr_compare;
    reg write_full_val, half_full;

     always_comb begin 
         waddr = wbin[ADDRESS_SIZE-1:0];
        
         wbinnext = wbin + (winc & ~wfull);
        
        write_full_val = (wbinnext == {~wq2_read_ptr[ADDRESS_SIZE:ADDRESS_SIZE-1], wq2_read_ptr[ADDRESS_SIZE-2:0]});

         half_full = (wq2_read_ptr >= (1 << (ADDRESS_SIZE - 1)));

        wr_ptr_compare = wbin + 1'b1;
    end

    always_ff @(posedge wclk or negedge wrst) begin
        if (!wrst) begin
            wbin <= 0;
            wptr <= 0;
        end else begin
            wbin <= wbinnext;
            wptr <= wr_ptr_compare;
        end
    end

    always_ff @(posedge wclk or negedge wrst) begin
        if (!wrst)
            wfull <= 1'b0;
        else
            wfull <= write_full_val;
    end

endmodule


