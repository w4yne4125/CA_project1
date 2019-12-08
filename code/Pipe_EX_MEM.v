module Pipe_EX_MEM(
    clk_i,  
    rst_i,
    
    ALU_Res_i,
    ALU_Res_o,
    Write_Data_i,
    Write_Data_o,
    RdAddr_i,
    RdAddr_o,

    MemToReg_i,
    RegWrite_i,
    MemWrite_i,
    MemRead_i ,
    MemToReg_o,
    RegWrite_o,
    MemWrite_o,
    MemRead_o ,
);
input      [31:0] ALU_Res_i;
output reg [31:0] ALU_Res_o;
input      [31:0] Write_Data_i;
output reg [31:0] Write_Data_o;
input      [4:0]  RdAddr_i;
output reg [4:0]  RdAddr_o;

input            MemToReg_i;
input            RegWrite_i;
input            MemWrite_i;
input            MemRead_i;
output reg       MemToReg_o;
output reg       RegWrite_o;
output reg       MemWrite_o;
output reg       MemRead_o;


always @(posedge clk_i or negedge rst_i) begin
    if( !rst_i ) begin
        ALU_Res_o <= 0;
        Write_Data_o <= 0;
        RdAddr_o <= 0;
        MemToReg_o <= 0;
        RegWrite_o <= 0;
        MemWrite_o <= 0;
        MemRead_o <= 0;
    end
    else begin
        ALU_Res_o <= ALU_Res_i;
        Write_Data_o <= Write_Data_i;
        RdAddr_o <= RdAddr_i;
        MemToReg_o <= MemToReg_i;
        RegWrite_o <= RegWrite_i;
        MemWrite_o <= MemWrite_i;
        MemRead_o <= MemRead_i;
    end
end

endmodule
