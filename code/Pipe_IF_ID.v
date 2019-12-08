module Pipe_IF_ID( 
    clk_i,
    rst_i,
    flush_i,     
    stall_i,    
    pc_i,    
    instruction_i,
    pc_o,        
    instruction_o, 
);

input clk_i;
input rst_i;
input flush_i;
input stall_i;
input [31:0] pc_i;
input [31:0] instruction_i;
output reg [31:0] pc_o;
output reg [31:0] instruction_o;

always @(posedge clk_i or negedge rst_i) begin
    if (~rst_i) begin
        instruction_o <= 0;
        pc_o <= 0;
    end
    else begin
        if( !stall_i ) begin
            if( flush_i ) begin
                instruction_o <= 0;
                pc_o <= 0;
            end
            else begin
                // Pass through
                instruction_o <= instruction_i;
                pc_o <= pc_i;
            end
        end
    end
end

endmodule
