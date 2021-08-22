`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 16:06:33
// Design Name: 
// Module Name: clk_variable
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


module clk_variable(
    input clk_base,
    input [31:0] m,
    output reg clk_slow = 0
    );
    
    reg [31:0] counter = 0;
    
    always @ (posedge clk_base)
    begin
        counter <= (counter == m) ? 0 : counter + 1;
        clk_slow <= (counter == 0) ? ~clk_slow : clk_slow;
    end
    
endmodule
