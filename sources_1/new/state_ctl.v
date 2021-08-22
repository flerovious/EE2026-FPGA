`timescale 1ns / 1ps

`include "constants.vh"

module state_ctl(
    input clk,
    input [2:0] state,
    input [3:0] an_vol, react_an,
    input [7:0] seg_vol, react_seg,
    input [15:0] oled_menu, oled_vol, led_vol, oled_react, oled_season, oled_rainbow, oled_frog,
    output reg [3:0] an,
    output reg [7:0] seg,
    output reg [15:0] oled_data, led
    );
    always @ (posedge clk) begin
        case (state)
        // Menu
        0: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= oled_menu;
        end
        // Peak detector
        1: begin
            led <= led_vol;
            an <= an_vol;
            seg <= seg_vol;
            oled_data <= oled_vol;
        end
         // REACT
         2: begin
             led <= 0;
             an <= react_an;
             seg <= react_seg;
             oled_data <= oled_react;
         end
         // 4 SEASONS
         3: begin
             led <= 0;
             an <= `CLR_AN;
             seg <= `CLR_SEG;
             oled_data <= oled_season;
         end
        // MEME
         4: begin
             led <= 0;
             an <= `CLR_AN;
             seg <= `CLR_SEG;
             oled_data <= oled_frog;
         end
        
        // SCREEN SAVER MODE
        5: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= oled_rainbow;
        end
        
        // POWER SAVING MODE (SCREEN OFF)
        6: begin
            led <= 0;
            an <= `CLR_AN;
            seg <= `CLR_SEG;
            oled_data <= `BLACK;
        end
        endcase
    end
            
endmodule
