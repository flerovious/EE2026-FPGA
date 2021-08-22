`timescale 1ns / 1ps

`include "constants.vh"

module seg_score(
    input clk,
    input [6:0] score,
    output reg [6:0] seg_lhs, seg_rhs
    );
    wire [3:0] lhs, rhs;
    assign lhs = score % 10;
    assign rhs = score / 10;
    
    always @ (posedge clk) begin
        case (lhs)
        4'd0: seg_lhs <= `DIG0;
        4'd1: seg_lhs <= `DIG1;
        4'd2: seg_lhs <= `DIG2;
        4'd3: seg_lhs <= `DIG3;
        4'd4: seg_lhs <= `DIG4;
        4'd5: seg_lhs <= `DIG5;
        4'd6: seg_lhs <= `DIG6;
        4'd7: seg_lhs <= `DIG7;
        4'd8: seg_lhs <= `DIG8;
        4'd9: seg_lhs <= `DIG9;
        endcase

        case (rhs)
        4'd0: seg_rhs <= `DIG0;
        4'd1: seg_rhs <= `DIG1;
        4'd2: seg_rhs <= `DIG2;
        4'd3: seg_rhs <= `DIG3;
        4'd4: seg_rhs <= `DIG4;
        4'd5: seg_rhs <= `DIG5;
        4'd6: seg_rhs <= `DIG6;
        4'd7: seg_rhs <= `DIG7;
        4'd8: seg_rhs <= `DIG8;
        4'd9: seg_rhs <= `DIG9;
        endcase
    end
    
endmodule
