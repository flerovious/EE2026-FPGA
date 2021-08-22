`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2021 12:39:29
// Design Name: 
// Module Name: react_seg
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

module react_seg(
    input seg_clk,
    input [3:0] dig,
    output reg [6:0] seg
    );
    
    always @ (posedge seg_clk) begin
        case (dig)
        4'd0: seg <= `DIG0;
        4'd1: seg <= `DIG1;
        4'd2: seg <= `DIG2;
        4'd3: seg <= `DIG3;
        4'd4: seg <= `DIG4;
        4'd5: seg <= `DIG5;
        4'd6: seg <= `DIG6;
        4'd7: seg <= `DIG7;
        4'd8: seg <= `DIG8;
        4'd9: seg <= `DIG9;
        endcase
    end
    
endmodule
