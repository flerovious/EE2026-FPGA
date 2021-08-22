`timescale 1ns / 1ps

`include "constants.vh"

module vol_disp_bar(
    input [15:0] bg_col, high_col, med_col, low_col,
    input [3:0] vol_lvl,
    input [6:0] x, y,
    input [6:0] x_mid,
    output reg [15:0] oled_data
    );
    

    wire x_range;
    wire [15:0] v;
    assign x_range = (x >= (x_mid - 10)) && (x <= (x_mid + 10));

    // check value at each level
    assign v[0] = 0;
    assign v[1] = (vol_lvl >= 1 && (y <= `LVL1 && y >= `LVL1 - `LVLH));
    assign v[2] = (vol_lvl >= 2 && (y <= `LVL2 && y >= `LVL2 - `LVLH));
    assign v[3] = (vol_lvl >= 3 && (y <= `LVL3 && y >= `LVL3 - `LVLH));
    assign v[4] = (vol_lvl >= 4 && (y <= `LVL4 && y >= `LVL4 - `LVLH));
    assign v[5] = (vol_lvl >= 5 && (y <= `LVL5 && y >= `LVL5 - `LVLH));
    assign v[6] = (vol_lvl >= 6 && (y <= `LVL6 && y >= `LVL6 - `LVLH));
    assign v[7] = (vol_lvl >= 7 && (y <= `LVL7 && y >= `LVL7 - `LVLH));
    assign v[8] = (vol_lvl >= 8 && (y <= `LVL8 && y >= `LVL8 - `LVLH));
    assign v[9] = (vol_lvl >= 9 && (y <= `LVL9 && y >= `LVL9 - `LVLH));
    assign v[10] = (vol_lvl >= 10 && (y <= `LVL10 && y >= `LVL10 - `LVLH));
    assign v[11] = (vol_lvl >= 11 && (y <= `LVL11 && y >= `LVL11 - `LVLH));
    assign v[12] = (vol_lvl >= 12 && (y <= `LVL12 && y >= `LVL12 - `LVLH));
    assign v[13] = (vol_lvl >= 13 && (y <= `LVL13 && y >= `LVL13 - `LVLH));
    assign v[14] = (vol_lvl >= 14 && (y <= `LVL14 && y >= `LVL14 - `LVLH));
    assign v[15] = (vol_lvl >= 15 && (y <= `LVL15 && y >= `LVL15 - 1));
    

    always @ (*) begin

        if (x_range && vol_lvl > 0 && v) begin
            if (v[5:1])
                oled_data = low_col;
            if (v[10:6])
                oled_data = med_col;
            if (v[15:11]) 
                oled_data = high_col; 
        end else 
            oled_data = bg_col;
    end
    
endmodule
