/*_____________________________________
         32-bit Instruction Memory
  _____________________________________*/

`timescale 1ns / 1ps

module Instruction_memory (

	
	output reg [31:0] read_data,		//The data stored in the given address
	input 	  [31:0] address,			//Address to read from
	input					Clk				// Clock signal for sync RAM
	
	);
	
	// 256 32-bit registers for storing the instructions
	// the memory is restricted to only 256 for simplicity
	// maximum size = 2^32 instructions
	reg [31:0] instructions [255:0];
	
	initial begin 
		// load the instructions from the file instructions.mem
		$readmemb("instructions.mem", instructions);
	end
	
	
	//load the new instruction whenever the address changes
	always @(posedge Clk) begin
	
		read_data = instructions[address];
		$display($time, ", instruciton = %b", read_data);
		
	end
	
endmodule

		