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
wire lw;
wire sw;
wire beq;
assign Rformat = ~(instr_op_i[0] | instr_op_i[1] | instr_op_i[2] | instr_op_i[3] | instr_op_i[4] | instr_op_i[5]);
assign lw = instr_op_i[0] & instr_op_i[1] & ~instr_op_i[2] & ~instr_op_i[3] & ~instr_op_i[4] & instr_op_i[5];
assign sw = instr_op_i[0] & instr_op_i[1] & ~instr_op_i[2] & instr_op_i[3] & ~instr_op_i[4] & instr_op_i[5];
assign beq = ~instr_op_i[0] & ~instr_op_i[1] & instr_op_i[2] & ~instr_op_i[3] & ~instr_op_i[4] & ~instr_op_i[5];

//Main function
always@( instr_op_i )
begin
	RegDst_o 	<= Rformat;
	ALUSrc_o 	<= lw | sw;
	RegWrite_o 	<= Rformat | lw;
	Branch_o	<= beq;
	ALU_op_o 	<= {1'b0, Rformat, beq};
end

endmodule





                    
                    
