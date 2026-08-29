`timescale 1ns / 1ps
module register_file(input[4:0]rs1,input[4:0]rs2,input[4:0]rd,input [31:0]data,input Regwrite
       , output reg[31:0]read_data1, output reg[31:0]read_data2,input clk
    );
    reg [31:0] register [0:31];
    integer i;
    initial begin
        for(i=0;i<32;i=i+1) begin
            register[i]=0;
         end
    end
    always @(*)
        begin
            read_data1=register[rs1];
            read_data2=register[rs2];
        end
    always @(posedge clk)
        begin
            if(Regwrite && rd!=0) register[rd]<=data;
        end
endmodule

