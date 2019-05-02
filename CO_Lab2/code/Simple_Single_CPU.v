// 0310020
//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] constant_4 ;
assign constant_4 = 32'd4;

wire [31:0] pc_in;
wire [31:0] pc_out;
wire [31:0] instruction;
wire [31:0] seq_addr;
wire [31:0] branch_addr;
wire [31:0] MuxWriteReg_o;
wire [31:0] RData_1;
wire [31:0] RData_2;
wire [31:0] ALU_src2;
wire [31:0] ALU_result;
wire [31:0] extended_result;
wire [31:0] shifted_result;

// contril signal
wire [4-1:0] ALU_ctrl;
wire [2-1:0] ALU_op;
wire ALU_source;
wire branch;
wire regwrite;
wire regdst;

wire zero;
wire pc_source = branch & zero;
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(pc_out),     
	    .src2_i(constant_4),     
	    .sum_o(seq_addr)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(regdst),
        .data_o(MuxWriteReg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(MuxWrite_o) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (regwrite),
        .RSdata_o(RData_1) ,  
        .RTdata_o(RData_2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALU_source),   
	    .RegDst_o(regdst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALU_ctrl) 
        );
	
Sign_Extend SE(
        .data_i(instruction[16-1:0]),
        .data_o(extended_result)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RData_2),
        .data1_i(extended_result),
        .select_i(ALU_source),
        .data_o(ALU_src2)
        );	
		
ALU ALU(
        .src1_i(RData_1),
	    .src2_i(ALU_src2),
	    .ctrl_i(ALU_ctrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(seq_addr),     
	    .src2_i(shifted_result),     
	    .sum_o(branch_addr)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extended_result),
        .data_o(shifted_result)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(seq_addr),
        .data1_i(branch_addr),
        .select_i(pc_source),
        .data_o(pc_in)
        );	

endmodule
		  


