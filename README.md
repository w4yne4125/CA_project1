###各stage 所需的component 以及對應的 class


----------------------------------

- MUX_PC : MUX32    [done]
- PC : PC           [done]
- Add_PC : Adder    [done]
- Instruction_Memory : Instruction_Memory  [done]

---------------------------------

- Pipe_IF_ID : Pipe_IF_ID  [done]

----------------------------------

- Hazard_Detection_Unit : Hazard_Detection_Unit
- Control : Control		[need to deal with flush]
- Immgen : Immgen		[need to check]
- Register_Equal : Register_Equal[done(?]
- MUX_IDEX : MUXcontrol    [done]
- Add_Branch : Adder       [done]
- Registers : Registers    [done] 

-------------分配線-------------------


----------------------------------

- Pipe_ID_EX : Pipe_ID_EX	[done(?]

----------------------------------

- MUX_ALU1 : MUX32_3
- MUX_ALU2 : MUX32_3
- MUX_ALUSrc : MUX32         [done]
- ALU : ALU
- ALU_Control : ALU_Control 
- Forwarding_Unit : Forwarding_Unit

----------------------------------

- Pipe_EX_MEM : Pipe_EX_MEM [done]

----------------------------------

- DataMemory : DataMemory   [done]

----------------------------------

- Pipe_MEM_WB : Pipe_MEM_WB[done]

----------------------------------

- MUX_WB : MUX32            [done]
