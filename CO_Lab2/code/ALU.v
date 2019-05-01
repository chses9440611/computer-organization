// 0310020
//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter

//Main function
assign zero_o = (result_o == 0);

always@(ctrl_i, src1_i, src2_i) begin
  case (ctrl_i)
	0: result_o <= A & B;
	1: result_o <= A | B;
	2: result_o <= A + B;
	6: result_o <= A - B;
	7: result_o <= A < B ? 1 : 0;
	12: result_o <= ~(A | B);
  default: result_o <= 0;
endmodule





                    
                    
