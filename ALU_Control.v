/*______________________________
         ALU_Control
  ______________________________*/
  
`timescale 1ns / 1ps

/* Connection Scheme:
	
	ALUOp [1:0] -> comes from the Control Unit
	Function [5:0] -> comes from bits 5:0 of the instruction

	ALUControl[1:0] -> connects to Operation[1:0]
	ALUControl[2] -> connects to Bnegate
	ALUControl[3] -> connects to A_invert 
*/	
	
module ALU_Control (
	
	output reg [3:0] ALUControl,
	input      [1:0] ALUOp,
	input      [5:0] Function
	
	);
	
	// trigger whenever input changes
	always @(*) begin
		
		case (ALUOp)
			2'b00: 									// + (lw, sw, addi)
				ALUControl <= 4'b0010;
			
			2'b01: 									// - (slti, beq, bne)
				ALUControl <= 4'b0110;
			
			default: case(Function)
				
				6'b100100: 						// AND
					ALUControl <= 4'b0000;
										
				6'b100101: 							// OR
					ALUControl <= 4'b0001;

				
				6'b100000:						// ADD
					ALUControl <= 4'b0010;
				
				6'b100010:							// SUB
					ALUControl <= 4'b0110;
				
				6'b101010: 							// SLT
					ALUControl <= 4'b0111;
				
				6'b100111: 							// NOR
					ALUControl <= 4'b1100;
				
				default	: 
					ALUControl <= 4'b000;
				
				endcase
		endcase
		
		$strobe ($time, ", ALUControl = %b", ALUControl);
		
	end
		
endmodule 