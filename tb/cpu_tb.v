`timescale 1ns / 1ps

module cpu_tb;

    reg clk;
    reg reset;

    cpu dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Reset + run CPU
    initial begin
        reset = 1'b1;

        #10;
        reset = 1'b0;

        // Run long enough for all instructions
        #500;

        $finish;
    end

endmodule
