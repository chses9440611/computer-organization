//0310020
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter
wire Rformat;
wire Immediate;
wire Slti;
wire Beq;
assign Rformat = ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & ~instr_op_i[1] & ~instr_op_i[0];
assign Beq = ~instr_op_i[5] & ~instr_op_i[4] & ~instr_op_i[3] & ~instr_op_i[2] & ~instr_op_i[1] & ~instr_op_i[0];
assign Immediate = ~instr_op_i[5] & ~instr_op_i[4] & instr_op_i[3];
//Main function
assign Slti = ~instr_op_i[5] & ~instr_op_i[4] & instr_op_i[3] & ~instr_op_i[2] & instr_op_i[1] & ~instr_op_i[0];
always@( instr_op_i )
begin
	RegDst_o 	<= Rformat;
	ALUSrc_o 	<= Immediate;
	RegWrite_o 	<= Slti | Rformat;
	Branch_o	<= Beq;
	ALU_op_o[2] <= Immediate | Beq;
	ALU_op_o[1] <= Slti | Rformat;
	ALU_op_o[0] <= Slti | Beq;
end

endmodule





                    
                    
