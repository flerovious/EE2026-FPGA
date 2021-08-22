`timescale 1ns / 1ps

`include "constants.vh"

module vol_disp_ctl(
    input [6:0] x,y,
    input [15:0] oled_border, oled_vol,
    output [15:0] oled_data
    );
    
    // If at border, assign border else volume bar
    assign oled_data = (x < 3 || x >= `WIDTH - 3 || y < 3 || y >= `HEIGHT - 3) ? oled_border : oled_vol;
    
endmodule
