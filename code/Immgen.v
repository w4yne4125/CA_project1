module Immgen(
	data_i,
	data_o
)
input [31:0] data_i;
output reg [63:0] data_o;

assign data_o = {{32{data_i[31]}},data_i[11:0]};
endmodule
