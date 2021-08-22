`timescale 1ns / 1ps

`include "constants.vh"

module vol_disp_bor(
    input [15:0] bor_col, bg_col,
    input [1:0] bor_wid,
    input [6:0] x, y,
    output [15:0] oled_data
    );
    
    // If border on, assign border colour
    assign oled_data = (bor_wid && (x <= bor_wid - 1 || x >= (`WIDTH - bor_wid) || y <= bor_wid - 1|| y >= (`HEIGHT - bor_wid))) ?
                            bor_col : bg_col;
endmodule
