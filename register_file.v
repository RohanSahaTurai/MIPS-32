/*_____________________________________
         32 32-bit GP Register File
  _____________________________________*/
  
 `timescale 1ns / 1ps
  
  module register_file (
	
		output [31:0] Read_Data1,		// Value stored at address Rs1
		output [31:0] Read_Data2,		// Value stored at address Rs2
		input	 [ 4:0] Read_Reg1,		// Address Rs1
		input  [ 4:0] Read_Reg2,		// Address Rs2
		input  [ 4:0] Write_Reg,		// Address Rd
		input  [31:0] Write_Data,		// Data to be written at Rd
		input	 RegWrite,		 			// Register Write Signal,
		input	 Clk							// Clock signal for sync RAM
		
		);
		
		// 32 32-bit general purpose registers
		reg [31:0] registers [31:0];
		
		// Initialize the value of the registers to 0
		initial begin 
			$readmemb ("registers_init.mem", registers);
		end
		
		assign Read_Data1 = registers[Read_Reg1]; 
		assign Read_Data2 = registers[Read_Reg2];
		
		always @* begin
			$strobe ($time, ", Read_Reg2 = %0d, Read_Data2 = %0d, registers[Read_Reg2] = %0d", Read_Reg2, Read_Data2, registers[Read_Reg2]);
		end
		
		always @(posedge Clk) begin
			
			// If the write signal is enabled, update the write register
			#1; if (RegWrite && Write_Reg != 0) begin				
				
					#1 registers[Write_Reg] = Write_Data;
					
					$strobe ($time, ", Write: register[%0d] = %0d", Write_Reg, Write_Data);
			end
			
			// register 0 is hardwired to 0  
			registers [0] <= 0;
						
			// Write the memory to a file to track
			$writememb("registers_out.mem", registers);
		
		end

endmodule				
		