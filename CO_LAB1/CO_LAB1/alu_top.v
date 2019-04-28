// 0310020
`include "fulladder.v"
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2013
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;

wire          src1_temp;
wire          src2_temp;
wire          sum;

assign src1_temp =  A_invert ^ src1;
assign src2_temp =   B_invert ^ src2;

fulladder fa(.src1(src1_temp),
          .src2(src2_temp),
          .cin(cin),
          .sum(sum),
          .cout(cout)
);

always@(*)
begin
    case (operation)
        2'b00: begin        //1 bit AND   or NOR (~src1 & ~src2)
	        result <= src1_temp & src2_temp;
	    end
	    2'b01: begin        //1 bit OR    or NAND (~src1 | ~src2)
	        result <= src1_temp | src2_temp;
        end
        2'b10: begin        //1 bit Full Adder (add or sub)
            result <= sum;
        end
        2'b11: begin        //1 bit SET LESS THAN  
            result <= less;
        end
    endcase
end

endmodule
