module Control
(
    Op_i,
    RegDst_o,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

// Ports
input [6:0] Op_i;
output RegDst_o;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;

assign RegDst_o = 0; // Since all the instruction we need to do set this value to 0
assign ALUOp_o  = (Op_i == 7'b0110011) ? 2'b10 : 2'b00; // R-type or addi
assign ALUSrc_o  = (Op_i == 7'b0110011) ? 0 : 1; // R-type or addi
assign RegWrite_o = 1; // Since all the instruction we need to do set this value to 1

endmodule
