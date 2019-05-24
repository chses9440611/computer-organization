//Student ID: 0310020
`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
parameter NUM_PIP_IFID = 64;
wire [31:0] pc_out;
wire [31:0] pc_in;
wire [31:0] constant_4;
wire [31:0] instruction_IF;			// 			input			32
wire [31:0] pc_next_IF;				// 			input			32
assign constant_4 = 32'd4;
/**** ID stage ****/
parameter NUM_PIP_IDEX = 148;
wire [31:0] pc_next_ID;				// output, 	input			32
wire [31:0] instruction_ID;			// output, 	input[20:11]	10
wire [31:0] data1_ID;				// 			input			32
wire [31:0] data2_ID;				// 			input			32
wire [31:0] Sign_Extend_addr_ID;	// 			input			32
//control signal
// EX
wire 		 ALU_source_ID;					//			input			1
wire [3-1:0] ALU_op_ID;						// 			input			3
wire 		 RegDst_ID;						//			input			1
// MEM
wire 		 branch_ID;						//			input			1
wire 		 MEM_Read_ID;					//			input			1
wire 		 MEM_Write_ID;					//			input			1
// WB
wire 		 RegWrite_ID;					//			input			1
wire 		 MEM2Reg_ID;					//			input			1


/**** EX stage ****/
parameter NUM_PIP_EX_MEM = 107;
wire [31:0] pc_next_EX; 			// output					32
wire [31:0] data1_EX;   			// output					32
wire [31:0] data2_EX;				// output, 	input			32
wire [31:0] Sign_Extend_addr_EX;	// output					32
wire [5-1 :0] writeReg_src1_EX;		// output					5
wire [5-1 :0] writeReg_src2_EX;		// output					5
wire [5-1 :0] writeReg_addr_EX;		// 			input			5
wire [31:0] shifted_addr;										
wire [31:0] branch_addr_EX;			// 			input			32
wire [31:0] ALU_src2;				
wire [31:0] ALU_result_EX;			// 			input			32
//control signal
wire Zero_EX;						//			input			1
wire ALU_source_EX;					// output					1
wire [2 :0]	ALU_op_EX;				// output					3
wire RegDst_EX;						// output					1
// MEM
wire branch_EX;						// output	input			1
wire MEM_Read_EX;					// output	input			1
wire MEM_Write_EX;					// output	input			1
// WB
wire RegWrite_EX;					// output	input			1
wire MEM2Reg_EX;					// output	input			1
wire [4-1:0] ALU_control;

/**** MEM stage ****/
parameter NUM_PIP_MEM_WB = 71;
wire [31:0] branch_addr_MEM;		// output					32
wire [31:0] ALU_result_MEM;			// output, 	input			32
wire [31:0] data2_MEM;				// output					32
wire [5-1 :0] writeReg_addr_MEM;	// output, 	input			5
wire [31:0] MemData_MEM;			// 			input			32
//control signal
wire Zero_MEM;						// output					1
wire branch_MEM;					// output					1
wire MEM_Read_MEM;					// output					1
wire MEM_Write_MEM;					// output					1
// WB
wire RegWrite_MEM;					// output	input			1
wire MEM2Reg_MEM;					// output	input			1
wire Branch;
assign Branch = Zero_MEM && branch_MEM;
/**** WB stage ****/
wire [31:0] MemData_WB;				// output					32
wire [31:0] ALU_result_WB;			// output					32
wire [5-1 :0] writeReg_addr_WB;		// output					5
wire [31:0] WriteBackData;
//control signal
wire RegWrite_WB;					// output					1
wire MEM2Reg_WB;					// output					1

/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0( // MUX to choose pc_in source
	.data0_i(pc_next_IF),
	.data1_i(branch_addr_MEM),
	.select_i(Branch),
	.data_o(pc_in)
);

ProgramCounter PC(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.pc_in_i(pc_in),
	.pc_out_o(pc_out)
);

Instruction_Memory IM(
  .addr_i(pc_out),
  .instr_o(instruction_IF)
);
			
Adder Add_pc(
	.src1_i(pc_out),
	.src2_i(constant_4),
	.sum_o(pc_next_IF)
);

		
Pipe_Reg #(.size(NUM_PIP_IFID)) IF_ID(       //N is the total length of input/output
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({pc_next_IF, instruction_IF}),
	.data_o({pc_next_ID, instruction_ID})
);


//Instantiate the components in ID stage
Reg_File RF(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.RSaddr_i(instruction_ID[25:21]),
	.RTaddr_i(instruction_ID[20:16]),
	.RDaddr_i(writeReg_addr_WB),
	.RDdata_i(WriteBackData),
	.RegWrite_i(RegWrite_WB),
	.RSdata_o(data1_ID),
	.RTdata_o(data2_ID)
);

Decoder Control(
	.instr_op_i(instruction_ID[31:26]),
	.ALUSrc_o(ALU_source_ID),
	.ALU_op_o(ALU_op_ID),
	.RegDst_o(RegDst_ID),
	.Branch_o(branch_ID),
	.MEM_Read(MEM_Read_ID),
	.MEM_Write(MEM_Write_ID),
	.RegWrite_o(RegWrite_ID),
	.MEM2Reg(MEM2Reg_ID)
);

Sign_Extend Sign_Extend(
	.data_i(instruction_ID[15:0]),
	.data_o(Sign_Extend_addr_ID)
);	

Pipe_Reg #(.size(NUM_PIP_IDEX)) ID_EX(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({ALU_source_ID, ALU_op_ID, RegDst_ID, branch_ID, MEM_Read_ID, MEM_Write_ID, RegWrite_ID, MEM2Reg_ID, pc_next_ID, data1_ID, data2_ID, Sign_Extend_addr_ID, instruction_ID[20:11]}),
	.data_o({ALU_source_EX, ALU_op_EX, RegDst_EX, branch_EX, MEM_Read_EX, MEM_Write_EX, RegWrite_EX, MEM2Reg_EX, pc_next_EX, data1_EX, data2_EX, Sign_Extend_addr_EX, writeReg_src1_EX, writeReg_src2_EX})
);


//Instantiate the components in EX stage	
Shift_Left_Two_32 Shifter(
	.data_i(Sign_Extend_addr_EX),
	.data_o(shifted_addr)
);

ALU ALU(
  .src1_i(data1_EX),
  .src2_i(ALU_src2),
  .ctrl_i(ALU_control),
  .result_o(ALU_result_EX),
  .zero_o(Zero_EX)
);
		
ALU_Ctrl ALU_Control(
	.funct_i(Sign_Extend_addr_EX[6-1:0]),
  	.ALUOp_i(ALU_op_EX),
  	.ALUCtrl_o(ALU_control)
);

MUX_2to1 #(.size(32)) Mux1(// choose the ALU src2
	.data0_i(data2_EX),
	.data1_i(Sign_Extend_addr_EX),
	.select_i(ALU_source_EX),
	.data_o(ALU_src2)
);
		
MUX_2to1 #(.size(5)) Mux2(// choose the WB reg
	.data0_i(writeReg_src1_EX),
	.data1_i(writeReg_src2_EX),
	.select_i(RegDst_EX),
	.data_o(writeReg_addr_EX)
);

Adder Add_pc_branch(
	.src1_i(pc_next_EX),
	.src2_i(shifted_addr),
	.sum_o(branch_addr_EX)
);

Pipe_Reg #(.size(NUM_PIP_EX_MEM)) EX_MEM(
  	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({branch_EX, MEM_Read_EX, MEM_Write_EX, RegWrite_EX, MEM2Reg_EX,
			 Zero_EX, branch_addr_EX, ALU_result_EX, data2_EX, writeReg_addr_EX}),
	.data_o({branch_MEM, MEM_Read_MEM, MEM_Write_EX, RegWrite_MEM, MEM2Reg_MEM,
			 Zero_MEM, branch_addr_MEM, ALU_result_MEM, data2_MEM, writeReg_addr_MEM})
);


//Instantiate the components in MEM stage
Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(ALU_result_MEM),
	.data_i(data2_MEM),
	.MemRead_i(MEM_Read_MEM),
	.MemWrite_i(MEM_Write_MEM),
  	.data_o(MemData_MEM)
);

Pipe_Reg #(.size(NUM_PIP_MEM_WB)) MEM_WB(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.data_i({RegWrite_MEM, MEM2Reg_MEM,
			 MemData_MEM, ALU_result_MEM, writeReg_addr_MEM}),
	.data_o({RegWrite_WB, MEM2Reg_WB,
	  		 MemData_WB, ALU_result_WB, writeReg_addr_WB})
);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
	.data0_i(ALU_result_WB), 
	.data1_i(MemData_WB),
	.select_i(MEM2Reg_WB),
	.data_o(WriteBackData)
);

/****************************************
signal assignment
****************************************/

endmodule

