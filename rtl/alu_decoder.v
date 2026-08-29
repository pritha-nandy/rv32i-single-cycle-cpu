`timescale 1ns / 1ps
module alu_decoder(input [6:0]opcode,input [2:0]funct3,input [6:0]funct7,input [1:0]ALU_op,output reg [3:0]ALU_control

    );
    always @(*)
        begin
            case(ALU_op)
                2'b00:ALU_control=4'b0000;
                2'b01: begin
                    case(funct3)
                        3'b000:ALU_control=4'b0001;//BEQ
                        3'b001:ALU_control=4'b0001;//BNE
                        3'b100:ALU_control=4'b0101;//BLT
                        3'b101:ALU_control=4'b0101;//BGE
                        3'b110:ALU_control=4'b0110;//BLTU
                        3'b111:ALU_control=4'b0110;//BGEU
                     endcase
                     end
                2'b10:begin
                      case(opcode)
                        7'b0110011:begin              
                                  case(funct3)
                                     3'b000:begin
                                            case(funct7)
                                               7'b0000000:ALU_control=4'b0000;
                                               7'b0100000:ALU_control=4'b0001;
                                            endcase
                                            end
                                     3'b111:ALU_control=4'b0010;
                                     3'b110:ALU_control=4'b0011;
                                     3'b100:ALU_control=4'b0100;
                                     3'b010:ALU_control=4'b0101;
                                     3'b011:ALU_control=4'b0110;
                                     3'b001:ALU_control=4'b0111;
                                     3'b101: begin
                                             case(funct7)
                                                 7'b0000000: ALU_control = 4'b1000; // SRL
                                                 7'b0100000: ALU_control = 4'b1001; // SRA
                                             endcase
                                             end
                                  endcase
                                  end
                       7'b0010011:begin
                                  case(funct3)
                                     3'b000:ALU_control=4'b0000;
                                     3'b111:ALU_control=4'b0010;
                                     3'b110:ALU_control=4'b0011;
                                     3'b100:ALU_control=4'b0100;
                                     3'b010:ALU_control=4'b0101;
                                     3'b011:ALU_control=4'b0110;
                                     3'b001: ALU_control = 4'b0111; // SLLI

                                     3'b101: begin
                                             case(funct7)
                                                 7'b0000000: ALU_control = 4'b1000; // SRLI
                                                 7'b0100000: ALU_control = 4'b1001; // SRAI
                                            endcase
                                            end
                                  endcase
                                  end
                    endcase     
                   end
                2'b11: ALU_control=4'bz;
            endcase
        end
                       
                        
                
    
endmodule

