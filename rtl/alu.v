`timescale 1ns / 1ps
module alu(input [31:0]A,input [31:0] B, input[3:0]ALU_control,output reg [31:0]result,output reg zero

    );
    always @(*)
        begin
            case(ALU_control)
                4'b0000:begin
                       result=A+B;
                       zero=~(|result);
                       end
                4'b0001: begin
                        result=A-B;
                        zero=~(|result);
                        end
                4'b0010: begin
                        result=A&B;
                        zero=~(|result);
                        end
                4'b0011: begin
                        result=A|B;
                        zero=~(|result);
                        end
                4'b0100: begin
                        result=A^B;
                        zero=~(|result);
                        end
                4'b0101: begin
                        result = ($signed(A)<$signed(B))?32'b1:32'b0;
                        zero=~(|result);
                        end
                4'b0110: begin
                        result=(A<B)?32'b1:32'b0;
                        zero=~(|result);
                        end
                4'b0111: begin
                        result= A<<(B[4:0]);
                        zero=~(|result);
                        end
                4'b1000: begin
                        result= A>>(B[4:0]);
                        zero=~(|result);
                        end
                4'b1001: begin
                        result= ($signed(A))>>>(B[4:0]);
                        zero=~(|result);
                        end       
                default: result =32'bz;
                
               endcase
         end
    
                        
endmodule

