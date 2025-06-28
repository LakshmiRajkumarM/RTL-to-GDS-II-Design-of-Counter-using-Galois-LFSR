`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2025 11:03:20
// Design Name: 
// Module Name: lfsr3bit
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
// ////////////////////////////////////////////
module dff(input d,en,clk,rst,output reg q);
always @(posedge clk)begin
if (rst)begin
q=1'b1;
end
else if(en && ~rst)begin
q<=d;
end

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

module lfsr3bit(input cnt,rst,clk,output next,output [2:0]count3bit);
wire q0,q1,q2;
wire rstn,q;
wire w1,w2;
or (rstn,next,rst);
xor(w1,q1,q2);
tff f(cnt,clk,rstn,q);
//dff f3(cnt,1,clk,~rstn,q);
//and(q,rstn,next);
dff f0(q2,cnt,clk,rstn,q0);
dff f1(q0,cnt,clk,rstn,q1);
dff f2(w1,cnt,clk,rstn,q2);


and(w2,q2,q1,q0);
and(next,w2,q);
//and(EN,count,next);
assign count3bit={q2,q1,q0};
endmodule

module Cascaded_Counters (
    input  wire clk,
    input  wire rst,en,
    output reg [4:0] concatenated_out
);
    
    reg [1:0] counter_2bit;
    reg [2:0] counter_3bit;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter_2bit <= 2'b0;
            counter_3bit <= 3'b0;
        end else begin
        if(en)
            counter_2bit <= counter_2bit + 1;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter_3bit <= 3'b0;
        end else
        if(counter_2bit==2'b11 && en) begin
            counter_3bit <= counter_3bit + 1;
        end
    end
    
    always @(*) begin
        concatenated_out = {counter_3bit, counter_2bit};
    end
    
endmodule

module top(input rst,clk,count,output [7:0]Q);
wire [2:0] Q0;
wire [4:0] Q1;
wire next;
lfsr3bit f0(count,rst,clk,next,Q0);
Cascaded_Counters f1(clk,rst,next,Q1);

assign Q={Q1,Q0};
endmodule
