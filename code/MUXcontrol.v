module MuxControl( 
    stall_i,   
    RegWrite_i,
    MemWrite_i,
    RegWrite_o,
    MemWrite_o
);

input stall_i;
input RegWrite_i;
input MemWrite_i;

output RegWrite_o;
output MemWrite_o;

assign RegWrite_o = (stall_i? 1'b0 : RegWrite_i);
assign MemWrite_o = (stall_i? 1'b0 : MemWrite_i);

endmodule
