/*______________________________
         MIPS 32-bit Core
  ______________________________*/
  
  `timescale 1ns / 1ps
  
  module MIPS_32bit (
		
		input 		   clk, 
		input 		   Reset,
		input  [31:0]  ReadData_DataMem,
		output [31:0]  Address_DataMem,
		output [31:0]  WriteData_DataMem,
		output			MemWrite,
		output			MemRead,
		
		output RegDst,
			    Jump,
				 JAL,
			    Branch,
			    MemToReg,
			    ALUSrc,
			    RegWrite,
				 JR,
		output [1:0] ALUOp,
		
		output reg [31:0] PC
		
		);
  
		// data bus carrying the current instruction
		wire [31:0] instruction;
		
		// Register file wires
		wire [4:0]  WriteRegister_in;
		wire [4:0]  RegDst_WriteRegister_in;
		wire [31:0] WriteData_in;
		wire [31:0] MemToReg_WriteData_in;
		
		// Control Wires
		// MemRead and MemWrite is output to the Data Memory
		/*
		wire RegDst,
			  Jump,
			  JAL,
			  Branch,
			  MemToReg,
			  ALUSrc,
			  RegWrite,
			  JR;
		wire [1:0] ALUOp;
		*/
		// ALU Control Wires
		wire [3:0] ALUCtl;
		
		// ALU Wires
		wire [31:0] ALUResult;
		wire CarryOut, Overflow, Zero;
		
		// Register file outputs
		wire [31:0] ReadData1; 
		wire [31:0] ReadData2;
		
		// ALU related wires
		wire [31:0] sign_extended;
		wire [31:0] ALU_in2;
		
		//Program Counter
		//reg [31:0] PC; 		// Program counter
		
		wire [31:0] PC_add_1;  // Current PC + 1
		wire [31:0] PC_BEQ;	  // PC for BEQ instruction
		wire [31:0] PC_J;	  // PC for J instruction
		wire [31:0] PC_next;	  // Next PC value
		
		always @(posedge clk or posedge Reset) begin
					
			if (Reset)
				PC <= 32'b0;
			
			else
				#1 PC <= PC_next;
			
			$strobe($time, ", PC = %0d, PC_next = %0d", PC, PC_add_1);
			
		end
		
		assign PC_add_1 = PC + 1;
		
		// Instruction memory instantiation
		Instruction_memory IM(instruction, PC, clk);
		
		// Control Unit
		Control_Unit CU(instruction[31:26], Reset, RegDst, Jump, JAL, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
		
		// 2x1 MUX to select if data[rs2] is to be stored
		assign RegDstWriteRegister_in = RegDst ? (instruction[15:11]) : (instruction[20:16]) ;
		
		// 2x1 MUX to select if PC_Add_1 is to be stored in GPR31
		assign WriteRegister_in = JAL ? 5'd31 : RegDstWriteRegister_in;
		
		// Register File instantiation
		register_file RF (ReadData1, ReadData2, instruction[25:21], instruction[20:16], WriteRegister_in, WriteData_in, RegWrite, clk);
		
		// Sign extension module for I-type instructions
		assign sign_extended = {{16{instruction[15]}},instruction[15:0]};
	
		// 2x1 multiplexer to select the 2nd input data to the ALU
		// source = register file for R-type and source = sign_extended for I-type
		assign ALU_in2 = ALUSrc ? sign_extended : ReadData2;
		
		// ALU Control Unit
		ALU_Control ALU_CU (ALUCtl, JR, ALUOp, instruction[5:0]);
		
		// ALU
		ALU_32bit ALU (ALUResult, CarryOut, Overflow, Zero, 
							ReadData1, ALU_in2, ALUCtl[3], ALUCtl[2], ALUCtl[1:0]);

		
		// 2x1 MUX to select if the ALU result or the load word is to be stored in GPR
		assign MemToReg_WriteData_in = MemToReg ? ReadData_DataMem : ALUResult;
		
		// 2x1 MUX to select if PC_add_1 is to be stored in GPR31
		assign WriteData_in = JAL ? PC_add_1 : MemToReg_WriteData_in;
		
		// BEQ control -> if the BRANCH control wire and Zero signal are high, execute BEQ
		assign PC_BEQ = (Branch & Zero) ? (PC_add_1 + sign_extended) : PC_add_1;
		
		// Jump instruction control. 
		// Lower 26 bits come from the instruction. 
		// Rest of the bits are concatenated from the PC
		assign PC_J = Jump ? ({PC_add_1[31:26],instruction[25:0]}) : PC_BEQ;
		
		// JR instruction control MUX
		assign PC_next = JR ? ReadData1 : PC_J;
		
		// Wires out to the Data Memory
		assign Address_DataMem 	 = ALUResult;
		assign WriteData_DataMem = ReadData2;
			
		
		
  endmodule
  