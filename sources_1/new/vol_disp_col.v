`timescale 1ns / 1ps

`include "constants.vh"

module vol_disp_col(
    input [13:0] sw,
    input clk100m,
    output reg [15:0] bor_col, bg_col, high_col, med_col, low_col
    );
    always @ (posedge clk100m) begin
        if (sw[2]) begin   // sw[2] -> remove bar
            high_col = `BLACK;
            med_col = `BLACK;
            low_col = `BLACK;
            end
            
        else if (sw[9]) begin // colorblind friendly color scheme
            high_col = `BLUE;
            med_col = `ORANGE;
            low_col = `D_GRAY;
            end 
            
        else if (sw[10]) begin 
            high_col = `RED;
            med_col = `MAGENTA;
            low_col = `PINK;
            end 
            
        else if (sw[11]) begin
            high_col = `RED;
            med_col = `ORANGE;
            low_col = `YELLOW;
            end 
            
        else if (sw[12]) begin
            high_col = `GREEN;
            med_col = `YELLOW;
            low_col = `RED;
            end 
            
        else begin
            high_col = `RED;
            med_col = `YELLOW;
            low_col = `GREEN;
            end 

        // inverting color of background    
        if (!sw[13]) begin 
            bor_col = `WHITE;
            bg_col = `BLACK;
            end
        else begin
            bor_col = `BLACK;
            bg_col = `WHITE;
            end
        
        // choose border color
        if (sw[4]) bor_col = `RED;
        else if (sw[5]) bor_col = `GREEN;
        else if (sw[6]) bor_col = `BLUE;
        else if (sw[7]) bor_col = `D_GRAY;
        else if (sw[8]) bor_col = `ORANGE;
    end
       
endmodule
