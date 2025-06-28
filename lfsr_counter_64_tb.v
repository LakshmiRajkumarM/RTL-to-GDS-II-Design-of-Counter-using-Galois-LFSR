//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2025 19:27:16
// Design Name: 
// Module Name: lfsr_tb
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


/*module lfsr_tb();
reg cnt,nrst;
reg clk=1;
wire next,q0,q1,q2,q3,q4,q5;
wire [5:0]count;

lfsr dut(.cnt(cnt),.clk(clk),.nrst(nrst),.next(next),.q0(q0),.q1(q1),.q2(q2),.q3(q3),.q4(q4),.q5(q5),.count(count));

initial
begin
forever #5 clk=~clk;
end

initial
begin
nrst=1'b1;cnt=0;
#5 nrst=1'b0;cnt=1;
#2000 nrst=1'b0;
#10 $stop;
end
endmodule*/
`timescale 1ns / 1ps

module top_tb;
    // Testbench Signals
    reg clk = 0;        // Start from 0 to avoid potential unknown states
    reg rst;
    reg count;
    wire [63:0] Q;
    
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
        #100 count = 0;
        #50 $stop;
    end
    
    initial begin
        $monitor($time, " rst=%b, count=%b, Q=%h", rst, count, Q);
    end
endmodule

