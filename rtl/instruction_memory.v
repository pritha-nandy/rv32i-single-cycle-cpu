`timescale 1ns / 1ps
module instruction_memory(
    input [31:0] address,
    output [31:0] instruction
);

    reg [31:0] mem[0:255];
    integer i;

    assign instruction = mem[address >> 2];

    initial begin

        // Initialize unused memory to NOP
        // NOP = ADDI x0, x0, 0
        for(i = 0; i < 256; i = i + 1)
            mem[i] = 32'h00000013;


        // =========================================
        // I-TYPE ALU INSTRUCTIONS
        // =========================================

        mem[0] = 32'h00A00093; // ADDI  x1,  x0, 10
        mem[1] = 32'h01400113; // ADDI  x2,  x0, 20

        mem[2] = 32'h00A00913; // ADDI  x18, x0, 10
        mem[3] = 32'h00C07993; // ANDI  x19, x0, 12
        mem[4] = 32'h00806A13; // ORI   x20, x0, 8
        mem[5] = 32'h00304A93; // XORI  x21, x0, 3
        mem[6] = 32'h01402B13; // SLTI  x22, x0, 20
        mem[7] = 32'h01403B93; // SLTIU x23, x0, 20


        // =========================================
        // R-TYPE
        // x1 = 10
        // x2 = 20
        // =========================================

        mem[8]  = 32'h002081B3; // ADD  x3, x1, x2   = 30
        mem[9]  = 32'h40110233; // SUB  x4, x2, x1   = 10
        mem[10] = 32'h0020F2B3; // AND  x5, x1, x2
        mem[11] = 32'h0020E333; // OR   x6, x1, x2
        mem[12] = 32'h0020C3B3; // XOR  x7, x1, x2
        mem[13] = 32'h0020A433; // SLT  x8, x1, x2   = 1
        mem[14] = 32'h0020B4B3; // SLTU x9, x1, x2   = 1


        // =========================================
        // SW + LW
        // =========================================

        mem[15] = 32'h03700513; // ADDI x10, x0, 55
        mem[16] = 32'h00A02023; // SW   x10, 0(x0)
        mem[17] = 32'h00002583; // LW   x11, 0(x0)


        // =========================================
        // BRANCH TESTS
        //
        // x1 = 10
        // x2 = 20
        //
        // +8 skips one instruction
        // =========================================

        // BEQ: 10 == 20 -> NOT TAKEN
        mem[18] = 32'h00208463; // BEQ  x1,x2,+8
        mem[19] = 32'h00100293; // ADDI x5,x0,1
                                  // EXECUTES


        // BNE: 10 != 20 -> TAKEN
        mem[20] = 32'h00209463; // BNE  x1,x2,+8
        mem[21] = 32'h00200293; // ADDI x5,x0,2
                                  // SKIPPED
        mem[22] = 32'h00300293; // ADDI x5,x0,3
                                  // EXECUTES


        // BLT: 10 < 20 -> TAKEN
        mem[23] = 32'h0020C463; // BLT  x1,x2,+8
        mem[24] = 32'h00400293; // ADDI x5,x0,4
                                  // SKIPPED
        mem[25] = 32'h00500293; // ADDI x5,x0,5
                                  // EXECUTES


        // BGE: 10 >= 20 -> NOT TAKEN
        mem[26] = 32'h0020D463; // BGE  x1,x2,+8
        mem[27] = 32'h00600293; // ADDI x5,x0,6
                                  // EXECUTES


        // BLTU: 10 < 20 -> TAKEN
        mem[28] = 32'h0020E463; // BLTU x1,x2,+8
        mem[29] = 32'h00700293; // ADDI x5,x0,7
                                  // SKIPPED
        mem[30] = 32'h00800293; // ADDI x5,x0,8
                                  // EXECUTES


        // BGEU: 10 >= 20 -> NOT TAKEN
        mem[31] = 32'h0020F463; // BGEU x1,x2,+8
        mem[32] = 32'h00900293; // ADDI x5,x0,9
                                  // EXECUTES


        // =========================================
        // U-TYPE
        // =========================================

        mem[33] = 32'h12345637; // LUI   x12, 0x12345
        // Expected x12 = 0x12345000

        mem[34] = 32'h00001697; // AUIPC x13, 0x1
        // PC = 34 * 4 = 0x88
        // Expected x13 = 0x1088


        // =========================================
        // PREPARE JALR
        // =========================================

        mem[35] = 32'h0A000793; // ADDI x15, x0, 160
        // x15 = 160 = 0xA0


        // =========================================
        // JAL
        // =========================================

        mem[36] = 32'h0080076F; // JAL x14, +8
        mem[37] = 32'h00A00413; // ADDI x8, x0, 10
                                  // SKIPPED

        mem[38] = 32'h00078867; // JALR x16, 0(x15)


        // =========================================
        // JALR TARGET
        //
        // 0xA0 >> 2 = 40
        // =========================================

        mem[40] = 32'h06300893; // ADDI x17, x0, 99

    end

endmodule
