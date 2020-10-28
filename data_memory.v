/*_____________________________________
         32-bit Data Memory
  _____________________________________*/

  `timescale 1ns / 1ps
  
  module data_memory (
	
		output reg [31:0] read_data,		// data output
		input      [31:0] address,			// address where data is to be stored
		input      [31:0] write_data,		// data to be writtend
		input             MemWrite,		// write signal
		input             MemRead,			// read signal
		input	            Clk 				// Clock signal for sync RAM
		
		);
		
		// the memory is restricted to 256 x 32 bits for simplicity
		reg [31:0] memory [255:0];
		
		always @(posedge Clk) begin 
			
			#1;
			if (MemWrite == 1) begin
					
				#1 memory[address] = write_data;
			end
			
			else if (MemRead == 1) begin
				
				read_data <= memory[address];
				
			end
			
			$writememb ("data_mem_out.mem", memory);
		end
		
			
endmodule
		