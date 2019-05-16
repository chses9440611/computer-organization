//Student ID: 0310020
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	JumpType,
	MEM_Write,
	MEM_Read,
	MEM2Reg,
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
output         JumpType;
output		   MEM_Write;
output 		   MEM_Read;
output [2-1:0] MEM2Reg;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg    [2-1:0] RegDst_o;
reg            Branch_o;
reg            JumpType;
reg			   MEM_Write;
reg			   MEM_Read;
reg    [2-1:0] MEM2Reg;

//Parameter
wire Rformat;
wire Immediate;
wire Slti;
wire Beq;

wire Load;
wire Store;
wire Jump;
wire Jal;

assign Rformat = ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & ~instr_op_i[1] & ~instr_op_i[0];

assign Beq = ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & instr_op_i[2] & ~instr_op_i[1] & ~instr_op_i[0];

assign Immediate = ~instr_op_i[5] & ~instr_op_i[4] & instr_op_i[3];

assign Slti = ~instr_op_i[5] & ~instr_op_i[4] & instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & ~instr_op_i[0];

assign Load = instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & instr_op_i[0];

assign Store = instr_op_i[5] & ~instr_op_i[4] & instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & instr_op_i[0];

assign Jump =  ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & ~instr_op_i[0];

assign Jal =  ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & instr_op_i[0];




//Main function
always@( instr_op_i)begin
  RegDst_o <= {Jal, Rformat};
  ALUSrc_o <= Immediate | Load | Store;
  RegWrite_o <= Immediate | Rformat | Load | Jal;
  Branch_o <= Beq;
  MEM_Write <= Store;
  MEM_Read <= Load;
  MEM2Reg <= {Jal, Load};
  JumpType <= Jump | Jal;
  ALU_op_o[2] <= Immediate | Beq | Load | Store;
  ALU_op_o[1] <= Slti | Rformat;
  ALU_op_o[0] <= Slti | Beq;
end 
endmodule





                    
                    
