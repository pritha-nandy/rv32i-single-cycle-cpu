`timescale 1ns / 1ps
module phase5_tb(

    );
    wire [31:0]imm_ext;
    
    reg [31:0]instruction;
    reg [2:0] imm_src;
    
    immediate_generator uut(
                        .imm_src(imm_src),
                        .imm_ext(imm_ext),
                        .instruction(instruction));
                        
    initial begin

        // Initial values
        instruction = 32'b0;
        imm_src = 3'b000;

        // I-type: +10
        #10;
        instruction = 32'b000000001010_00000_000_00000_0000000;
        imm_src = 3'b000;

        // I-type: -2
        #10;
        instruction = 32'b111111111110_00000_000_00000_0000000;
        imm_src = 3'b000;

        // S-type: +12
        #10;
        instruction = 32'b0000000_00000_000_01100_0000000;
        imm_src = 3'b001;

        // S-type: -1
        #10;
        instruction = 32'b1111111_00000_000_11110_0000000;
        imm_src = 3'b001;

        // B-type: +36
        #10;
        instruction = 32'b0000000_00010_00000_000_00010_0_0000000;
        imm_src = 3'b010;

        // B-type: -2
        #10;
        instruction = 32'b1111111_00000_00000_000_1111_1_0000000;
        imm_src = 3'b010;

        // U-type: 0xABCDE000
        #10;
        instruction = 32'hABCDE000;
        imm_src = 3'b011;

        // J-type: -2
        #10;
        instruction = 32'b11111111111111111111_0_1111111111_0_0000000;
        imm_src = 3'b100;

        #10;
        $finish;

    end
                        
    
    
endmodule
