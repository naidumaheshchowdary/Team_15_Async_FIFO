import  data_fields::*;
interface FIFO_int(input bit wclk,rclk,wrst,rrst);
    logic  winc, rinc;
    logic [DATASIZE-1:0] wdata;
    logic [DATASIZE-1:0] rdata;
    logic wfull,rempty;
endinterface