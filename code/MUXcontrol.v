module MuxControl( 
    .stall_i    (Hazard_Detection_Unit.stall_o),
    .ALUSrc_i   (Control.ALUSrc_o),
    .MemToReg_i (Control.MemToReg_o),
    .RegWrite_i (Control.RegWrite_o),
    .MemWrite_i (Control.MemWrite_o),
    .MemRead_i  (Control.MemRead_o),
    .Branch_i   (Control.Branch_o),
    .ALUOp_i    (Control.ALUOp_o),
    .ALUSrc_o   (),
    .MemToReg_o (),
    .RegWrite_o (),
    .MemWrite_o (),
    .MemRead_o  (),
    .Branch_o   (),
    .ALUOp_o    ()
);

input stall_i;
input ALUSrc_i;
input MemToReg_i;
input RegWrite_i;
input MemWrite_i;
input MemRead_i;
input Branch_i;
input [1:0]  ALUOp_i;
output ALUSrc_o;
output MemToReg_o;
output RegWrite_o;
output MemWrite_o;
output MemRead_o;
output Branch_o;
output [1:0] ALUOp_o;

assign ALUSrc_o   = (stall_i? 1'b0 : ALUSrc_i);
assign MemToReg_o = (stall_i? 1'b0 : MemToReg_i);
assign RegWrite_o = (stall_i? 1'b0 : RegWrite_i);
assign MemWrite_o = (stall_i? 1'b0 : MemWrite_i);
assign MemRead_o  = (stall_i? 1'b0 : MemRead_i);
assign Branch_o   = (stall_i? 1'b0 : Branch_i);
assign ALUOp_o    = (stall_i? 2'b00 : ALUOp_i);

endmodule
