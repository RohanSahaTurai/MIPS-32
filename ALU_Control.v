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
	output reg		  JR,				// Control Signal for Jump Register instruction		
	input      [1:0] ALUOp,
	input      [5:0] Function
	
	);
	
	// trigger whenever input changes
	always @(*) begin
		
		case (ALUOp)
			2'b00: begin									// + (lw, sw, addi)
				ALUControl <= 4'b0010;
				JR			  <= 0;
			end
			
			2'b01: begin									// - (slti, beq, bne)
				ALUControl <= 4'b0110;
				JR			  <= 0;
			end
			
			default: case(Function)
				
				6'b100100: begin							// AND
					ALUControl <= 4'b0000;
					JR			  <= 0;
				end
					
				6'b100101: begin							// OR
					ALUControl <= 4'b0001;
					JR			  <= 0;
				end
				
				6'b100000: begin							// ADD
					ALUControl <= 4'b0010;
					JR			  <= 0;
				end
				
				6'b100010: begin							// SUB
					ALUControl <= 4'b0110;
					JR			  <= 0;
				end
				
				6'b101010: begin							// SLT
					ALUControl <= 4'b0111;
					JR			  <= 0;
				end
				
				6'b100111: begin							// NOR
					ALUControl <= 4'b1100;
					JR			  <= 0;
				end
				
				6'b001000: begin							// JR
					ALUControl <= 4'b0000; //don't care
					JR			  <= 1;
				end
				
				default	: begin
					ALUControl <= 4'b000;
					JR			  <= 0;
				end
				
				endcase
		endcase
		
		$strobe ($time, ", ALUControl = %b", ALUControl);
		
	end
		
endmodule 