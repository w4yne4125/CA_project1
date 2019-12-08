module Register_Equal(
	RSData_i,
	RTData_i,
	Equal_o
);
input [31:0]RSData_i;
input [31:0]RTData_i;
output Equal_o;


assign Equal_o = (RSData_i == RTData_i) ? 1 : 0;

endmodule
