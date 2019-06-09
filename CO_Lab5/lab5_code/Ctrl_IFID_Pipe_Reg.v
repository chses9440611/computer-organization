//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 5 - Control IF/ID Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Ctrl_IFID_Pipe_Reg(
    clk_i,
    rst_i,
	write_signal,
    instruction_i,
	pc_next_i,
    instruction_o,
	pc_next_o
    );
					
parameter size = 32;

input   clk_i;		  
input   rst_i;
input 	write_signal;
input   [size-1:0] instruction_i;
input   [size-1:0] pc_next_i;

output reg [size-1:0] instruction_o;
output reg [size-1:0] pc_next_o;
	  
always@(posedge clk_i) begin
    if(~rst_i)
        {instruction_o, pc_next_o} <= 0;
    else if(write_signal)
        {instruction_o, pc_next_o} <= {instruction_i, pc_next_i};
	else
	  	{instruction_o, pc_next_o} <= {instruction_o, pc_next_o};
end

endmodule	

