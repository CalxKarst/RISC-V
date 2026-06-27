`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 10:12:00 PM
// Design Name: 
// Module Name: pc_module
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



module pc_module
  (
   input         clk,
   input         rst,
   input         pc_ctrl, // Ctrl for PC selection, in case of normal increment or jump
   input [31:0]  immExt, // Immediate value in case of a jump.
   output reg [31:0] pc_reg,
   output [31:0] pc_plus4
  );

  wire [31:0] pc_next, pc_target;
  wire [31:0] pc_plus4_internal;

  always @ (posedge clk)
    begin
      if (rst)
        pc_reg <= 0;
      else
        pc_reg <= pc_next;
    end

  assign pc_plus4_internal = pc_reg + 32'd4;
  assign pc_target = pc_reg + immExt;
  assign pc_next = (pc_ctrl) ? pc_target : pc_plus4_internal;
  assign pc_plus4 = pc_plus4_internal;
  
endmodule
