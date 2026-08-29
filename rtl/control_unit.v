`timescale 1ns / 1ps
module control_unit( input [6:0]opcode,output reg Regwrite,output reg Memwrite,output reg ALU_src,output reg [2:0]Result_src,output reg [2:0]imm_src,output reg branch,output reg jump,output reg [1:0]ALU_op

    );
    always @(*)
        begin
            case(opcode)
                //R-type
                7'b0110011: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'b0;
                            Result_src=3'b000;
                            imm_src=3'bz;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op= 2'b10;
                            end
                //I-type
                7'b0010011: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'b1;
                            Result_src=3'b000;
                            imm_src=3'b000;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'b10;
                            end
                //load
                7'b0000011: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'b1;
                            Result_src=3'b001;
                            imm_src=3'b000;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'b00;
                            end
                //S-type
                7'b0100011: begin
                            Regwrite=1'b0;
                            Memwrite=1'b1;
                            ALU_src=1'b1;
                            Result_src=3'bz;
                            imm_src=3'b001;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'b00;
                            end
                //B-type
                7'b1100011: begin
                            Regwrite=1'b0;
                            Memwrite=1'b0;
                            ALU_src=1'b0;
                            Result_src=3'bz;
                            imm_src=3'b010;
                            branch=1'b1;
                            jump=1'b0;
                            ALU_op=2'b01;
                            end
                //JALR
                7'b1100111: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'b1;
                            Result_src=3'b010;
                            imm_src=3'b000;
                            branch=1'b0;
                            jump=1'b1;
                            ALU_op=2'b00;
                            end
                //JAL
                7'b1101111: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'bz;
                            Result_src=3'b010;
                            imm_src=3'b100;
                            branch=1'b0;
                            jump=1'b1;
                            ALU_op=2'bz;
                            end
                //LUI
                7'b0110111: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'bz;
                            Result_src=3'b011;//?
                            imm_src=3'b011;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'bz;
                            end
               //AUIPC
               7'b0010111: begin
                            Regwrite=1'b1;
                            Memwrite=1'b0;
                            ALU_src=1'b1;
                            Result_src=3'b100;
                            imm_src=3'b011;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'b00;
                            end
              default:      begin
                            Regwrite=1'b0;
                            Memwrite=1'b0;
                            ALU_src=1'b0;
                            Result_src=3'b000;
                            imm_src=3'b000;
                            branch=1'b0;
                            jump=1'b0;
                            ALU_op=2'b00;
                            end
                 endcase
           end
                            
                            
endmodule

