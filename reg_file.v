`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2026 10:10:01 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file
(
 input         clk,
 
 input [4:0]   addr1,
 input [4:0]   addr2,
 output [31:0] readData1,
 output [31:0] readData2,
 
 input [4:0]   addr3,
 input writeEn,
 input [31:0]  writeData
 
);

  reg [31:0] registerFile [31:0];

  assign readData1 = ((addr1 == addr3) && writeEn) ? writeData : registerFile[addr1];
  assign readData2 = ((addr2 == addr3) && writeEn) ? writeData : registerFile[addr2];

  always @ (posedge clk)
    begin
      if (writeEn)
        registerFile[addr3] <= writeData;
    end

  
  
endmodule
