`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 10:19:58 PM
// Design Name: 
// Module Name: control_module
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


module control_module(
    input [6:0] op_code, // OP code from the instruction
    input [2:0] funct3,
    input [6:0] funct7,
    input alu_zero_flag, // Zero flag if ALU computes a zero
    
    output pc_src, // Control for Program COunter, to choose between normal increment or jump
    output reg [1:0] result_src, // Control to choose from where to write the result, memory, ALU, or PC.
    output reg mem_write, // Write enable for memory
    output [2:0] alu_mode, // Mode control of ALU
    output reg alu_src, // Controls source 2 of ALU, from register file or immediate
    output reg [1:0] imm_src, // Mode control of Immediate extend
    output reg reg_write // Write enable for Register file
);

    localparam op_lw = 7'b0000011, op_sw = 7'b0100011, op_reg_type = 7'b0110011;
    localparam op_beq = 7'b1100011, op_int_type = 7'b0010011, op_jal = 7'b1101111;
    reg branch_flag, jump_flag;
    reg [1:0] alu_op;
    localparam alu_add = 0, alu_sub = 1, alu_slt = 5, alu_or = 3, alu_and = 2;

    always @ (*) begin
        case (op_code)
            op_lw : begin
                reg_write <= 1; imm_src <= 0; alu_src <= 1; mem_write <= 0; result_src <= 1;
                branch_flag <= 0; alu_op <= 0; jump_flag <= 0;
            end op_sw : begin
                reg_write <= 0; imm_src <= 1; alu_src <= 1; mem_write <= 1; result_src <= 0;
                branch_flag <= 0; alu_op <= 0; jump_flag <= 0;
            end op_reg_type : begin
                reg_write <= 1; imm_src <= 0; alu_src <= 0; mem_write <= 0; result_src <= 0;
                branch_flag <= 0; alu_op <= 2; jump_flag <= 0;
            end op_beq : begin
                reg_write <= 0; imm_src <= 2; alu_src <= 0; mem_write <= 0; result_src <= 0;
                branch_flag <= 1; alu_op <= 1; jump_flag <= 0;
            end op_int_type : begin
                reg_write <= 1; imm_src <= 0; alu_src <= 1; mem_write <= 0; result_src <= 0;
                branch_flag <= 0; alu_op <= 2; jump_flag <= 0;
            end op_jal : begin
                reg_write <= 1; imm_src <= 3; alu_src <= 0; mem_write <= 0; result_src <= 2;
                branch_flag <= 0; alu_op <= 0; jump_flag <= 1;
            end default : begin
                reg_write <= 0; imm_src <= 0; alu_src <= 0; mem_write <= 0; result_src <= 0;
                branch_flag <= 0; alu_op <= 0; jump_flag <= 0;
            end
        endcase
    end
    
    assign pc_src = jump_flag || (branch_flag && alu_zero_flag);
    assign alu_mode = (alu_op == 0) ? alu_add :
                      (alu_op == 1) ? alu_sub :
                      (alu_op == 2) ? (funct3 == 0) ? ((op_code[5] && funct7[5]) ? alu_sub : alu_add) :
                                      (funct3 == 2) ? alu_slt :
                                      (funct3 == 6) ? alu_or :
                                      (funct3 == 7) ? alu_and :
                                      alu_add :
                      alu_add; 
    
endmodule
