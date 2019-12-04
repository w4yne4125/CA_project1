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

// ------------------IF Stage Start----------------

MUX32 MUX_PC( 
    .data1_i    (Add_PC.data_o),
    .data2_i    (Add_Branch.data_o),
    .select_i   (Control.Branch_o),
    .data_o     ()
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .stall_i    (Hazard_Detection_Unit.stall_o), 
    .pc_i       (MUX_PC.data_o),
    .pc_o       ()
);


Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    ()
);

Adder Add_PC(
    .data1_in   (PC.pc_o),
    .data2_in   (32'b100),
    .data_o     ()
);

// ------------------IF Stage End----------------

Pipe_IF_ID Pipe_IF_ID( 
    .clk_i         (clk_i),
    .rst_i         (rst_i),
    .flush_i       (Control.flush_o),
    .stall_i       (Hazard_Detection_Unit.stall_o),

    .pc_i          (PC.pc_o),
    .instruction_i (Instruction_Memory.instr_o),

    .pc_o          (),
    .instruction_o ()
);

// ------------------ID Stage Start----------------

Hazard_Detection_Unit Hazard_Detection_Unit( // CARE
    .ID_EX_MemRead_i    (Pipe_ID_EX.MemRead_o),
    .IF_ID_RsAddr_i     (Pipe_IF_ID.instruction_o[19:15]),
    .IF_ID_RtAddr_i     (Pipe_IF_ID_instruction_o[24:20]),
    .ID_EX_RdAddr_i     (Pipe_ID_EX_instruction_o[11:7]),
    .stall_o            ()
);

Control Control( // CARE
    .Op_i       (Instruction_Memory.instr_o[6:0]),
    .RegEqual_i (Register_Equal.Equal_o), 
    .MemWrite_o (),
    .MemRead_o  (),
    .MemToReg_o (),
    .ALUOp_o    (),
    .ALUSrc_o   (), 
    .RegWrite_o (),
    .Branch_o   (),
    .flush_o    ()
);

Immgen Immgen( 
    .data_i     (Pipe_IF_ID.instruction_o),
    .data_o     ()
);


MuxControl MUX_IDEX ( // care
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

Register_Equal Register_Equal(
    .RSData_i   (Registers.RSdata_o),
    .RTData_i   (Registers.RTdata_o),
    .Equal_o    ()
);

Adder Add_Branch( 
    .data1_in   (Pipe_IF_ID.pc_o),
    .data2_in   (Immgen.data_o), // not shift yet
    .data_o     ()
);


Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (Instruction_Memory.instr_o[19:15]),
    .RTaddr_i   (Instruction_Memory.instr_o[24:20]),
    .RDaddr_i   (Pipe_MEM_WB.RdAddr_o), 
    .RDdata_i   (MUX_WB.data_o),
    .RegWrite_i (Pipe_MEM_WB.RegWrite_o), 
    .RSdata_o   (), 
    .RTdata_o   () 
);

// ------------------ID Stage End----------------

Pipe_ID_EX Pipe_ID_EX(
    .clk_i          (clk_i),
    .rst_i          (rst_i),

    .RSdata_i       (Registers.RSdata_o),
    .RTdata_i       (Registers.RTdata_o),
    .RSdata_o       (),
    .RTdata_o       (),
    .RSaddr_i       (Piep_IF_ID.instruction_o[19:15]),
    .RTaddr_i       (Piep_IF_ID.instruction_o[24:20]),
    .RDaddr_i       (Piep_IF_ID.instruction_o[11:7 ]),
    .RSaddr_o       (),
    .RTaddr_o       (),
    .RDaddr_o       (),
    .immed_i        (Immgen.data_o),
    .immed_o        (),

    // Control Outputs
    .ALUSrc_i        (MUX_IDEX.ALUSrc_o),
    .MemToReg_i      (MUX_IDEX.MemToReg_o),
    .RegWrite_i      (MUX_IDEX.RegWrite_o),
    .MemWrite_i      (MUX_IDEX.MemWrite_o),
    .MemRead_i       (MUX_IDEX.MemRead_i),
    .ALUOp_i         (MUX_IDEX.ALUOp_o),
    .ALUSrc_o        (),
    .MemToReg_o      (),
    .RegWrite_o      (),
    .MemWrite_o      (),
    .MemRead_o       (),
    .ALUOp_o         ()
);

// ------------------EXE Stage Start----------------

Mux32_3 MUX_ALU1(
    .data0_i    (Pipe_ID_EX.RSdata_o),
    .data1_i    (Pipe_EX_MEM.ALU_Res_o),
    .data2_i    (MUX_WB.data_o),
    .select_i   (Forwarding_Unit.EX_RsOverride_o),
    .data_o     ()
);

Mux32_3 MUX_ALU2(
    .data0_i    (Pipe_ID_EX.RTdata_o),
    .data1_i    (Pipe_EX_MEM.ALU_Res_o),
    .data2_i    (MUX_WB.data_o),
    .select_i   (Forwarding_Unit.EX_RtOverride_o),
    .data_o     ()
);

Mux32 MUX_ALUSrc(
    .data0_i    (MUX_ALU2.data_o),
    .data1_i    (Pipe_ID_EX.Immgen_o),
    .select_i   (Pipe_ID_EX.ALUSrc_o),
    .data_o     ()
);

Forwarding_Unit Forwarding_Unit(
    .ID_EX_RsAddr_i     (Pipe_ID_EX.instruction_o[19:15]),
    .ID_EX_RtAddr_i     (Pipe_ID_EX.instruction_o[24:20]),
    .EX_MEM_RegWrite_i  (Pipe_EX_MEM.RegWrite_o),
    .EX_MEM_RdAddr_i    (Pipe_EX_MEM.RdAddr_o),
    .MEM_WB_RegWrite_i  (Pipe_MEM_WB.RegWrite_o),
    .MEM_WB_RdAddr_i    (Pipe_MEM_WB.RdAddr_o),
    .EX_RsOverride_o    (),
    .EX_RtOverride_o    ()
);

ALU ALU(
    .data1_i    (MUX_ALU1.data_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (Pipe_ID_EX.instruction_o),
    .ALUOp_i    (Pipe_ID_EX.ALUOp_o),
    .ALUCtrl_o  ()
);

// ------------------EXE Stage End----------------

Pipe_EX_MEM Pipe_EX_MEM(
    .clk_i          (clk_i),
    .rst_i          (rst_i),
    
    .ALU_Res_i      (ALU.data_o),
    .ALU_Res_o      (),
    .Write_Data_i   (MUX_ALU2.data_o),
    .Write_Data_o   (),
    .RdAddr_i       (Pipe_ID_EX.RDaddr_o),
    .RdAddr_o       (),

    .MemToReg_i     (Pipe_ID_EX.MemToReg_o),
    .RegWrite_i     (Pipe_ID_EX.RegWrite_o),
    .MemWrite_i     (Pipe_ID_EX.MemWrite_o),
    .MemRead_i      (Pipe_ID_EX.MemRead_o),
    .MemToReg_o     (),
    .RegWrite_o     (),
    .MemWrite_o     (),
    .MemRead_o      (),
);

// ------------------MEM Stage Start----------------

Data_Memory Data_Memory(
    .clk_i       (clk_i),
    .addr_i      (Pipe_EX_MEM.ALU_Res_o),
    .memRead_i   (Pipe_EX_MEM.MemRead_o),
    .memWrite_i  (Pipe_EX_MEM.MemWrite_o),
    .Write_Data_i(Pipe_EX_MEM.Write_Data_o),
    .Read_Data_o ()
);


// ------------------MEM Stage End----------------

Pipe_MEM_WB Pipe_MEM_WB(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    
    .ALU_Res_i  (Pipe_EX_MEM.ALU_Res_o),
    .ALU_Res_o  (),
    .Read_Data_i(Data_Memory.Read_Data_o),
    .Read_Data_o(),
    .RdAddr_i   (Pipe_EX_MEM.RdAddr_o),
    .RdAddr_o   (),
    .MemToReg_i (Pipe_EX_MEM.MemToReg_o),
    .RegWrite_i (Pipe_EX_MEM.RegWrite_o),
    .MemToReg_o (),
    .RegWrite_o ()
);

// ------------------WB Stage Start----------------

Mux32 MUX_WB(
    .data0_i    (Pipe_MEM_WB.ALU_Res_o),
    .data1_i    (Pipe_MEM_WB.Read_Data_o),
    .select_i   (Pipe_MEM_WB.MemToReg_o),
    .data_o     ()
);


endmodule

