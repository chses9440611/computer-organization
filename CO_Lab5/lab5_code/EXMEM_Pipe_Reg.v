//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 5 - EX/MEM Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module EXMEM_Pipe_Reg(
    clk_i,
    rst_i,
	branch_i,
	MEM_Read_i,
	MEM_Write_i,
	RegWrite_i,
	MEM2Reg_i,
	Zero_i,
	branch_addr_i,
	ALU_result_i,
	write2Mem_Data_i,
	writeReg_i,
	branch_o,
	MEM_Read_o,
	MEM_Write_o,
	RegWrite_o,
	MEM2Reg_o,
	Zero_o,
	branch_addr_o,
	ALU_result_o,
	write2Mem_Data_o,
	writeReg_o
    );
					
//parameter size = 0;
input			branch_i;
input			MEM_Read_i;
input			MEM_Write_i;
input			RegWrite_i;
input			MEM2Reg_i;
input			Zero_i;
input	[31:0]	branch_addr_i;
input	[31:0]	ALU_result_i;
input	[31:0]	write2Mem_Data_i;
input	[5-1:0]	writeReg_i;

output reg			branch_o;
output reg			MEM_Read_o;
output reg			MEM_Write_o;
output reg			RegWrite_o;
output reg			MEM2Reg_o;
output reg			Zero_o;
output reg	[31:0]	branch_addr_o;
output reg	[31:0]	ALU_result_o;
output reg	[31:0]	write2Mem_Data_o;
output reg	[5-1:0]	writeReg_o;


input   clk_i;		  
input   rst_i;
	  
always@(posedge clk_i) begin
    if(~rst_i)begin
		branch_o 	<= 0;
		MEM_Read_o 	<= 0;
		MEM_Write_o <= 0;
		RegWrite_o 	<= 0;
		MEM2Reg_o 	<= 0;
		Zero_o 		<= 0;
		branch_addr_o 	<= 0;
		ALU_result_o 	<= 0;
		write2Mem_Data_o<= 0;
		writeReg_o 	<= 0;
	end 
	else begin
	  	branch_o 	<= branch_i;
		MEM_Read_o 	<= MEM_Read_i;
		MEM_Write_o <= MEM_Write_i;
		RegWrite_o 	<= RegWrite_i;
		MEM2Reg_o 	<= MEM2Reg_i;
		Zero_o 		<= Zero_i;
		branch_addr_o 	<= branch_addr_i;
		ALU_result_o 	<= ALU_result_i;
		write2Mem_Data_o<= write2Mem_Data_i;
		writeReg_o 	<= writeReg_i;

	end 
end

endmodule	
