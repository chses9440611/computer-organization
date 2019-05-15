//Student ID: 0310020
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

wire [31:0] constant_4;
wire [5-1:0] reg31;
assign constant_4 = 32'd4;
assign reg31 = 5'b11111;
assign ground = 6'b000000;

wire [31:0] pc_in;
wire [31:0] pc_out;
wire [31:0] instruction;


//Decoder Line
wire branch;
wire regWrite;
wire jumpType;
wire mem_Write;
wire mem_Read;
wire ALU_source;
wire [2-1:0] regDst;
wire [2-1:0] mem2Reg;
wire [3-1:0] ALU_op;

//ALU Ctrl Line
wire [4-1:0] ALU_ctrl;
wire jr;

wire zero;
wire Branch;
assign Branch = zero & branch;

//Internal Signles
wire [31:0] next_pc;// pc+4
wire [31:0] branch_addr;
wire [31:0] jump_addr; 
wire [31:0] from_branch_addr;
wire [31:0] signExtend_addr;
wire [31:0] shift_addr;
wire [5-1:0] writeReg;
wire [31:0] rsData;
wire [31:0] rtData;
wire [31:0] wbData; // write back to register
wire [31:0] ALU_src2;
wire [31:0] ALU_result;
wire [31:0] memData;
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
	    .sum_o(next_pc)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instruction)    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
		.data2_i(reg31),
        .select_i(regDst),
        .data_o(writeReg)
        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(writeReg) ,  
        .RDdata_i(wbData)  , 
        .RegWrite_i (regWrite),
        .RSdata_o(rsData) ,  
        .RTdata_o(rtData)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(regWrite), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALU_source),   
	    .RegDst_o(regDst),   
		.Branch_o(branch),
		.JumpType(jumpType),
		.MEM_Write(mem_Write),
		.MEM_Read(mem_Read),
		.MEM2Reg(mem2Reg)
	    );

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALU_ctrl),
		.Jr_o(jr)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(signExtend_addr)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rtData),
        .data1_i(signExtend_addr),
        .select_i(ALU_source),
        .data_o(ALU_src2)
        );	
		
ALU ALU(
        .src1_i(rsData),
	    .src2_i(ALU_src2),
	    .ctrl_i(ALU_ctrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_result),
	.data_i(rtData),
	.MemRead_i(mem_Read),
	.MemWrite_i(mem_Write),
	.data_o(memData)
	);

MUX_3to1 #(.size(32)) Mux_Write_Data_Src(
	.data0_i(ALU_result),
	.data1_i(memData),
	.data2_i(next_pc),
	.select_i(mem2Reg),
	.data_o(wbData)
);

Adder Adder2(
        .src1_i(next_pc),     
	    .src2_i(shift_addr),     
	    .sum_o(branch_addr)      
	    );
		
Shift_Left_Two_32 Shifter_Address(
        .data_i(signExtend_addr),
        .data_o(shift_addr)
        ); 		
		
Shift_Left_Two_32 Shifter_jump(
        .data_i({6'b000000, instruction[25:0]}),
        .data_o(jump_addr)
        ); 

MUX_2to1 #(.size(32)) Branch_Src(
        .data0_i(next_pc),
        .data1_i(branch_addr),
        .select_i(Branch),
        .data_o(from_branch_addr)
        );	

MUX_3to1 #(.size(32)) Mux_PC_Source(
        .data0_i(from_branch_addr),
        .data1_i(jump_addr),
        .data2_i(ALU_result),
        .select_i({Jr, jumpType}),
        .data_o(pc_in)
        );	

endmodule
		  


