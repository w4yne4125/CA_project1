module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;


MUX32 MUX_PC( // TODO
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);



Control Control(
    .Op_i       (Instruction_Memory.instr_o[6:0]),
    .RegEqual_i (),  // TODO
    .RegDst_o   (),
    .ALUOp_o    (),
    .ALUSrc_o   (), 
    .Branch_o   (),
    .RegWrite_o ()
);

Adder Add_PC(
    .data1_in   (PC.pc_o),
    .data2_in   (32'b100),
    .data_o     ()
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .stall_i    (), // TODO
    .pc_i       (Add_PC.data_o),
    .pc_o       ()
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    ()
);


IF_ID_Flush  IF_ID_Flush(
    // TODO 
    // Structure that detect jump or branch
);

Pipe_IF_ID Pipe_IF_ID( // TODO
    .clk_i         (clk_i),
    .rst_i         (rst_i),
    .flush_i       (),
    .stall_i       (),

    .pc_i          (),
    .pc_o          (),
    .instruction_i (),
    .instruction_o ()
);

Hazard_Detection_Unit Hazard_Detection_Unit(
    .ID_EX_MemRead_i    (),
    .IF_ID_RsAddr_i     (),
    .IF_ID_RtAddr_i     (),
    .ID_EX_RtAddr_i     (),
    .stall_o            ()
);

Immgen Immgen(
    .data_i     (),
    .data_o     ()
);

Register_Equal : Register_Equal(
    .RSData_i   (),
    .RTData_i   (),
    .Equal_o    ()
);

MUX_3 : MUX_IDEX(
    .data1_i    (Instruction_Memory.instr_o[11:7]), // rd
    .data2_i    (Instruction_Memory.instr_o[19:15]),// rs1
    .select_i   (Control.RegDst_o),                 // always 0 -> write to rd
    .data_o     ()
);

Adder Add_Branch(
    .data1_in   (PC.pc_o),
    .data2_in   (32'b100),
    .data_o     ()
);


Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (Instruction_Memory.instr_o[19:15]),
    .RTaddr_i   (Instruction_Memory.instr_o[24:20]),
    .RDaddr_i   (MUX_RegDst.data_o), 
    .RDdata_i   (ALU.data_o),
    .RegWrite_i (Control.RegWrite_o), 
    .RSdata_o   (), 
    .RTdata_o   () 
);

MUX5 MUX_RegDst(
    .data1_i    (Instruction_Memory.instr_o[11:7]), // rd
    .data2_i    (Instruction_Memory.instr_o[19:15]),// rs1
    .select_i   (Control.RegDst_o),                 // always 0 -> write to rd
    .data_o     ()
);

MUX32 MUX_ALUSrc(
    .data1_i    (Registers.RTdata_o),
    .data2_i    (Sign_Extend.data_o),
    .select_i   (Control.ALUSrc_o),
    .data_o     ()
);

Sign_Extend Sign_Extend(
    .data_i     (Instruction_Memory.instr_o[31:20]), 
    .data_o     ()
);
  
ALU ALU(
    .data1_i    (Registers.RSdata_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    ({Instruction_Memory.instr_o[30],Instruction_Memory.instr_o[25],Instruction_Memory.instr_o[14:12]}),
    .ALUOp_i    (Control.ALUOp_o),
    .ALUCtrl_o  ()
);

endmodule

