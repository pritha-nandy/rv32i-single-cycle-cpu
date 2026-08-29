`timescale 1ns / 1ps
module alu_decoder_tb;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [1:0] ALU_op;

    wire [2:0] ALU_control;

    alu_decoder uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALU_op(ALU_op),
        .ALU_control(ALU_control)
    );

    initial begin

        // =========================================
        // R-TYPE
        // =========================================

        // ADD
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;

        // SUB
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0100000;
        ALU_op = 2'b10;
        #10;

        // AND
        opcode = 7'b0110011;
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;

        // OR
        opcode = 7'b0110011;
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;

        // XOR
        opcode = 7'b0110011;
        funct3 = 3'b100;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;

        // SLT
        opcode = 7'b0110011;
        funct3 = 3'b010;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;

        // SLTU
        opcode = 7'b0110011;
        funct3 = 3'b011;
        funct7 = 7'b0000000;
        ALU_op = 2'b10;
        #10;


        // =========================================
        // I-TYPE ALU
        // =========================================

        // ADDI
        opcode = 7'b0010011;
        funct3 = 3'b000;
        funct7 = 7'bxxxxxxx;
        ALU_op = 2'b10;
        #10;

        // ANDI
        funct3 = 3'b111;
        #10;

        // ORI
        funct3 = 3'b110;
        #10;

        // XORI
        funct3 = 3'b100;
        #10;

        // SLTI
        funct3 = 3'b010;
        #10;

        // SLTIU
        funct3 = 3'b011;
        #10;


        // =========================================
        // BRANCHES
        // =========================================

        // BEQ
        opcode = 7'b1100011;
        funct3 = 3'b000;
        funct7 = 7'bxxxxxxx;
        ALU_op = 2'b01;
        #10;

        // BNE
        funct3 = 3'b001;
        #10;

        // BLT
        funct3 = 3'b100;
        #10;

        // BGE
        funct3 = 3'b101;
        #10;

        // BLTU
        funct3 = 3'b110;
        #10;

        // BGEU
        funct3 = 3'b111;
        #10;


        // =========================================
        // FORCED ADD
        // =========================================

        // LW
        opcode = 7'b0000011;
        funct3 = 3'b010;
        ALU_op = 2'b00;
        #10;

        // SW
        opcode = 7'b0100011;
        funct3 = 3'b010;
        ALU_op = 2'b00;
        #10;

        // AUIPC
        opcode = 7'b0010111;
        funct3 = 3'b000;
        ALU_op = 2'b00;
        #10;

        // JALR
        opcode = 7'b1100111;
        funct3 = 3'b000;
        ALU_op = 2'b00;
        #10;


        // =========================================
        // DONE
        // =========================================

        $finish;

    end

endmodule
