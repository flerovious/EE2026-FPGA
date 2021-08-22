`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2021 22:22:17
// Design Name: 
// Module Name: rainbow
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

module rainbow(
    input clk1,
    input [13:0] pixel_index,
    output [15:0] oled_rainbow
    );

    //96*64-1 = 6144-1 = 6143;
//    reg [15:0] mesh [6143:0];
    reg mesh [6143:0];
    
    initial begin
        $readmemh("mesh.mem", mesh);
    end
    
    reg [2:0] color = 0;
    assign oled_rainbow = (color == 0) ? (mesh[pixel_index] ? `WHITE : `RED):
                          (color == 1) ? (mesh[pixel_index] ? `WHITE : `ORANGE):
                          (color == 2) ? (mesh[pixel_index] ? `WHITE : `YELLOW):
                          (color == 3) ? (mesh[pixel_index] ? `WHITE : `GREEN):
                          (color == 4) ? (mesh[pixel_index] ? `WHITE : `BLUE):
                          (color == 5) ? (mesh[pixel_index] ? `WHITE : `PURPLE):
                          (color == 6) ? (mesh[pixel_index] ? `WHITE : `PINK):
                          (mesh[pixel_index] ? `WHITE : `BLACK);
//    assign oled_rainbow = (!color) ? mesh[pixel_index] : `WHITE;
    
    always @ (posedge clk1) begin
        color <= color + 1;
//        case(color)
//            0: oled_rainbow = mesh[pixel_index];
//        endcase
//        if(count == 0) begin oled_rainbow = Red [96*y+x]; count = 1; end
//        else if(count == 1) begin oled_rainbow = Orange [96*y+x]; count = 2; end
//        else if(count == 2) begin oled_rainbow = Yellow [96*y+x]; count = 3; end
//        else if(count == 3) begin oled_rainbow = Green [96*y+x]; count = 4; end
//        else if(count == 4) begin oled_rainbow = Blue [96*y+x]; count = 5; end
//        else if(count == 5) begin oled_rainbow = Purple [96*y+x]; count = 6; end
//        else if(count == 6) begin oled_rainbow = Pink [96*y+x]; count = 7; end
//        else if(count == 7) begin oled_rainbow = Black [96*y+x]; count = 0; end
    end
endmodule
