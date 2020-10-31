module CounterUp_modulo_50M (input clk, output [25:0] out);


	reg [25:0] cnt;
	
	initial begin
		cnt <= 0;
	end
	
	always @(posedge clk) begin
	
		if (cnt == 50000000) begin
			cnt <= 0;
		end
		
		else begin
			cnt <= cnt + 1;
		end
	end
	
	assign out = cnt;

endmodule 