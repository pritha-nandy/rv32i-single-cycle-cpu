`timescale 1ns / 1ps
module cpu( input clk,input reset );
    
    wire [31:0]pc_current;
    wire [31:0]pc_inter;
    wire pc_src;
    wire [31:0] branch1;
    
    wire [31:0] instruction;
    
    wire[6:0] opcode;
    wire[4:0] rd;
    wire[4:0] rs1;
    wire[4:0] rs2;
    wire[2:0] funct3;
    wire[6:0] funct7;
    
    wire Regwrite;
    wire Memwrite;
    wire ALU_src;
    wire [2:0]Result_src;
    wire [2:0]imm_src;
    wire [1:0]ALU_op;
    wire branch;
    wire jump;
    
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    reg [31:0]data;
    
    wire [31:0]imm_ext;
    
    wire [3:0]ALU_control;
    wire [31:0]result;
    wire zero;
    
    wire[31:0] read_data;
    wire[31:0] pc_plus4;
    
    
    reg [31:0]z;
    reg branch_taken;
    wire [31:0] auipc_result;

    assign auipc_result = pc_current + imm_ext;
    assign opcode=instruction[6:0];
    assign rd=instruction[11:7];
    assign funct3=instruction[14:12];
    assign funct7=instruction[31:25];
    assign rs1=instruction[19:15];
    assign rs2=instruction[24:20];
    
    
    assign branch1 = (opcode == 7'b1100111) ? {result[31:1],1'b0} : pc_current+imm_ext;
    
    assign pc_plus4=pc_current+3'd4;
    
    pc p1(clk,reset,pc_current,pc_src,branch1,pc_inter);
    
    instruction_memory im1(pc_current,instruction);
    
    control_unit c1(opcode,Regwrite,Memwrite,ALU_src,Result_src,imm_src,branch,jump,ALU_op);
    
    register_file r1(rs1,rs2,rd,data,Regwrite,read_data1,read_data2,clk);
    
    immediate_generator img1(imm_src,instruction,imm_ext);
    
    alu_decoder a1(opcode,funct3,funct7,ALU_op,ALU_control);
    
    always @(*)
        begin
            case(ALU_src)
                1'b0:z=read_data2;
                1'b1:z=imm_ext;
                default:z=32'bz;
            endcase
        end
    
    alu a2(read_data1,z,ALU_control,result,zero);
    
    data_memory d1(result,clk,Memwrite,read_data,read_data2);
    
    always @(*)
        begin
            case(Result_src)
                3'b000:data=result;
                3'b001:data=read_data;
                3'b010:data=pc_plus4;
                3'b011:data=imm_ext;
                3'b100:data=auipc_result;
                default:data=32'b0;
            endcase
       end
    
    always @(*)
        begin
            branch_taken=1'b0;
            if(branch)
            begin
            case(funct3)
                3'b000:branch_taken=zero;//BEQ
                3'b001:branch_taken=~(zero);//BNE
                3'b100:branch_taken=result[0];//BLT
                3'b101:branch_taken=~result[0];//BGE
                3'b110:branch_taken=result[0];//BLTU
                3'b111:branch_taken=~result[0];//BGEU
                default:branch_taken=1'b0;
            endcase
            end
         end
         
    assign pc_src=jump|branch_taken;
    
    
    
    
endmodule

