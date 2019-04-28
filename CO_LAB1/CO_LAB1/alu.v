// 0310020
`include "alu_top.v"
`include "alu_last.v"
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

//reg   [32-1:0] src1_temp;
//reg   [32-1:0] src2_temp;

wire  [32-1:0] cout_temp;
wire  [32-1:0] result_temp;
wire  overflow_temp;
wire  set;
wire  zero_temp;
nor(zero_temp, result_temp[0], result_temp[1], result_temp[2], result_temp[3], result_temp[4], result_temp[5],  result_temp[6], result_temp[7],
              result_temp[8], result_temp[9], result_temp[10], result_temp[11], result_temp[12], result_temp[13], result_temp[14], result_temp[15],
              result_temp[16], result_temp[17], result_temp[18], result_temp[19], result_temp[20], result_temp[21], result_temp[22], result_temp[23],
              result_temp[24], result_temp[25], result_temp[26], result_temp[27], result_temp[28], result_temp[29], result_temp[30], result_temp[31]  
);

alu_top first_alu(.src1( src1[0] ),
                  .src2( src2[0] ),
                  .less(set),
                  .A_invert( ALU_control[3] ),
                  .B_invert( ALU_control[2]),
                  .cin(ALU_control[2]),
                  .operation( ALU_control[1:0] ),
                  .result( result_temp[0] ),
                  .cout( cout_temp[0] )
);

alu_top other_alu[30-1:0](.src1( src1[31-1:1] ),
                          .src2( src2[31-1:1] ),
                          .less(30'b0),
                          .A_invert( ALU_control[3] ),
                          .B_invert( ALU_control[2]),
                          .cin( cout_temp[30-1:0] ),
                          .operation( ALU_control[1:0] ),
                          .result( result_temp[31-1:1] ),
                          .cout( cout_temp[31-1:1] )
);

alu_last last_alu(.src1( src1[32-1] ),
                  .src2( src2[32-1] ),
                  .less(1'b0),
                  .A_invert( ALU_control[3] ),
                  .B_invert( ALU_control[2]),
                  .cin( cout_temp[31-1]),
                  .operation( ALU_control[1:0] ),
                  .result( result_temp[32-1] ),
                  .cout( cout_temp[32-1] ),
                  .set (set),
                  .overflow(overflow_temp)
);

always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n) begin
        //src1_temp = 32'b0;
        //src2_temp = 32'b0;
        result <= 32'b0;
        overflow <= 1'b0;
	end
	else begin
        //src1_temp = src1;
        //src2_temp = src2;
	if(ALU_control[1:0]==2'b10)begin
        	cout <= cout_temp[32-1];
	end
	else begin
		cout <= 0;
	end
        zero <= zero_temp;
        result <= result_temp;
        overflow<= overflow_temp;
	end
end

endmodule
