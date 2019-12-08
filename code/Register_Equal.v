module Register_Equal(
	data1_in,
	data2_in,
	data_o
)
input [31:0]data1_in;
input [31:0]data2_in;
output Equal;

if (data1_in == data2_in)
	assign Equal = 1; 
else
	assign Equal = 0;

endmodule
