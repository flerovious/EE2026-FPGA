`timescale 1ns / 1ps

module single_pulse(
    input btn,
    input clk,
    output sig
    );
    
    wire q1;
    wire q2;
    
    dff dff0 (clk, btn, q1);
    dff dff1 (clk, q1, q2);
    
    assign sig = q1 & ~q2;
    
endmodule
