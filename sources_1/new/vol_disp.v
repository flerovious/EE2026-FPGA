`timescale 1ns / 1ps

module vol_disp (
    input [13:0] sw,
    input clk,
    input clk100m,
    input [3:0] vol_lvl,
    input [6:0] x,y,
    input btnC, btnL, btnR,
    output [15:0] oled_data
    );
    
    wire [1:0] bor_wid;
    wire [15:0] oled_vol_data, oled_bor_data;
    wire [15:0] bor_col, bg_col, high_col, med_col, low_col;
    
    // Border width using switches
    assign bor_wid = sw[1] ? 0 : (sw[0] ? 3 : 1);
    
    // Freezing screen
    reg [3:0] pause_lvl = 0;
    reg [6:0] x_mid = 48;

    always @ (posedge clk) begin
        if (btnR) x_mid = 72;
        if (btnC) x_mid = 48;
        if (btnL) x_mid = 24;
        pause_lvl = sw[3] ? pause_lvl : vol_lvl;
    end
    
    // vol display components
    vol_disp_col vdc0(sw[13:0], clk100m,  bor_col, bg_col, high_col, med_col, low_col);
    vol_disp_bor vdc1(bor_col, bg_col, bor_wid, x, y, oled_bor_data);
    vol_disp_bar vdc2(bg_col, high_col, med_col, low_col, pause_lvl, x, y, x_mid, oled_vol_data);
    vol_disp_ctl vdc3(x, y, oled_bor_data, oled_vol_data, oled_data);

endmodule