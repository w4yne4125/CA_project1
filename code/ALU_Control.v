module ALU_Control
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o  
);

// Ports
input [31:0] funct_i;
input [1:0] ALUOp_i;

output [2:0] ALUCtrl_o;

wire [4:0] cut;
assign cut = {funct_i[30], funct_i[25], funct_i[14:12]};

assign ALUCtrl_o = (ALUOp_i != 2'b10) ? 3'b000 :   // Addi
                   (cut[4] == 1)  ? 3'b001 :   // Sub
                   (cut[3] == 1)  ? 3'b010 :   // Mul
                   (cut[0] == 1)  ? 3'b011 :   // And
                   (cut[1] == 1)  ? 3'b100 :   // OR
                                    3'b101 ;   // ADD
    
endmodule
