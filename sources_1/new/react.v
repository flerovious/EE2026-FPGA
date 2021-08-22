`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2021 10:17:41
// Design Name: 
// Module Name: react
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
`include "constants.vh"

module react(
    input clk50, clk381, btnU, btnL, btnR, btnD, btnC,
    input [3:0] vol_lvl,
    input [2:0] state,
    input [11:0] mic_in, 
    input [13:0] pixel_index,
    output [15:0] oled_react,
    output [3:0] react_an,
    output [7:0] react_seg
    );
    
    reg [13:0] pts = 0;
    reg [31:0] current_time = 0, prev_time = 0, target_time = 100;
    reg [1:0] game_state = 0;
    reg [1:0] color = 0;
    
    reg [15:0] react_pause [6143:0];
    reg [15:0] react_win [6143:0];
    reg [15:0] react_start [6143:0];
    
    initial begin
        $readmemh("react_pause.mem", react_pause);
        $readmemh("react_win.mem", react_win);
        $readmemh("react_start.mem", react_start);
    end
    
    always @ (posedge clk50) begin
        case(game_state)
        0: begin
            // display start
            if ((state == 2) && (btnL || btnU || btnR)) begin
                game_state = 1;
                pts <= 0;
                current_time <= 0;
                prev_time <= 0;
                target_time <= 100;
            end
        end
        1: begin
            if (btnD) game_state = 3;
            current_time <= current_time + 1;
            if (color && (current_time - prev_time)%25 == 0) pts <= (pts > 0) ? pts - 1 : 0;
            case(color)
                0: begin
                    if (btnL) pts <= (pts > 0) ? pts - 1 : 0;
                    else if (btnU) pts <= (pts > 2) ? pts - 3 : 0;
                    else if (btnR) pts <= (pts > 4) ? pts - 5 : 0;
                    if (current_time >= target_time) begin
                        color <= current_time % 4;
                        prev_time <= current_time;
                    end 
                end
                
                1: begin
                    if (btnL) begin
                        pts <= pts + 2;
                        target_time <= current_time + current_time % 4 * 50 + current_time % 25 + vol_lvl * 7;
                        color <= 0;
                    end
                    else if (btnU) pts <= (pts > 2) ? pts - 3 : 0;
                    else if (btnR) pts <= (pts > 4) ? pts - 5 : 0;
                end
                
                2: begin
                    if (btnL) pts <= (pts > 1) ? pts - 2 : 0;
                    else if (btnU) begin
                        pts <=  pts + 6;
                        target_time <= current_time + current_time % 4 * 50 + current_time % 25 + vol_lvl * 7;
                        color <= 0;
                    end
                    else if (btnR) pts <= (pts > 11) ? pts - 12 : 0;
                end 
                
                3: begin
                    if (btnL) pts <= (pts > 2) ? pts - 3 : 0;
                    else if (btnU) pts <= (pts > 8) ? pts - 9: 0;
                    else if (btnR) begin
                        pts <= pts + 15;
                        target_time <= current_time + current_time % 4 * 50 + current_time % 25 + vol_lvl * 7;
                        color <= 0;
                    end
                end 
            endcase
            if (pts >= 2026) game_state <= 2;
        end
        2: begin
            // display win
            if (btnL || btnU || btnR || btnD) game_state = 0;
        end
        3: begin
            // display paused
            if (btnL || btnU || btnR || btnD) game_state <= 1;
        end
        endcase

    end
    assign oled_react = (game_state == 0) ? react_start[pixel_index]: 
                        (game_state == 1) ? ((color[0]) ? (color[1] ? `RED : `GREEN) : (color[1] ? `YELLOW : `P_BLUE)) :
                        (game_state == 2) ? react_win[pixel_index]:
                        react_pause[pixel_index];
    react_pts rp0(.seg_clk(clk381),.pts(pts),.an(react_an),.seg(react_seg));
    
endmodule
