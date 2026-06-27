`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2026 12:08:38 AM
// Design Name: 
// Module Name: single_cycle_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module single_cycle_top(
    input clk,
    input rst,
    input [31:0] instr,
    output [31:0] pc_out
);

    wire [31:0] pc_reg, pc_plus4, rs1, rs2, rd, imm_ext, alu_result, write_data, read_data, alu_src_reg;
    wire pc_src, mem_write, alu_src, reg_write;
    wire [2:0] alu_mode;
    wire [1:0] result_src, imm_src;
    
    assign pc_out = pc_reg;
    
    assign rd = (result_src == 0) ? alu_result :
                (result_src == 1) ? read_data :
                (result_src == 2) ? pc_plus4 : alu_result;
    
    assign write_data = rs2;
    assign alu_src_reg = (alu_src == 0) ? rs2 : imm_ext;
    
    pc_module inst0_pc_module (
        .clk(clk),
        .rst(rst),
        .pc_ctrl(pc_src),
        .immExt(imm_ext),
        
        .pc_reg(pc_reg),
        .pc_plus4(pc_plus4)
    );
    
    reg_file inst0_reg_file (
        .clk(clk),
        .addr1(instr[19:15]),
        .addr2(instr[24:20]),
        .addr3(instr[11:7]),
        .writeEn(reg_write),
        .writeData(rd),
        
        .readData1(rs1),
        .readData2(rs2)
    );
    
    extend_module inst0_extend_module (
        .imm_command(instr[31:7]),
        .imm_src(imm_src),
        
        .imm_ext(imm_ext)
    );
    
    memory_module inst0_data_memory_module (
        .clk(clk),
        .addr(alu_result),
        .write_en(mem_write),
        .write_data(write_data),
        
        .read_data(read_data)
    );
    
    alu_module inst0_alu_module (
        .srcA(rs1),
        .srcB(alu_src_reg),
        .alu_mode(alu_mode),
        
        .alu_result(alu_result),
        .alu_zero_flag(alu_zero_flag)
    );
    
    control_module inst0_control_module (
        .op_code(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7(instr[31:25]),
        .alu_zero_flag(alu_zero_flag),
        
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .alu_mode(alu_mode),
        .alu_src(alu_src),
        .imm_src(imm_src),
        .reg_write(reg_write)
    );

endmodule
