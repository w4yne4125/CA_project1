module Control
(
    Op_i,
    RegEqual_i,
	MemWrite_o,
	MemRead_o,
	MemToReg_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
	Branch_o,
	flush_o
);

// Ports
input [6:0] Op_i;
output MemWrite_o;
output MemRead_o;
output MemToReg_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;
output Branch_o;
output flush_o;

if(Op_i == 7'b0110011)//Rformat
	begin
		assign ALUOp_o = 2'b10;
		assign LUSrc_o = 1'b0;
		assign Branch_o = 1'b0;
		assign MemRead_o = 1'b0;
		assign MemWrite_o = 1'b0;
		assign RegWrite_o = 1'b1;
		assign MemToReg_o = 1'b0;
		assign flush_o = 1'b0;
	end
if(Op_i == 7'b0010011)//addi
	begin
		assign ALUOp_o = 2'b00;
		assign ALUSrc_o = 1'b1;
		assign Branch_o = 1'b0;
		assign MemRead_o = 1'b0;
		assign MemWrite_o = 1'b0;
		assign RegWrite_o = 1'b1;
		assign MemToReg_o = 1'b0;
		assign flush_o = 1'b0;
	end
if(Op_i == 7'b0000011)//lw
	begin
		assign ALUOp_o = 2'b00;
        assign ALUSrc_o = 1'b1;
        assign Branch_o = 1'b0;
        assign MemRead_o = 1'b1;
        assign MemWrite_o = 1'b0;
        assign RegWrite_o = 1'b1;
        assign MemToReg_o = 1'b1;
		assign flush_o = 1'b0;
	end
if(Op_i == 7'b0100011)//sw
	begin
		assign ALUOp_o = 2'b00;
        assign ALUSrc_o = 1'b1;
        assign Branch_o = 1'b0;
        assign MemRead_o = 1'b0;
        assign MemWrite_o = 1'b1;
        assign RegWrite_o = 1'b0;
        assign MemToReg_o = 1'b0;//don't care
		assign flush_o = 1'b0;
	end
if(Op_i == 7'b1100011)//beq
	begin
		assign ALUOp_o = 2'b01;
		assign ALUSrc_o = 1'b0;
		assign Branch_o = 1'b1;
		assign MemRead_o = 1'b0;
		assign MemWrite_o = 1'b0;
		assign RegWrite_o = 1'b0;
		assign MemToReg_o = 1'b0;//don't care
		assign flush_o = 1'b1;
	end
//assign ALUOp_o  = (Op_i == 7'b0110011) ? 2'b10 : 2'b00; // R-type or add/i
//assign ALUSrc_o  = (Op_i == 7'b0110011) ? 0 : 1; // R-type or addi
//assign RegWrite_o = 1; // Since all the instruction we need to do set this value to 1

endmodule
