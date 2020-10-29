/*______________________________
         Top Level
  ______________________________*/
  
  module top_level (
		
		input  Clk,
		input  Reset,
		output [31:0] ReadData_DataMem,
		output [31:0] Address_DataMem,
		output [31:0] WriteData_DataMem,
		output MemWrite, 
		output MemRead,
		
		output RegDst,
			    Jump,
				 JAL,
			    Branch,
			    MemToReg,
			    ALUSrc,
			    RegWrite,
				 JR,
		output [1:0] ALUOp,
		
		output wire [31:0] PC
		
		);

		// Data Memory Wires
		/*
		wire [31:0]  ReadData_DataMem;
		wire [31:0]  Address_DataMem;
		wire [31:0]  WriteData_DataMem;
		wire 			 MemWrite, MemRead;
		*/
		
		//processor core
		MIPS_32bit mips_core (Clk, Reset, ReadData_DataMem, Address_DataMem, WriteData_DataMem, MemWrite, MemRead,
									 RegDst, Jump, JAL, Branch, MemToReg, ALUSrc, RegWrite, JR, ALUOp, PC);
	
		// data-memory
		data_memory DM (ReadData_DataMem, Address_DataMem, WriteData_DataMem, MemWrite, MemRead, Clk);
		
	endmodule 