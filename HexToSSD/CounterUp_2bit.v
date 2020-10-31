module CounterUp_2bit (input clk, output [1:0] out);


	reg [1:0] cnt;
	
	initial begin
		cnt <= 0;
	end
	
	always @(posedge clk) begin
			
		cnt <= cnt + 1;
	end
	
	assign out = cnt;

endmodule 