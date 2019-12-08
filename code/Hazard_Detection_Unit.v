module Hazard_Detection_Unit(
    ID_EX_MemRead_i,
    IF_ID_RsAddr_i,
    IF_ID_RtAddr_i,
    ID_EX_RdAddr_i,
    stall_o
);

input ID_EX_MemRead_i;
input [4:0] IF_ID_RsAddr_i;
input [4:0] IF_ID_RtAddr_i;
input [4:0] ID_EX_RdAddr_i;
output stall_o;

assign stall_o = (ID_EX_MemRead_i && ((ID_EX_RtAddr_i == IF_ID_RsAddr_i) || (ID_EX_RtAddr_i == IF_ID_RtAddr_i)) ) ? 1'b1 : 1'b0;

endmodule
