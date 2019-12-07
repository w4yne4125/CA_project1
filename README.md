###各stage 所需的component 以及對應的 class


----------------------------------

- MUX_PC : MUX32
- PC : PC
- Add_PC : Adder
- Instruction_Memory : Instruction_Memory

---------------------------------

- Pipe_IF_ID : Pipe_IF_ID

----------------------------------

- Hazard_Detection_Unit : Hazard_Detection_Unit
- Control : Control
- Immgen : Immgen
- Register_Equal : Register_Equal
- MUX_IDEX : MUXcontrol
- Add_Branch : Adder
- Registers : Registers

-------------分配線-------------------


----------------------------------

- Pipe_ID_EX : Pipe_ID_EX

----------------------------------

- MUX_ALU1 : MUX32_3
- MUX_ALU2 : MUX32_3
- MUX_ALUSrc : MUX32
- ALU : ALU
- ALU_Control : ALU_Control 
- Forwarding_Unit : Forwarding_Unit

----------------------------------

- Pipe_EX_MEM : Pipe_EX_MEM

----------------------------------

- DataMemory : DataMemory

----------------------------------

- Pipe_MEM_WB : Pipe_MEM_WB

----------------------------------

- MUX_WB : MUX32 
