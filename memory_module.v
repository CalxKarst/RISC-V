`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 10:13:21 PM
// Design Name: 
// Module Name: memory_module
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



module memory_module
  (
   input        clk,
   input [31:0] addr,
   input        write_en,
   input [31:0] write_data,
   output [31:0] read_data
   );

  reg [31:0] mem_block [63:0];

  always @ (posedge clk)
    begin
      if (write_en)
        mem_block[addr[31:2]] <= write_data;
    end

  assign read_data = mem_block[addr[31:2]];
  
endmodule

