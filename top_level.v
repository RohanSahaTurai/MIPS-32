/*______________________________
         Top Level
  ______________________________*/
  
  module top_level (
		
		input  Clock,
		input  Reset,
		output [31:0] memory_5,
		output [31:0] PC
		
		);

		// Data Memory Wires
		wire [31:0]  ReadData_DataMem;
		wire [31:0]  Address_DataMem;
		wire [31:0]  WriteData_DataMem;
		wire 			 MemWrite, MemRead;
		
		//processor core
		MIPS_32bit mips_core (Clock, Reset, ReadData_DataMem, Address_DataMem, WriteData_DataMem, MemWrite, MemRead, PC);
	
		// data-memory
		data_memory DM (ReadData_DataMem, Address_DataMem, WriteData_DataMem, MemWrite, MemRead, Clock, memory_5);
		
		
		
	endmodule 