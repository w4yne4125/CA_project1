module Forwarding_Unit(
    ID_EX_RsAddr_i,
    ID_EX_RtAddr_i,
    EX_MEM_RegWrite_i,
    EX_MEM_RdAddr_i,
    MEM_WB_RegWrite_i,
    MEM_WB_RdAddr_i,
    EX_RsOverride_o,
    EX_RtOverride_o
);

//ports

input [4:0] ID_EX_RsAddr_i;
input [4:0] ID_EX_RtAddr_i;
input  EX_MEM_RegWrite_i;
input [4:0] EX_MEM_RdAddr_i;
input  MEM_WB_Regwrite_i;
input [4:0] MEM_WB_RdAddr_i;
output [2:0] EX_RsOverride_o;
output [2:0] EX_RdOverride_o;

assign EX_RsOverride_o = (EX_MEM_RegWrite_i && (EX_MEM_RdAddr_i != 0) && (EX_MEM_RdAddr_i == ID_EX_RsAddr_i)) ? 2'b10 :
	                    (MEM_WB_RegWrite_i && !(EX_MEM_RegWrite_i && (EX_MEM_RdAddr_i != 0) && (EX_MEM_RdAddr_i == ID_EX_RsAddr_i)) && (MEM_WB_RdAddr_i == ID_EX_RsAddr_i)) ? 2'b01 :
						2'b00;


assign EX_RtOverride_o = (EX_MEM_RegWrite_i && (EX_MEM_RdAddr_i != 0) && (EX_MEM_RdAddr_i == ID_EX_RtAddr_i)) ? 2'b10 :
						(MEM_WB_RegWrite_i && !(EX_MEM_RegWrite_i && (EX_MEM_RdAddr_i != 0) && (EX_MEM_RdAddr_i == ID_EX_RtAddr_i)) && (MEM_WB_RdAddr_i == ID_EX_RtAddr_i)) ? 2'b01 :
						2'b00;


endmodule

