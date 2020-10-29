/*_________________________________
         The Control Unit
  _____________________________________*/
  
  `timescale 1ns / 1ps
  
  module Control_Unit (
		
		input      [5:0] 	OpCode,		// The opcode from your instruction Instruction[31:26]
		input					Reset,
		output reg			RegDst,
		output reg			Jump,
		output reg			JAL,
		output reg			Branch,
		output reg			MemRead,
		output reg			MemToReg,
		output reg [1:0]	ALUOp,
		output reg			MemWrite,
		output reg			ALUSrc,
		output reg			RegWrite
		
		);
	
	always @* begin
	
		if (Reset) begin
			
				RegDst   <= 0;
				ALUSrc   <= 0;
				MemToReg <= 0;
				RegWrite <= 0;
				MemRead	<= 0;
				MemWrite <= 0;
				Branch   <= 0;
				Jump		<= 0;
				JAL		<= 0;
				ALUOp    <= 0;
			
		end
		
		else begin
			case (OpCode)
			
				6'b000000: begin		//R-type
				
						RegDst   <= 1;
						ALUSrc   <= 0;
						MemToReg <= 0;
						RegWrite <= 1;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 2'b10;
				end
				
				6'b001000: begin		//addi
			
						RegDst   <= 0;
						ALUSrc   <= 1;
						MemToReg <= 0;
						RegWrite <= 1;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 0;
				end
				
				6'b100011: begin		//lw
			
						RegDst   <= 0;
						ALUSrc   <= 1;
						MemToReg <= 1;
						RegWrite <= 1;
						MemRead	<= 1;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 0;
				end
				
				6'b101011: begin		//sw
			
						RegDst   <= 0;
						ALUSrc   <= 1;
						MemToReg <= 0;
						RegWrite <= 0;
						MemRead	<= 0;
						MemWrite <= 1;
						Branch   <= 0;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 0;
				end
				
				6'b000100: begin		//BEQ
			
						RegDst   <= 0;
						ALUSrc   <= 0;
						MemToReg <= 0;
						RegWrite <= 0;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 1;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 2'b01;
				end
				
				6'b000010: begin		//J
				
						RegDst   <= 0;
						ALUSrc   <= 0;
						MemToReg <= 0;
						RegWrite <= 0;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 1;
						JAL		<= 0;
						ALUOp    <= 0;
				end
				
				6'b000011: begin		//JAL
				
						RegDst   <= 0;
						ALUSrc   <= 0;
						MemToReg <= 0;
						RegWrite <= 1;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 1;
						JAL		<= 1;
						ALUOp    <= 0;
				end
				
				default: begin
						
						RegDst   <= 0;
						ALUSrc   <= 0;
						MemToReg <= 0;
						RegWrite <= 0;
						MemRead	<= 0;
						MemWrite <= 0;
						Branch   <= 0;
						Jump		<= 0;
						JAL		<= 0;
						ALUOp    <= 0;
				end
				
			endcase
		end
			
	end
	
	endmodule
