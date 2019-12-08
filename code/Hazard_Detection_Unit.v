module Hazard_Detection_Unit(
    ID_EX_MemRead_i,
    IF_ID_RsAddr_i,
    IF_ID_RtAddr_i,
    ID_EX_RdAddr_i,
    stall_o
)

input ID_EX_MemRead_i;
input [4:0]IF_ID_RsAddr_i;
input [4:0]IF_ID_RtAddr_i;
input [4:0]ID_EX_RdAddr_i;
output stall_o;

if (ID_EX_MemRead_i == 1'b0)
	begin
		assign stall_o = 1'b0;
	end
else
	begin
		if (IF_ID_RsAddr_i == ID_EX_RdAddr_i || IF_ID_RtAddr_i == ID_EX_RdAddr_i)
			begin
				assign stall_o = 1'b1;
			end
		else
			begin
				assign stall_o = 1'b0;
			end
	end
endmodule
