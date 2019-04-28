// 0310020
`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2013
// Design Name: 
// Module Name:    fulladder
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

module fulladder(src1,
                 src2, 
                 cin,
                 sum,
                 cout
                );

input src1;
input src2;
input cin;
output sum;
output cout;

assign cout = (src1 & src2) | (src1 & cin) | (src2 & cin);
assign sum = src1 ^ src2 ^ cin;

endmodule;