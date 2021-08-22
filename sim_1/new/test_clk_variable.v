`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 16:12:51
// Design Name: 
// Module Name: test_clk_variable
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


module test_clk_variable(
    );
    
    reg clk_base = 0;
    wire clk_slow;
    
    always
    begin
        #5 clk_base <= ~clk_base;
    end
    
    clk_variable dut(
                    .clk_base(clk_base),
                    .clk_slow(clk_slow),
                    .m(2499)
                    );
                    
endmodule
