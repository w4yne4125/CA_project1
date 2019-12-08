module ALU_Control
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o  
);

// Ports
input [4:0] funct_i;
input [1:0] ALUOp_i;

output [2:0] ALUCtrl_o;

assign ALUCtrl_o = (ALUOp_i != 2'b10) ? 3'b000 :   // Addi
                   (funct_i[4] == 1)  ? 3'b001 :   // Sub
                   (funct_i[3] == 1)  ? 3'b010 :   // Mul
                   (funct_i[0] == 1)  ? 3'b011 :   // And
                   (funct_i[1] == 1)  ? 3'b100 :   // OR
                                        3'b101 ;   // ADD
    
endmodule
