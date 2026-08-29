`timescale 1ns / 1ps
module pc(input clk, input reset, output reg [31:0] pc_current,
        input pc_src,input [31:0]branch1,output reg [31:0]pc_inter
    );
    always @(posedge clk)
        begin
            if(reset) pc_current<=32'b0;
            else
                pc_current <=pc_inter;
        end
    always @(*)
        begin
            case(pc_src)
                1'b0:pc_inter =pc_current+32'b0000_0000_0000_0000_0000_0000_0000_0100;
                1'b1:pc_inter =branch1;
                default: pc_inter = pc_current + 4;
            endcase
        end
            
endmodule

