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



assign ALUOp_o = (Op_i == 7'b0110011) ? 2'b10 :
                 (Op_i == 7'b0010011) ? 2'b00 : 
                 (Op_i == 7'b0000011) ? 2'b00 :
                 (Op_i == 7'b0100011) ? 2'b00 :
                                        2'b01 ;
                        

assign ALUSrc_o =(Op_i == 7'b0110011) ? 1'b0 :
                 (Op_i == 7'b0010011) ? 1'b1 : 
                 (Op_i == 7'b0000011) ? 1'b1 :
                 (Op_i == 7'b0100011) ? 1'b1 :
                                        1'b0 ;


assign Branch_o =(Op_i == 7'b0110011) ? 1'b0 :
                 (Op_i == 7'b0010011) ? 1'b0 : 
                 (Op_i == 7'b0000011) ? 1'b0 :
                 (Op_i == 7'b0100011) ? 1'b0 :
                                        1'b1 ;

assign MemRead_o = (Op_i == 7'b0110011) ? 1'b0 :
                   (Op_i == 7'b0010011) ? 1'b0 : 
                   (Op_i == 7'b0000011) ? 1'b1 :
                   (Op_i == 7'b0100011) ? 1'b0 :
                                          1'b0 ;

assign MemWrite_o = (Op_i == 7'b0110011) ? 1'b0 :
                    (Op_i == 7'b0010011) ? 1'b0 : 
                    (Op_i == 7'b0000011) ? 1'b0 :
                    (Op_i == 7'b0100011) ? 1'b1 :
                                           1'b0 ;


assign RegWrite_o = (Op_i == 7'b0110011) ? 1'b1 :
                    (Op_i == 7'b0010011) ? 1'b1 : 
                    (Op_i == 7'b0000011) ? 1'b1 :
                    (Op_i == 7'b0100011) ? 1'b0 :
                                           1'b0 ;

assign MemToReg_o = (Op_i == 7'b0110011) ? 1'b0 :
                    (Op_i == 7'b0010011) ? 1'b0 : 
                    (Op_i == 7'b0000011) ? 1'b1 :
                    (Op_i == 7'b0100011) ? 1'b0 :
                                           1'b0 ;

assign flush_o =   (Op_i == 7'b0110011) ? 1'b0 :
                   (Op_i == 7'b0010011) ? 1'b0 : 
                   (Op_i == 7'b0000011) ? 1'b0 :
                   (Op_i == 7'b0100011) ? 1'b0 :
                                          1'b1 ;
endmodule
