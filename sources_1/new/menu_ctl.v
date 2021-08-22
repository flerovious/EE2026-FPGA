`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2021 17:17:35
// Design Name: 
// Module Name: menu_ctl
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


module menu_ctl(
    input clk, btnC, btnL, btnR,
    input [2:0] menu_state,
    output reg [2:0] state = 0
    );
    
    always @ (posedge clk) begin
        if (!state && btnC) state = menu_state;
        else if (!state && btnR) state = 5;
        else if (!state && btnL) state = 6;
        else if (state && btnC) state = 0;
        else if (state == 5 && btnL || state == 6 && btnR) state = 0;
    end
    
endmodule
