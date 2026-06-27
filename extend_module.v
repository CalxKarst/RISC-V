`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 10:14:14 PM
// Design Name: 
// Module Name: extend_module
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



module extend_module 
(
 input [24:0]  imm_command,
 input [1:0]   imm_src, // Immediate mode, 0 - Integer, 1 - Store, 2 - Branch, 3 - Jump
 output [31:0] imm_ext
);

  assign imm_ext = (imm_src == 'b00) ? {{20{imm_command[24]}},imm_command[24:13]} :
                   (imm_src == 'b01) ? {{20{imm_command[24]}},imm_command[24:18],imm_command[4:0]} :
                   (imm_src == 'b10) ? {{20{imm_command[24]}},imm_command[0],imm_command[23:18],imm_command[4:1],1'b0} :
                   (imm_src == 'b11) ? {{12{imm_command[24]}},imm_command[12:5],imm_command[13],imm_command[23:14],1'b0} : 0;
  
endmodule

