`timescale 1ns / 1ps
module phase4_tb(

    );
    wire [31:0] result;
    wire zero;
    
    reg [31:0]A;
    reg [31:0]B;
    reg [2:0]ALU_control;
    
    alu dut( .A(A),
             .B(B),
             .ALU_control(ALU_control),
             .result(result),
             .zero(zero));
    initial begin
        A=32'b0;B=32'b0;ALU_control=3'b0;
        #10 A=32'd10;B=32'd20;ALU_control=3'b000;
        #10 A=32'd20;B=32'd10;ALU_control=3'b001;
        #10 A=32'd10;B=32'd10;ALU_control=3'b001;
        #10 A=32'd10;B=32'd20;ALU_control=3'b010;
        #10 A=32'd10;B=32'd20;ALU_control=3'b011;
        #10 A=32'd15;B=32'd25;ALU_control=3'b100;
        #10 A=32'hFFFFFFFF;B=32'b1;ALU_control=3'b110;
        #10 A=32'hFFFFFFF1;B=32'd1;ALU_control=3'b101;
        #10 $finish;
    end
    
   
endmodule
