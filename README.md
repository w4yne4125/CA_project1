各stage 所需的component 以及對應的 class

Component : Class
------------------IF Stage ----------------

MUX_PC : MUX32
PC : PC
Add_PC : Adder
Instruction_Memory : Instruction_Memory

------------------IF / ID ----------------

Pipe_IF_ID : Pipe_IF_ID

------------------ID Stage----------------

Hazard_Detection_Unit : Hazard_Detection_Unit
Control : Control
Immgen : Immgen
Register_Equal : Register_Equal
MUX_IDEX : MUXcontrol
Add_Branch : Adder
Registers : Registers

-------------分配線-------------------


------------------ID / EX ----------------

Pipe_ID_EX : Pipe_ID_EX

------------------EX Stage----------------

MUX_ALU1 : MUX32_3
MUX_ALU2 : MUX32_3
MUX_ALUSrc : MUX32
ALU : ALU
ALU_Control : ALU_Control 
Forwarding_Unit : Forwarding_Unit

------------------EX / MEM----------------

Pipe_EX_MEM : Pipe_EX_MEM

------------------MEM Stage----------------

DataMemory : DataMemory

------------------MEM / WB ----------------

Pipe_MEM_WB : Pipe_MEM_WB

------------------WB Stage----------------

MUX_WB : MUX32 
