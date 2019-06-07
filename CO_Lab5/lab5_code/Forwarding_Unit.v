//Student ID: 0310020
//Subject: CO Project 5 Forwarfing Unit
//
module Forwarding_Unit(
						EX_MEM_RegWrite,
						MEM_WB_RegWrite,
						EX_MEM_Rd,
						MEM_WB_Rd,
						ID_EX_Rs,
						ID_EX_Rt,
						ForwardA,
						ForwardB
						);
parameter size = 5;
input [size-1:0] EX_MEM_Rd;
input [size-1:0] MEM_WB_Rd;
input [size-1:0] ID_EX_Rs;
input [size-1:0] ID_EX_Rt;
input 			 EX_MEM_RegWrite;
input 			 MEM_WB_RegWrite;
output [1:0]	 ForwardA;
output [1:0]	 ForwardB;

wire EX_Hazard_A = EX_MEM_RegWrite & (EX_MEM_Rd != 0) & (EX_MEM_Rd == ID_EX_Rs);
wire EX_Hazard_B = EX_MEM_RegWrite & (EX_MEM_Rd != 0) & (EX_MEM_Rd == ID_EX_Rt);

wire MEM_WB_A = MEM_WB_RegWrite & (MEM_WB_Rd != 0) & (MEM_WB_Rd == ID_EX_Rs) & ~EX_Hazard_A;

wire MEM_WB_B = MEM_WB_RegWrite & (MEM_WB_Rd != 0) & (MEM_WB_Rd == ID_EX_Rt) & ~EX_Hazard_B;

wire [1:0] ForwardA;
wire [1:0] ForwardB;

assign ForwardA = {EX_Hazard_A, MEM_WB_A};
assign ForwardB = {EX_Hazard_B, MEM_WB_B};

endmodule
