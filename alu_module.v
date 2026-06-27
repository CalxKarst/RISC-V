`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 11:49:18 PM
// Design Name: 
// Module Name: alu_module
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


module alu_module(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] alu_mode,
    
    output [31:0] alu_result,
    output alu_zero_flag
);
    localparam alu_add = 0, alu_sub = 1, alu_slt = 5, alu_or = 3, alu_and = 2;
    reg [31:0] alu_result_reg;
    
    always @ (*) begin
        case (alu_mode)
            alu_add :
                alu_result_reg <= srcA + srcB;
            alu_sub :
                alu_result_reg <= srcA - srcB;
            alu_slt :
                alu_result_reg <= (srcA < srcB) ? 1 : 0;
            alu_or :
                alu_result_reg <= srcA | srcB;
            alu_and :
                alu_result_reg <= srcA & srcB;
            default :
                alu_result_reg <= srcA + srcB;
        endcase
    end
    
    assign alu_result = alu_result_reg;
    assign alu_zero_flag = (alu_result_reg == 0) ? 1 : 0;

endmodule
