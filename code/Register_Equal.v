module Register_Equal(
	RSData_i,
	RTData_i,
	Equal_o
)
input [31:0]RSData_i;
input [31:0]RTData_i;
output Equal_o;

if (RSData_i == RTData_i)
	assign Equal_o = 1; 
else
	assign Equal_o = 0;

endmodule
