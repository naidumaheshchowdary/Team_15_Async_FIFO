import  data_fields::*;
interface FIFO_int();
    logic  winc, wclk, wrst,rinc, rclk, rrst;
    logic [DATASIZE-1:0] wdata;
    logic [DATASIZE-1:0] rdata;
    logic wfull,rempty;
endinterface