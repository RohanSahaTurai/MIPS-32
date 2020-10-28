/*______________________________
         32-bit ALU
  ______________________________*/
  
  `timescale 1ns / 1ps

module ALU (
	
	output reg [31:0] Result, 
	output Zero,
	input [31:0] A, 
	input [31:0] B, 
	input A_invert, 
	input B_negate,			//Bnegate -> B_invert and Carry_In shorted together
	input [1:0] Operation
	
	);
	
	always @(*) begin
	
		case ({{A_invert, B_negate}, Operation})
		
			4'b0010: Result = A + B;		// ADD
			4'b0110: Result = A - B;		// SUBTRACT
			4'b0000: Result = A & B;		// AND
			4'b0001: Result = A | B;		// OR
			
			4'b0111: begin						// SLT
				if (A < B)
					Result = 32'd1;
				else
					Result = 32'd0;
			end
			
			4'b1100: Result = (~A) & (~B);	//NOR			
			
			default: Result = A + B;
			
		endcase
	
		$strobe ($time, ", A = %0d, B = %0d, Result = %0d", A, B, Result);
		
	end
	
	
	assign Zero = (Result == 0) ? 1: 0;
	
endmodule
	
		
	
	
	