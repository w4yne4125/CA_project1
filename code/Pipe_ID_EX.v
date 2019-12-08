module Pipe_ID_EX(
	clk_i,
	rst_i,

	RSdata_i,
	RTdata_i,
	RSdata_o,
	RTdata_o,
	RSaddr_i,
	RTaddr_i,
	RDaddr_i,
	RSaddr_o,
	RTaddr_o,
	RDaddr_o,
	immed_i,
	immed_o,

    instruction_i,
    instruction_o,
	//control output
	ALUSrc_i,
    MemToReg_i,
    RegWrite_i,
    MemWrite_i,
    MemRead_i,
    ALUOp_i,
    ALUSrc_o,
    MemToReg_o,
    RegWrite_o,
    MemWrite_o,
    MemRead_o,
    ALUOp_o
);

input clk_i,rst_i;
input [31:0] RSdata_i,RTdata_i, instruction_i;
input [4:0] RSaddr_i,RTaddr_i,RDaddr_i;
input [31:0]immed_i;
input ALUSrc_i;//
input MemToReg_i;//
input RegWrite_i;//
input MemWrite_i;//
input MemRead_i;//
input [1:0] ALUOp_i;

output reg [31:0] RSdata_o,RTdata_o, instruction_o;
output reg [4:0] RSaddr_o,RTaddr_o,RDaddr_o;
output reg [31:0]immed_o;
output reg ALUSrc_o;//
output reg MemToReg_o;//                                                                               
output reg RegWrite_o;//
output reg MemWrite_o;//
output reg MemRead_o;//
output reg [1:0] ALUOp_o;//



always @(posedge clk_i or negedge rst_i)begin
    if (!rst_i) begin
    	RSdata_o <= 0;
    	RTdata_o <= 0;
        immed_o  <= 0;	
    	RSaddr_o <= 0;
    	RTaddr_o <= 0;
    	RDaddr_o <= 0;
    	ALUSrc_o <= 0;
       
    	MemToReg_o <= 0;
        RegWrite_o <= 0;
        MemWrite_o <= 0;
        MemRead_o <= 0;
        ALUOp_o <= 0;
        instruction_o <= 0;
        
    end
    else begin
    	RSdata_o <= RSdata_i;
    	RTdata_o <= RTdata_i;
        immed_o  <= immed_i;	
    	
    	RSaddr_o <= RSaddr_i;
    	RTaddr_o <= RTaddr_i;
    	RDaddr_o <= RDaddr_i;
    	ALUSrc_o <= ALUSrc_o;
       
    	MemToReg_o <= MemToReg_i;
        RegWrite_o <= RegWrite_i;
        MemWrite_o <= MemWrite_i;
        MemRead_o <= MemRead_i;
        ALUOp_o <= ALUOp_i;
        instruction_o <= instruction_i;
    end

end
endmodule
