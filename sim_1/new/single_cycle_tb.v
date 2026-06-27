`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2026 12:42:55 AM
// Design Name: 
// Module Name: single_cycle_tb
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


module single_cycle_tb();

    reg clk = 0, rst = 0;
    wire [31:0] instr_curr = 32'h0062e233;
    wire [31:0] pc_out;
    
    single_cycle_top dut (
        .clk(clk),
        .rst(rst),
        .instr(instr_curr),
        
        .pc_out(pc_out)
    );
    
    always #10 clk <= ~clk;
    
    initial begin
        rst <= 1;
        repeat (10) @ (posedge clk);
        rst <= 0;
        repeat (100000) @ (posedge clk);
    end

endmodule
