`timescale 1ns / 1ps


module frog(
    input clk10,
    input [13:0] pixel_index,
    output [15:0] oled_frog
    );
    
    reg [3:0] state = 0;
    
    // load all the frogs
    reg [15:0] frog_0 [6143:0];
    reg [15:0] frog_1 [6143:0];
    reg [15:0] frog_2 [6143:0];
    reg [15:0] frog_3 [6143:0];
    reg [15:0] frog_4 [6143:0];
    reg [15:0] frog_5 [6143:0];
    reg [15:0] frog_6 [6143:0];
    reg [15:0] frog_7 [6143:0];
    reg [15:0] frog_8 [6143:0];

    initial begin
        $readmemh("frog_0.mem", frog_0);
        $readmemh("frog_1.mem", frog_1);
        $readmemh("frog_2.mem", frog_2);
        $readmemh("frog_3.mem", frog_3);
        $readmemh("frog_4.mem", frog_4);
        $readmemh("frog_5.mem", frog_5);
        $readmemh("frog_6.mem", frog_6);
        $readmemh("frog_7.mem", frog_7);
        $readmemh("frog_8.mem", frog_8);
    end
    
    assign oled_frog = (state == 0) ? frog_0[pixel_index] : 
                       (state == 1) ? frog_1[pixel_index] : 
                       (state == 2) ? frog_2[pixel_index] : 
                       (state == 3) ? frog_3[pixel_index] : 
                       (state == 4) ? frog_4[pixel_index] : 
                       (state == 5) ? frog_5[pixel_index] : 
                       (state == 6) ? frog_6[pixel_index] : 
                       (state == 7) ? frog_7[pixel_index] :     
                       frog_8[pixel_index];                    
     
    always @ (posedge clk10) begin
        state <= (state < 8) ? state + 1 : 0;
    end
    
endmodule