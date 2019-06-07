//Student ID: 0310020
//Subject CO project 5 - HazarDetection
//

module HazardDetect_Unit(
						ID_EX_MEM_Read,
						ID_EX_Reg_Rt,
						IF_ID_Reg_Rs,
						IF_ID_Reg_Rt,
						PC_Write,
						IF_ID_Write,
						Zero_Control
						);
input ID_EX_MEM_Read;
input [5-1:0]	ID_EX_Reg_Rt;
input [5-1:0]	IF_ID_Reg_Rs;
input [5-1:0]	IF_ID_Reg_Rt;
output 			PC_Write;
output 			IF_ID_Write;
output 			Zero_Control;

wire HazardDetect = ID_EX_MEM_Read & ((ID_EX_Reg_Rt == IF_ID_Reg_Rs) || ID_EX_Reg_Rt == IF_ID_Reg_Rt);

wire PC_Write;
wire IF_ID_Write;
wire Zero_Control;

assign PC_Write = ~HazardDetect;
assign IF_ID_Write = ~HazardDetect;
assign Zero_Control = HazardDetect;

endmodule

