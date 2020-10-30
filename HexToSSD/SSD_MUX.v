module SSD_MUX
	(
		input S0, S1,
				W0, X0, Y0, Z0,
				W1, X1, Y1, Z1,
				W2, X2, Y2, Z2,
				W3, X3, Y3, Z3,
		
		output reg W,
		output reg X,
		output reg Y,
		output reg Z
	);
	
	
	always @* begin
	
		case ({S1,S0})
		
			2'b00: begin
			
				W = W0;
				X = X0;
				Y = Y0;
				Z = Z0;
			
			end
			
			2'b01: begin
			
				W = W1;
				X = X1;
				Y = Y1;
				Z = Z1;
			
			end
			
			2'b10: begin
			
				W = W2;
				X = X2;
				Y = Y2;
				Z = Z2;
			
			end
			
			2'b11: begin
			
				W = W3;
				X = X3;
				Y = Y3;
				Z = Z3;
			
			end
		
		endcase
	
	end 
	

endmodule
