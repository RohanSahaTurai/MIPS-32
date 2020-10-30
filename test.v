
`timescale 1ns / 1ps

module test;

	parameter HALF_PERIOD = 100;
	
	reg Clk, reset;

	// Data Memory Wires
	wire [31:0] memory_5;
	wire [31:0] PC;
	
	top_level i1 (Clk, reset, memory_5, PC);
	
	initial begin
		
		Clk = 0;
		forever #HALF_PERIOD Clk = ~Clk;
	
	end
	
	initial begin
		
		$display($time, " <<Staring Simulation>>");
		
		reset = 1;
		
		#150;
		reset = 0;
		
		#600000;
		$display($time, " <<Simulation Complete>>");
		$stop;
	end
		
endmodule



module test_reg_file;

	wire [31:0] Read_Data1;		// Value stored at address Rs1
	wire [31:0] Read_Data2;		// Value stored at address Rs2
	reg [ 4:0]  Read_Reg1;		// Address Rs1
	reg [ 4:0]  Read_Reg2;		// Address Rs2
	reg [ 4:0]  Write_Reg;		// Address Rd
	reg [31:0]  Write_Data;		// Data to be written at Rd
	reg	      RegWrite;			// Register Write Signal
	reg			Clk;
	
	parameter PERIOD = 5;
	
	
	register_file regFile (
	
		Read_Data1,		// Value stored at address Rs1
		Read_Data2,		// Value stored at address Rs2
		Read_Reg1,		// Address Rs1
		Read_Reg2,		// Address Rs2
		Write_Reg,		// Address Rd
		Write_Data,		// Data to be written at Rd
		RegWrite,		// Register Write Signal
		Clk				// Clk signal
		
		);
	
	always #PERIOD Clk = ~Clk;

	initial begin
		
		$display($time, "<<Staring Simulation>>");
		
		Clk = 1;
		
		Read_Reg1 = 0;
		Read_Reg2 = 0;
		
		RegWrite   = 1;
		Write_Reg  = 1;
		Write_Data = 56;
		
		#10;
		
		RegWrite   = 0;
		Write_Reg  = 1;
		Write_Data = 50;
		
		#20;
		
		Read_Reg1  = 1;
		Read_Reg2  = 1;
		
		RegWrite   = 1;
		Write_Reg  = 2;
		Write_Data = 20;
		
		#30; 
		RegWrite = 0;
		
		Read_Reg1  = 1;
		Read_Reg2  = 2;
		
		#40;
		$display($time, "<<Simulation Complete>>");
		$stop;
	end
		
endmodule


module test_inst_mem;

	wire [31:0] read_data;
	reg  [31:0] address;
	
	Instruction_memory InstMem (read_data, address);
	
	initial begin
		
		$display($time, "<<Staring Simulation>>");
		
		address = 1;
		
		#20;
		
		address = 2;
		
		#50;
		$display($time, "<<Simulation Complete>>");
		$stop;
	end
		
endmodule


module test_ALU;
  
	reg [1:0] ALUOp;
	reg [5:0] Function;
	wire [3:0] ALUCtl;
  
	// ALU Wires
	wire [31:0] ALUResult;
	wire CarryOut, Overflow, Zero;
	reg [31:0] ReadData1;
	reg [31:0] ALU_in2;
  
	ALU_Control a1 (ALUCtl, ALUOp, Function);
  
	// 32-bit ALU
	ALU_32bit ALU (ALUResult, CarryOut, Overflow, Zero, 
						ReadData1, ALU_in2, ALUCtl[3], ALUCtl[2], ALUCtl[1:0]);
  
  initial begin
   
	 $display($time, " << Starting Simulation >> ");
    
	 ALUOp = 2'b00;
    Function = 6'b000000;
	 ReadData1 = 1;
	 ALU_in2 = 1;
    
    #10 ALUOp = 2'b01;
    
    #20;
	 $display($time, "<< Simulation Complete >>");
    $stop;
	 
  end

endmodule