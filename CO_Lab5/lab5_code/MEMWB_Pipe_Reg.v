//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 5 - MEMWB Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module MEMWB_Pipe_Reg(
    clk_i,
    rst_i,
	RegWrite_i,
	MEM2Reg_i,
	MemData_i,
	ALU_result_i,
	writeReg_i,

	RegWrite_o,
	MEM2Reg_o,
	MemData_o,
	ALU_result_o,
	writeReg_o 
    );
					
//parameter size = 0;

input   		clk_i;		  
input   		rst_i;
input			RegWrite_i;
input			MEM2Reg_i;
input	[31:0]	MemData_i;
input	[31:0]	ALU_result_i;
input	[5-1:0]	writeReg_i;

output reg	RegWrite_o;
output reg	MEM2Reg_o;
output reg	[31:0]	MemData_o;
output reg	[31:0]	ALU_result_o;
output reg	[5-1:0]	writeReg_o; 
  
always@(posedge clk_i) begin
  if(~rst_i)begin
	RegWrite_o 	<= 0;
	MEM2Reg_o 	<= 0;
	MemData_o 	<= 0;
	ALU_result_o<= 0;
	writeReg_o 	<= 0;
  end 
  else begin
	RegWrite_o 	<= RegWrite_i;
	MEM2Reg_o 	<= MEM2Reg_i;
	MemData_o 	<= MemData_i;
	ALU_result_o<= ALU_result_i;
	writeReg_o 	<= writeReg_i;
  end
end

endmodule	
