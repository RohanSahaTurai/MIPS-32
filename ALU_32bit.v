/*______________________________
         32-bit ALU
  ______________________________*/
  
`timescale 1ns / 1ps

module ALU_32bit (
	
	output [31:0] Result, 
	output Carry_Out,
	output Overflow,
	output Zero,
	input [31:0] A, 
	input [31:0] B, 
	input A_invert, 
	input B_negate,			//Bnegate -> B_invert and Carry_In shorted together
	input [1:0] Operation
	
	);
	
	wire [31:0] crrout; 
	wire Set;
	
	always @* begin
		$display ($time, ", In1 = %0d, In2 = %0d, ALU_Result = %0d", A, B, Result);
	end
	
	/* LSB Bit */
	ALU_1bit 	 alu0   (Result[0],  crrout[0],  A[0],  B[0],  A_invert, B_negate, Set,  B_negate,   Operation);
	
	genvar i;
	
	// Replicate the 1bit ALU 30 times for the remaining 30 bits.
	generate 
		for (i = 1; i <= 30; i = i+1) begin: ALU_bits_1_to_30
		
				ALU_1bit alu (Result[i], crrout[i], A[i], B[i], A_invert, B_negate, 1'b0, crrout[i-1], Operation);
		end
	endgenerate
	
	/* MSB bit */
	ALU_1bit_MSB alu31  (Result[31], crrout[31], Overflow, Set, A[31], B[31], A_invert, B_negate, 1'b0, crrout[30], Operation);
	
	// Carry_Out = ~Carry_Out if subtraction is performed
	assign Carry_Out = Operation[1] ? ~crrout[31] : crrout[31];	
	
	/* Zero Detection - NOR Gate */
	wire [9:0] out;
	
	or or1 (out[0], Result[0],  Result[1],  Result[2],  Result[3]);
	or or2 (out[1], Result[4],  Result[5],  Result[6],  Result[7]);
	or or3 (out[2], Result[8],  Result[9],  Result[10], Result[11]);
	or or4 (out[3], Result[12], Result[13], Result[14], Result[15]);
	or or5 (out[4], Result[16], Result[17], Result[18], Result[19]);
	or or6 (out[5], Result[20], Result[21], Result[22], Result[23]);
	or or7 (out[6], Result[24], Result[25], Result[26], Result[27]);
	or or8 (out[7], Result[28], Result[29], Result[30], Result[31]);
	
	or or9  (out[8], out[0], out[1], out[2], out[3]);
	or or10 (out[9], out[4], out[5], out[6], out[7]);
	
	nor nor1 (Zero, out[8], out[9]);

endmodule

/*________________________________________
			 1-bit ALU for 31th bit
	This 1-bit ALU is used for 31th bit 
  ________________________________________*/
 
`timescale 1 ps / 100 fs

module ALU_1bit_MSB (
	
	output Result, 
	output Carry_Out,
	output Overflow,
	output Set,
	input A, 
	input B, 
	input A_invert, 
	input B_invert, 
	input Less, 
	input Carry_In, 
	input [1:0] Operation
	
	);
	
	wire A_in, B_in;
	wire A_AND_B, A_OR_B, A_SUM_B;
	
	assign A_in = A_invert ? ~A : A;
	assign B_in = B_invert ? ~B : B;
	
	and and1 (A_AND_B, A_in, B_in);
	or  or1  (A_OR_B , A_in, B_in);	

	adder_1bit adder (A_SUM_B, Carry_Out, A_in, B_in, Carry_In);
	
	/* Operation multiplexer */
	mux_4x1 opMUX (Result, A_AND_B, A_OR_B, A_SUM_B, Less, Operation);
	
	/* Overflow detection */	
	xor xor1 (Overflow, Carry_In, Carry_Out);
	
	/* Set Less than Detection */
	// If there is an overflow, sign-bit is inversed.
	assign Set = Overflow ? ~A_SUM_B : A_SUM_B;
	
endmodule



/*_________________________________________
						1-bit ALU
	This 1-bit ALU is used in bits 0 to 30
  _________________________________________*/
 
`timescale 1 ps / 100 fs

module ALU_1bit (
	
	output Result, 
	output Carry_Out, 
	input A, 
	input B, 
	input A_invert, 
	input B_invert, 
	input Less, 
	input Carry_In, 
	input [1:0] Operation
	
	);

	
	wire A_in, B_in;
	wire A_AND_B, A_OR_B, A_SUM_B;
	
	assign A_in = A_invert ? ~A : A;
	assign B_in = B_invert ? ~B : B;
	
	and and1 (A_AND_B, A_in, B_in);
	or  or1  (A_OR_B , A_in, B_in);
	
	adder_1bit adder (A_SUM_B, Carry_Out, A_in, B_in, Carry_In);

	
	/* Op_Sel[1]   Op_Sel[0]  Operation
		   0           0         A & B
			0           1         A | B
			1           0         A SUM B
			1           1          Less
	*/										 	
	mux_4x1 opMUX (Result, A_AND_B, A_OR_B, A_SUM_B, Less, Operation);									
	
endmodule
	
		
/*______________________________
         1-bit full adder
  ______________________________*/
  
`timescale 1 ps / 100 fs

module adder_1bit (
	
	output Sum, 
	output C_out, 
	input A, 
	input B, 
	input C_in
	
	);
	
	assign Sum 	 = (A ^ B) ^ C_in;
	assign C_out = (A & B) | C_in & (A ^ B);
	
endmodule


/*______________________________
         4x1 Multiplexer
  ______________________________*/
  
`timescale 1 ps / 100 fs

module mux_4x1 (Out, A, B, C, D, Sel);
	
	output Out;
	
	input A, B, C, D;
	input [1:0] Sel;
	
	/* When Sel[1] = 1 :
			  Sel[0] = 1, Out = D 
			  Sel[0] = 0, Out = C
			  
		When Sel[1] = 0 :
			  Sel[0] = 1, Out = B 
			  Sel[0] = 0, Out = A */
		
	assign Out = Sel[1] ? (Sel[0] ? D : C) : (Sel[0] ? B : A);
	
endmodule
