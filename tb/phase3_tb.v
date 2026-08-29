`timescale 1ns / 1ps
module phase3_tb(

    );
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    
    reg[4:0]rs1;
    reg[4:0]rs2;
    reg[4:0]rd;
    reg clk;
    reg[31:0]data;
    reg enable;
    
    register_file dut(
                    .read_data1(read_data1),
                    .read_data2(read_data2),
                    .rs1(rs1),
                    .rs2(rs2),
                    .rd(rd),
                    .clk(clk),
                    .data(data),
                    .enable(enable));
   initial begin
        clk=1'b0;
        forever #5 clk=~clk;
   end
 
   initial begin
       rs1=0;rs2=0;enable=1'b0;rd=0;data=0;
       #10 rd=5;data=25;enable=1'b1;
       #10 rd=10;data=50;enable=1'b1;
       #10 rs1=5;rs2=10;
       #10 rd=0;data=100;enable=1'b1;
       #10 rs1=0;
       #10 $finish;
   end
  
    
endmodule
