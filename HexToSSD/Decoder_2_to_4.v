module Decoder_2_to_4
	(
		input  [1:0] Select,	
		output reg 	D1,
		output reg  D2,
		output reg  D3,
		output reg  D4
	);
	
	always @* begin
	
		case (Select)
		
			2'b00: begin
			
				D1 = 1;
				D2 = 0;
				D3 = 0;
				D4 = 0;
			
			end
			
			2'b01: begin
			
				D1 = 0;
				D2 = 1;
				D3 = 0;
				D4 = 0;
			
			end
			
			2'b10: begin
			
				D1 = 0;
				D2 = 0;
				D3 = 1;
				D4 = 0;
			
			end
			
			default: begin
			
				D1 = 0;
				D2 = 0;
				D3 = 0;
				D4 = 1;
			
			end
		
		endcase
	
	end 
	
	
endmodule
