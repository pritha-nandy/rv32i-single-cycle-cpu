`timescale 1ns / 1ps
module data_memory(input [31:0]address,input clk,input Memwrite,output reg [31:0]read_data,input [31:0] write_data

    );
    reg[31:0]data_mem[0:255];
    integer i;
    initial begin
        for(i=0;i<256;i=i+1)
             data_mem[i]=32'b0;
    end
    always @(*)
        begin
            read_data=data_mem[address>>2];
        end
    always @(posedge clk)
        begin
            if(Memwrite)
                data_mem[address>>2]<=write_data;
        end
        
    
endmodule

