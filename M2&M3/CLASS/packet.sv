`ifndef PACKET_SV
`define PACKET_SV

import  data_fields::*;
class write_packet;

rand logic [DATASIZE-1:0] wdata;
logic wfull;

endclass

class read_packet;

logic [DATASIZE-1:0] rdata;
logic rempty;

endclass
`endif