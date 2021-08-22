`timescale 1ns / 1ps

`include "constants.vh"

module react_pts(
    input seg_clk,
    input [13:0] pts,
    output reg [3:0] an = `CLR_AN,
    output reg [7:0] seg = `CLR_SEG
    );

    reg [1:0] an_count = 0;
    
    wire [6:0] seg0, seg1, seg2, seg3;

    
//    always @ (posedge grid_clk) begin
//        pa <= reset ? 0 : pa_pt ? pa + 1 : pa;
//        pb <= reset ? 0 : pb_pt ? pb + 1 : pb;
//    end
    react_seg rs0(.seg_clk(seg_clk),.dig(pts%10),.seg(seg0));
    react_seg rs1(.seg_clk(seg_clk),.dig((pts%100)/10),.seg(seg1));
    react_seg rs2(.seg_clk(seg_clk),.dig((pts%1000)/100),.seg(seg2));
    react_seg rs3(.seg_clk(seg_clk),.dig((pts%10000)/1000),.seg(seg3));
    
//    react ss0(seg_clk(seg_clk), pa, seg3, seg2);
//    seg_score ss1(seg_clk, pb, seg1, seg0);
    
    always @ (posedge seg_clk) begin

        an_count <= an_count + 1;
        an <= ~(1 << an_count);
        seg[7] <= 1;
        
        case (an_count)
            0: seg[6:0] <= seg0;
            1: seg[6:0] <= seg1;
            2: seg[6:0] <= seg2;
            3: seg[6:0] <= seg3;
        endcase

    end
endmodule