module SSD (
	
	output reg A,
	output reg B,
	output reg C,
	output reg D,
	output reg E,
	output reg F,
	output reg G,
	input	     W,
	input      X,
	input      Y,
	input		  Z
	
	);
	
	reg [3:0] number; 	
	
	always @(*) begin
	
		number = {W,{X,{Y,Z}}};
	
		case (number)
			
			4'd0:	begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 1;
				E = 1;
				F = 1;
				G = 0;
			end
			
			4'd1:	begin
				
				A = 0;
				B = 1;
				C = 1;
				D = 0;
				E = 0;
				F = 0;
				G = 0;
			end
			
			4'd2:	begin
				
				A = 1;
				B = 1;
				C = 0;
				D = 1;
				E = 1;
				F = 0;
				G = 1;
			end
			
			4'd3:	begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 1;
				E = 0;
				F = 0;
				G = 1;
			end
			
			4'd4:	begin
				
				A = 0;
				B = 1;
				C = 1;
				D = 0;
				E = 0;
				F = 1;
				G = 1;
			end
			
			4'd5:	begin
				
				A = 1;
				B = 0;
				C = 1;
				D = 1;
				E = 0;
				F = 1;
				G = 1;
			end
			
			4'd6:	begin
				
				A = 1;
				B = 0;
				C = 1;
				D = 1;
				E = 1;
				F = 1;
				G = 1;
			end
			
			4'd7:	begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 0;
				E = 0;
				F = 0;
				G = 0;
			end
			
			4'd8:	begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 1;
				E = 1;
				F = 1;
				G = 1;
			end
			
			4'd9:	begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 1;
				E = 0;
				F = 1;
				G = 1;
			end
			
			4'd10: begin
				
				A = 1;
				B = 1;
				C = 1;
				D = 0;
				E = 1;
				F = 1;
				G = 1;
			end
			
			4'd11: begin
				
				A = 0;
				B = 0;
				C = 1;
				D = 1;
				E = 1;
				F = 1;
				G = 1;
			end
			
			4'd12: begin
				
				A = 1;
				B = 0;
				C = 0;
				D = 1;
				E = 1;
				F = 1;
				G = 0;
			end
			
			4'd13: begin
				
				A = 0;
				B = 1;
				C = 1;
				D = 1;
				E = 1;
				F = 0;
				G = 1;
			end
			
			4'd14: begin
				
				A = 1;
				B = 0;
				C = 0;
				D = 1;
				E = 1;
				F = 1;
				G = 1;
			end
			
			4'd15: begin
				
				A = 1;
				B = 0;
				C = 0;
				D = 0;
				E = 1;
				F = 1;
				G = 1;
			end
		
		endcase
	
	end
	
	
	
	

endmodule 