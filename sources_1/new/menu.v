`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2021 13:08:16
// Design Name: 
// Module Name: menu
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

module menu(
    input clk, btnU, btnD,
    input [4:0] sw,
    input [6:0] x, y,
    output reg [15:0] oled_data,
    output reg [2:0] state = 0
//    output reg [15:0] oled_data
//    output reg [2:0] state
    );
    
    wire boxwidth, box1, box2, box3, box4;
    wire arrow1, arrow2, arrow3, arrow4;
    wire [15:0] menu_disp [4:0];
    
    wire menu_length;
    wire [6:0] mode0;
    wire menubar, mode1, mode2, mode3, mode4;
    
    assign mode1 = (y >= 22 && y <= 26) && (x == 12 || x == 16) || (x == 13 && y == 27) ||                         // V
                   (x == 14 && y == 28) || (x == 15 && y == 27) ||                                                 // V
                   (y >= 22 && y <= 28) && (x == 20 || x == 24) || (x >= 21 && x <= 23) && (y == 22 || y == 28) || // O
                   (y >= 22 && y <= 28) && (x == 28) || (x >= 29 && x <= 32) && (y == 28) ||                       // L
                   (y >= 22 && y <= 28) && (x == 36 || x == 40) || (x >= 37 && x <= 39) && (y == 28) ||            // U
                   (y >= 22 && y <= 28) && (x == 44 || x == 48) || (y == 23 || y == 24) && (x == 45 || x == 47) || // M
                   (x == 46 && y == 25) ||                                                                         // M
                   (x == 52) && (y >= 22 && y <= 28) || (x >= 53 && x <= 56) && (y == 22 || y == 25 || y == 28);   // E
    
    assign mode2 = (x == 12) && (y >= 32 && y <= 38) || (x >= 12 && x <=16) && (y == 32) || 
                   (x == 16) && (y == 32 || y == 33 || y == 37 || y == 38) || (x == 15 && (y == 34 || y == 36)) ||
                   (x >= 12 && x <= 14) && (y == 35) || 
                   (x == 20) && (y >= 32 && y <= 38) || (x >= 21 && x <= 24) && (y == 32 || y == 35 || y == 38) ||//E
                   (x == 28 || x == 32) && (y >= 34 && y <= 38) || (x == 29 || x == 31) && (y == 33 || y == 34) ||
                   (x == 30) && (y == 32 || y == 33) || (x >= 28 && x <= 32) && (y == 36) ||
                   (x == 37) && (y >= 32 && y <= 38) || (x >=38 && x <= 40) && (y == 32 || y == 38) || // C
                   (x >= 44 && x <= 48 && y == 32) || (x == 46 && y >=33 && y <= 38);
    
    assign mode3 = (x == 12) && (y >= 42 && y <= 45) || (x >= 12 && x <= 16) && (y == 45) ||	// 4
                  (x == 15) && (y >= 42 && y <= 48) ||                                            // 4
                  (x >= 28 && x <= 32) && (y == 42 || y == 45 || y == 48) ||                    // S
                  (x == 28) && (y >= 42 && y <= 45) || (x == 32) && (y >= 45 && y <= 48) ||    // S
                  (x == 36) && (y >= 42 && y <= 48) || (x >= 36 && x <= 40) && (y == 42 || y == 45 || y == 48) ||    // E
                  (x == 44 || x == 48) && (y >= 44 && y <= 48) || (x == 45 || x == 47) && (y == 43 || y == 44) ||    // A
                  (x == 46) && (y == 42 || y == 43) || (x >= 44 && x <= 48) && (y == 46) ||                            // A
                  (x >= 52 && x <= 56) && (y == 42 || y == 45 || y == 48) || (x == 52) && (y >= 42 && y <= 45) ||        // S
                  (x == 56) && (y >= 45 && y <= 48) ||                                                                    // S
                  (x == 60 || x == 64) && (y >= 42 && y <= 48) || (x >= 60 && x <= 64) && (y == 42 || y == 48) ||         // O
                  (x == 68 || x == 72) && (y >= 42 && y <= 48) || (x == 69) && (y == 44) || (x == 70) && (y == 45) ||    // N
                  (x == 71 && y == 46) ||                                                                                // N
                  (x >= 76 && x <= 80) && (y == 42 || y == 45 || y == 48) || (x == 76) && (y >= 42 && y <= 45) ||        // S
                  (x == 80) && (y >= 45 && y <= 48);                                          // A
 
//    assign mode4 = (y == 52 && x >=12 && x <= 16) || (x == 14 && y >=53 && y <= 58) || //T
//                   (x == 28 || x == 32) && (y >= 54 && y <= 58) || (x == 29 || x == 31) && (y == 53 || y == 54) ||  // A
//                   (x == 30) && (y == 52 || y == 53) || (x >= 28 && x <= 32) && (y == 56) ||        // A
//                   (x == 20 && y >=52 && y <=58) || (y == 52 || y == 55 || y == 58) && (x >= 21 & x <= 24) || //E
//                   (x == 36 || x == 40) && (y >= 52 && y <= 58) || (y == 53 || y == 54 ) && (x == 37 || x == 39) || (y == 55 && x ==38) ; //M
    assign mode4 = (x == 12 || x == 16) && (y >= 52 && y <= 58) || (x == 13 || x == 15) && (y == 53 || y == 54) || // M
                   (x == 14 && y == 55) ||                                                                         // M
                   (x == 20 && y >=52 && y <=58) || (y == 52 || y == 55 || y == 58) && (x >= 21 & x <= 24) || //E
                   (x == 28 || x == 32) && (y >= 52 && y <= 58) || (x == 29 || x == 31) && (y == 53 || y == 54) || // M
                   (x == 30 && y == 55) ||                                                                          // M
                   (x == 36 && y >=52 && y <=58) || (y == 52 || y == 55 || y == 58) && (x >= 36 & x <= 40); //E
    
    assign arrow1 = (((y >= 23 && y <= 27) && x == 3) || (x == 4 && (y == 23 || y == 27))  || (x == 5 && (y == 24 || y == 26)) || (x == 6 && y == 25));
    assign arrow2 = (((y >= 33 && y <= 37) && x == 3) || (x == 4 && (y == 33 || y == 37))  || (x == 5 && (y == 34 || y == 36)) || (x == 6 && y == 35));
    assign arrow3 = (((y >= 43 && y <= 47) && x == 3) || (x == 4 && (y == 43 || y == 47))  || (x == 5 && (y == 44 || y == 46)) || (x == 6 && y == 45));
    assign arrow4 = (((y >= 53 && y <= 57) && x == 3) || (x == 4 && (y == 53 || y == 57))  || (x == 5 && (y == 54 || y == 56)) || (x == 6 && y == 55));
        
    assign boxwidth = (x >= 0 && x <= 95);
    assign box1 = (y >= 21 && y <= 29) && boxwidth && ~mode1 && ~arrow1;
    assign box2 = (y >= 31 && y <= 39) && boxwidth && ~mode2 && ~arrow2;
    assign box3 = (y >= 41 && y <= 49) && boxwidth && ~mode3 && ~arrow3;
    assign box4 = (y >= 51 && y <= 59) && boxwidth && ~mode4 && ~arrow4;
    
    assign menubar = ((mode0[4:0] && menu_length)
    || ((x == 28 && (y == 5 || y == 6)) || (x == 29 && (y == 6 || y == 7)) || (x == 30 && (y == 7 || y == 8)) || (x == 31 && (y == 8 || y == 9)) || ((x == 32 || x == 33) && (y == 9 || y == 10)))
    || (x == 34 && (y == 8 || y == 9)) || (x == 35 && (y == 7 || y == 8)) || (x == 36 && (y == 6 || y == 7)) || (x == 37 && (y == 5 || y == 6)) // M
    || ((x >= 44 && x <= 49) && (y == 3 || y == 4 || y == 9 || y == 10 || y == 15 || y == 16)) // E
    || ((x == 53 && (y == 6 || y == 7)) || (x == 54 && (y == 7 || y == 8)) || (x == 55 && (y == 8 || y == 9)) || (x == 56 && (y == 9 || y == 10)) || (x == 57 && (y == 10 || y == 11)) || (x == 58 && (y == 11 || y == 12))) // N
    || ((mode0[6:5] && (y >= 3 && y <= 14)) || ((x >= 66 && x <= 69) && (y == 15 || y == 16)))); // U 
    
    assign menu_length = (y >= 3 && y <= 16);
    assign mode0[0] = (x == 26 || x == 27);
    assign mode0[1] = (x == 38 || x == 39);
    assign mode0[2] = (x == 42 || x == 43);
    assign mode0[3] = (x == 52 || x == 53);
    assign mode0[4] = (x == 60 || x == 61);
    assign mode0[5] = (x == 64 || x == 65);
    assign mode0[6] = (x == 70 || x == 71);
    
    //MENU display for respective states
    assign menu_disp[0] = (menubar || mode1 || mode2 || mode3 || mode4);
    assign menu_disp[1] = (menubar || box1 || mode2 || mode3 || mode4);
    assign menu_disp[2] = (menubar || mode1 || box2 || mode3 || mode4); 
    assign menu_disp[3] = (menubar || mode1 || mode2 || box3 || mode4); 
    assign menu_disp[4] = (menubar || mode1 || mode2 || mode3 || box4); 
    
    always @ (posedge clk) begin
        if (btnU) begin
            if (state) state <= state - 1;
            else state <= 4;
        end
        else if (btnD) begin
            if (state == 4) state <= 1;
            else state <= state + 1;
        end
    end
    
    always @ (*) begin
        case(sw)
            5'b00001:
                oled_data = menu_disp[state] ? `BLACK : `WHITE;
            5'b00000:
                oled_data = menu_disp[state] ? `WHITE : `BLACK; 
            
            5'b00011:
                oled_data = menu_disp[state] ? `BLACK : `YELLOW;
            5'b00010:
                oled_data = menu_disp[state] ? `YELLOW : `BLACK; 
            
            5'b00111:
                oled_data = menu_disp[state] ? `BLACK : `PINK;
            5'b00100:
                oled_data = menu_disp[state] ? `PINK : `BLACK; 
            
            5'b01111:
                oled_data = menu_disp[state] ? `RED : `WHITE;
            5'b01000:
                oled_data = menu_disp[state] ? `WHITE : `BLACK; 
            
            5'b11111:
                oled_data = menu_disp[state] ? `WHITE : `BLUE;
            5'b10000:
                oled_data = menu_disp[state] ? `BLUE : `WHITE; 
        endcase
    end 
    
endmodule
