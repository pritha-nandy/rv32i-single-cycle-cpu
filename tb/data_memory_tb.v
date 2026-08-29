`timescale 1ns / 1ps

module data_memory_tb;

    reg [31:0] address;
    reg clk;
    reg Memwrite;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory uut (
        .address(address),
        .clk(clk),
        .Memwrite(Memwrite),
        .read_data(read_data),
        .write_data(write_data)
    );

    // Clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial values
        address = 32'b0;
        write_data = 32'b0;
        Memwrite = 1'b0;

        // --------------------------------
        // Write 25 to address 0
        // --------------------------------
        #10;
        address = 32'd0;
        write_data = 32'd25;
        Memwrite = 1'b1;

        #10;
        Memwrite = 1'b0;

        // Read address 0
        #10;
        address = 32'd0;

        // --------------------------------
        // Write 50 to address 4
        // --------------------------------
        #10;
        address = 32'd4;
        write_data = 32'd50;
        Memwrite = 1'b1;

        #10;
        Memwrite = 1'b0;

        // Read address 4
        #10;
        address = 32'd4;

        // --------------------------------
        // Write 100 to address 8
        // --------------------------------
        #10;
        address = 32'd8;
        write_data = 32'd100;
        Memwrite = 1'b1;

        #10;
        Memwrite = 1'b0;

        // Read address 8
        #10;
        address = 32'd8;

        // --------------------------------
        // Check that MemWrite = 0
        // doesn't change memory
        // --------------------------------
        #10;
        address = 32'd4;
        write_data = 32'd999;
        Memwrite = 1'b0;

        #10;

        // Read address 4 again
        // Should still be 50

        #10 $finish;

    end

endmodule