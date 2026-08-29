


`timescale 1ns / 1ps

module pc_tb;

    // Inputs to DUT
    reg clk;
    reg reset;
    reg pc_src;
    reg [31:0] branch;
  
    
    // Outputs from DUT
    wire [31:0] pc_current;
    wire [31:0] pc_inter;
    wire [31:0] instruction;
    

    // Instantiate your PC
    pc uut (
        .clk(clk),
        .reset(reset),
        .pc_src(pc_src),
        .branch(branch),
        .pc_current(pc_current),
        .pc_inter(pc_inter)
    );
    
    instruction_memory dut(
                    .address(pc_current),
                    .instruction(instruction));
    
    

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin

        // Initial values
        reset = 1;
        pc_src = 0;
        branch = 32'd0;
        

        // Hold reset for one clock cycle
        #10;

        // Release reset
        reset = 0;

        // Normal execution: PC should increase by 4
        pc_src = 0;

        #10;
        #10;
        #10;
        #10;
        #10;

        $finish;
    end

endmodule
