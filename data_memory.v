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
		input	            Clock, 			// Clock signal for sync RAM
		
		// Value stored in memory[5] -> for displaying in the ssd	
		output reg [31:0] mem_5			
		
		);
		
		// the memory is restricted to 256 x 32 bits for simplicity
		reg [31:0] memory [31:0];
/*		
		initial begin 
			$readmemb ("data_mem_init.mem", memory);
		end
*/		
		always @(posedge Clock) begin 
			
			#1;
			if (MemWrite == 1) begin
					
				#1 memory[address] = write_data;
			end
			
			else if (MemRead == 1) begin
				
				read_data <= memory[address];
				
			end
			
			$writememb ("data_mem_out.mem", memory);
			
			mem_5 <= memory[5];
		end
			
 endmodule
		