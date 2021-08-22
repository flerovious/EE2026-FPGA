`timescale 1ns / 1ps

`include "constants.vh"

module pi2XY(
    input [12:0] pixel_index,
    output [6:0] x, y
    );
    
    assign x = pixel_index % `WIDTH;
    assign y = pixel_index / `WIDTH;
    
endmodule
