module Pipe_MEM_WB(
    clk_i,
    rst_i,
    
    ALU_Res_i,
    ALU_Res_o,
    Read_Data_i,
    Read_Data_o,
    RdAddr_i   ,
    RdAddr_o   ,
    MemToReg_i ,
    RegWrite_i ,
    MemToReg_o ,
    RegWrite_o 
);

input  clk_i;
input  rst_i;
input  [31:0] ALU_Res_i;
input  [31:0] Read_Data_i;
input  [4:0] RdAddr_i;
input  MemToReg_i;
input  RegWrite_i;

output reg [31:0] ALU_Res_o;
output reg [31:0] Read_Data_o;
output reg [4:0] RdAddr_o;
output reg MemToReg_o;
output reg RegWrite_o;

always @(posedge clk_i or negedge rst_i) begin
    if (!rst_i) begin
        ALU_Res_o <= 0;
        Read_Data_o <= 0;
        RdAddr_o <= 0;
        MemToReg_o <= 0;
        RegWrite_o <= 0;
    end
    else begin
        ALU_Res_o <= ALU_Res_i;
        Read_Data_o <= Read_Data_i;
        RdAddr_o <= RdAddr_i;
        MemToReg_o <= MemToReg_i;
        RegWrite_o <= RegWrite_i;
    end
end

endmodule
