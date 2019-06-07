//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 5 - Control Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Ctrl_Pipe_Reg(
    clk_i,
    rst_i,
	write_signal,
    data_i,
    data_o
    );
					
parameter size = 0;

input   clk_i;		  
input   rst_i;
input   [size-1:0] data_i;
output reg  [size-1:0] data_o;
	  
always@(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
    else if(write_signal)
        data_o <= data_i;
	else
	  	data_o <= 0;
end

endmodule	
