`define Rtype 7'b0110011
`define addi  7'b0010011
`define lw    7'b0000011
`define sw    7'b0100011
`define beq   7'b1100011

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
input RegEqual_i;
output MemWrite_o;
output MemRead_o;
output MemToReg_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;
output Branch_o;
output flush_o;

assign ALUSrc_o   = (Op_i == `addi || Op_i == `lw || Op_i == `sw);
assign MemToReg_o = (Op_i == `lw);
assign RegWrite_o = (Op_i == `Rtype || Op_i == `addi || Op_i == `lw);
assign MemWrite_o = (Op_i == `sw);
assign MemRead_o  = (Op_i == `lw);
assign Branch_o   = (Op_i == `beq && RegEqual_i);
assign flush_o    = (Op_i == `beq && RegEqual_i);
assign ALUOp_o    = (Op_i == `Rtype) ? 2'b10 :
                    (Op_i == `addi)  ? 2'b00 :
                    (Op_i == `lw)    ? 2'b00 :
                    (Op_i == `sw)    ? 2'b00 :
                    (Op_i == `beq)   ? 2'b01 :
                                       2'bxx;

endmodule
