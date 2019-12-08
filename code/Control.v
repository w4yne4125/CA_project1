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
		ALUOp_o <= 2'b10;
		ALUSrc_o <= 1'b0;
		Branch_o <= 1'b0;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		RegWrite_o <= 1'b1;
		MemToReg_o <= 1'b0;
	end
if(Op_i == 7'b0010011)//addi
	begin
		ALUOp_o <= 2'b00;
		ALUSrc_o <= 1'b1;
		Branch_o <= 1'b0;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		RegWrite_o <= 1'b1;
		MemToReg_o <= 1'b0;
	end
if(Op_i == 7'b0000011)//lw
	begin
		ALUOp_o <= 2'b00;
        ALUSrc_o <= 1'b1;
        Branch_o <= 1'b0;
        MemRead_o <= 1'b1;
        MemWrite_o <= 1'b0;
        RegWrite_o <= 1'b1;
        MemToReg_o <= 1'b1;
	end
if(Op_i == 7'b0100011)//sw
	begin
		ALUOp_o <= 2'b00;
        ALUSrc_o <= 1'b1;
        Branch_o <= 1'b0;
        MemRead_o <= 1'b0;
        MemWrite_o <= 1'b1;
        RegWrite_o <= 1'b0;
        MemToReg_o <= 1'b0;//don't care
	end
if(Op_i == 7'b1100011)//beq
	begin
		ALUOp_o <= 2'b01;
		ALUSrc_o <= 1'b0;
		Branch_o <= 1'b1;
		MemRead_o <= 1'b0;
		MemWrite_o <= 1'b0;
		RegWrite_o <= 1'b0;
		MemToReg_o <= 1'b0;//don't care
	end
//assign ALUOp_o  = (Op_i == 7'b0110011) ? 2'b10 : 2'b00; // R-type or add/i
//assign ALUSrc_o  = (Op_i == 7'b0110011) ? 0 : 1; // R-type or addi
//assign RegWrite_o = 1; // Since all the instruction we need to do set this value to 1

endmodule
