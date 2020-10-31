module SSD_MUX
	(
		input [1:0] Select,
		input [3:0] num4,
		input [3:0] num3,
		input [3:0] num2,
		input [3:0] num1,
		output reg [3:0] out
	);
	
	
	always @* begin
	
		case (Select)
		
			2'b00: out = num1;
			
			2'b01: out = num2;
			
			2'b10: out = num3;
			
			default: out = num4;
		
		endcase
	
	end 
	

endmodule
