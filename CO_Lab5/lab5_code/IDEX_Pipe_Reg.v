//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 5 - ID/EX Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module IDEX_Pipe_Reg(
    clk_i,
    rst_i,
    ALU_source_i,
	ALU_op_i,
	RegDst_i,
	branch_i,
	MEM_Read_i,
	MEM_Write_i,
	RegWrite_i,
	MEM2Reg_i,
	pc_next_i,
	data1_i,
	data2_i,
	Sign_Extend_addr_i,
	Reg_rs_i,
	Reg_rt_i,
	Reg_rd_i,
    ALU_source_o,
	ALU_op_o,
	RegDst_o,
	branch_o,
	MEM_Read_o,
	MEM_Write_o,
	RegWrite_o,
	MEM2Reg_o,
	pc_next_o,
	data1_o,
	data2_o,
	Sign_Extend_addr_o,
	Reg_rs_o,
	Reg_rt_o,
	Reg_rd_o
  );
					
//parameter size = 0;

input   		clk_i;		  
input   		rst_i;
// EX
input			ALU_source_i;
input	[3-1:0] ALU_op_i;
input			RegDst_i;
// MEM
input			branch_i;
input			MEM_Read_i;
input			MEM_Write_i;
// WB
input			RegWrite_i;
input			MEM2Reg_i;
// data port
input	[31:0]	pc_next_i;
input	[31:0]	data1_i;
input	[31:0]	data2_i;
input	[31:0]	Sign_Extend_addr_i;
input	[5-1:0]	Reg_rs_i;
input	[5-1:0]	Reg_rt_i;
input	[5-1:0]	Reg_rd_i;
//OUTPUT
output reg			ALU_source_o;
output reg	[3-1:0] ALU_op_o;
output reg			RegDst_o;
// MEM
output reg			branch_o;
output reg			MEM_Read_o;
output reg			MEM_Write_o;
// WB
output reg			RegWrite_o;
output reg			MEM2Reg_o;
// data port
output reg	[31:0]	pc_next_o;
output reg	[31:0]	data1_o;
output reg	[31:0]	data2_o;
output reg	[31:0]	Sign_Extend_addr_o;
output reg	[5-1:0]	Reg_rs_o;
output reg	[5-1:0]	Reg_rt_o;
output reg	[5-1:0]	Reg_rd_o;

	  
always@(posedge clk_i) begin
    if(~rst_i)begin	
	  	ALU_source_o <= 0;
		ALU_op_o 	 <= 0;
		RegDst_o 	 <= 0;
		// MEM
		branch_o 	 <= 0;
		MEM_Read_o 	 <= 0;
		MEM_Write_o  <= 0;
		// WB
		RegWrite_o 	 <= 0;
		MEM2Reg_o	 <= 0;
		//data
		pc_next_o 	 <= 0;
		data1_o 	 <= 0;
		data2_o 	 <= 0;
		Sign_Extend_addr_o <= 0;
		Reg_rs_o 	 <= 0;
		Reg_rt_o 	 <= 0;
		Reg_rd_o 	 <= 0;
	end 
	else begin
		// EX
	  	ALU_source_o <= ALU_source_i;
		ALU_op_o 	<= ALU_op_i;
		RegDst_o 	<= RegDst_i;
		// MEM
		branch_o 	<= branch_i;
		MEM_Read_o 	<= MEM_Read_i;
		MEM_Write_o <= MEM_Write_o;
		// WB
		RegWrite_o 	<= RegWrite_i;
		MEM2Reg_o	<= MEM2Reg_i;
		//data
		pc_next_o 	<= pc_next_i;
		data1_o 	<= data1_i;
		data2_o 	<= data2_i;
		Sign_Extend_addr_o <= Sign_Extend_addr_i;
		Reg_rs_o 	<= Reg_rs_i;
		Reg_rt_o 	<= Reg_rt_i;
		Reg_rd_o 	<= Reg_rd_i;
	end

end

endmodule	
