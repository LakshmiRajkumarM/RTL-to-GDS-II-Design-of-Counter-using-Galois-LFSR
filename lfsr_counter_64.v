// Code your design here
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 20:20:27
// Design Name: 
// Module Name: lfsr
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

module dff(input d,en,clk,rst,output reg q);
always @(posedge clk)begin
if (rst)begin
q=1'b1;
end
else if(en && ~rst)begin
q<=d;
end
else q<=q;
end
endmodule

module tff(input t,clk,rst,output reg q);
always @(posedge clk)begin
if(rst)
q=1'b0;
else if(t)
q=~q;

end
endmodule

module lfsr(input cnt,nrst,clk,output next,output [5:0]count6bit);
wire q0,q1,q2,q3,q4,q5;
wire rstn,q;
wire w1,w2,w3,w4;
or (rstn,next,nrst);
xor(w1,q4,q5);
tff f(cnt,clk,rstn,q);
//dff f3(cnt,1,clk,~rstn,q);
//and(q,rstn,next);
dff f0(q5,cnt,clk,rstn,q0);
dff f1(q0,cnt,clk,rstn,q1);
dff f2(q1,cnt,clk,rstn,q2);
dff f3(q2,cnt,clk,rstn,q3);
dff f4(q3,cnt,clk,rstn,q4);
dff f5(w1,cnt,clk,rstn,q5);


and(w2,q0,q1,q2);
and(w3,q3,q4,q5);
and(w4,w2,w3);
and(next,w4,q);
//and(EN,count,next);
assign count6bit={q5,q4,q3,q2,q1,q0};
endmodule

module Cascaded_Counters (
    input  wire clk,
    input  wire rst,en,
    output reg [57:0] concatenated_out
);
    
    reg [22:0] counter_23bit;
    reg [34:0] counter_35bit;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter_23bit <= 23'b0;
            counter_35bit <= 35'b0;
        end else begin
        if(en)
            counter_23bit <= counter_23bit + 1;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter_35bit <= 35'b0;
        end else
            if(counter_23bit==23'b11111111111111111111111 && en) begin
            counter_35bit <= counter_35bit + 1;
        end
    end
    
    always @(*) begin
        concatenated_out = {counter_35bit, counter_23bit};
    end
    
endmodule

module top(input rst,clk,count,output [63:0]Q);
wire [5:0] Q0;
wire [57:0] Q1;
wire next;
lfsr f0(count,rst,clk,next,Q0);
Cascaded_Counters f1(clk,rst,next,Q1);

assign Q={Q1,Q0};
endmodule
