
`timescale 1ns / 1ps
module control_unit_tb;

    reg [6:0] opcode;

    wire Regwrite;
    wire Memwrite;
    wire ALU_src;
    wire [1:0] Result_src;
    wire [2:0] imm_src;
    wire branch;
    wire jump;
    wire [1:0] ALU_op;

    control_unit uut (
        .opcode(opcode),
        .Regwrite(Regwrite),
        .Memwrite(Memwrite),
        .ALU_src(ALU_src),
        .Result_src(Result_src),
        .imm_src(imm_src),
        .branch(branch),
        .jump(jump),
        .ALU_op(ALU_op)
    );

    initial begin

        // R-type
        opcode = 7'b0110011;
        #10;

        // I-type ALU
        opcode = 7'b0010011;
        #10;

        // LW
        opcode = 7'b0000011;
        #10;

        // SW
        opcode = 7'b0100011;
        #10;

        // B-type
        opcode = 7'b1100011;
        #10;

        // JALR
        opcode = 7'b1100111;
        #10;

        // JAL
        opcode = 7'b1101111;
        #10;

        // LUI
        opcode = 7'b0110111;
        #10;

        // AUIPC
        opcode = 7'b0010111;
        #10;

        // Invalid opcode -> default
        opcode = 7'b1111111;
        #10;

        $finish;
    end

endmodule
