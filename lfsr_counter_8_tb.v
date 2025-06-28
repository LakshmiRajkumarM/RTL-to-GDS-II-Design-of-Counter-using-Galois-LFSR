`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2025 11:06:47
// Design Name: 
// Module Name: lfsr_3bit_tb
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


`timescale 1ns / 1ps

module top_tb;
    // Testbench Signals
    reg clk = 0;        // Start from 0 to avoid potential unknown states
    reg rst;
    reg count;
    wire [7:0] Q;
    
    // Instantiate DUT (Device Under Test)
    top uut (
        .rst(rst),
        .clk(clk),
        .count(count),
        .Q(Q)
    );
    
    // Clock Generation (10ns period => 100MHz)
    always #5 clk = ~clk;

    // Test Procedure
    initial begin
        // Apply Reset
        rst = 1; 
        count = 0;
        #20 rst = 0;count = 1;
        #2000 count = 0;
        #50 $stop;
    end
    
    initial begin
        $monitor($time, " rst=%b, count=%b, Q=%h", rst, count, Q);
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule

