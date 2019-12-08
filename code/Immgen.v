module Immgen(
	data_i,
	data_o
);
input [31:0] data_i;
output reg [31:0] data_o;

if (data_i[6:0] == 7'b0010011 || data_i[6:0] == 7'b0000011)
	begin
		assign data_o = { {20{data_i[31]}} , data_i[31:21] };
	end
if (data[6:0] == 7'b0100011)
	begin
		assign data_o = { {20{data_i[31]}},data_i[31:25],data_i[11:7]};
	end
if (data[6:0] == 7'b1100011)
	begin
		assign data_o = { {20{data_i[31]}},data_i[31],data_i[7],data_i[30:25],data_i[11:8]};
	end
endmodule
