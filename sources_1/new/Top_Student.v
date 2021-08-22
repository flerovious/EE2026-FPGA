`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY: MONDAY P.M
//
//  STUDENT A NAME: SUN JIALE
//  STUDENT A MATRICULATION NUMBER: A0226567W
//
//  STUDENT B NAME: SWAMINATHAN VARUN
//  STUDENT B MATRICULATION NUMBER: A0214565E
//
//////////////////////////////////////////////////////////////////////////////////
`include "constants.vh"

module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input CLK100MHZ,
    input [15:0] sw,
    input btnC, btnU, btnL, btnR, btnD,
    output [15:0] led,
    output [7:0] JC, seg,
    output [3:0] an
    );
    
    // Clocks, buttons,states
    wire clk6p25m, clk20k, clk381, clk50, clk10, clk5, clk1;
    wire bC, bU, bL, bR, bD, reset; 
    wire [2:0] state;

    // Unused Oled_Display wires
    wire frame_begin, sending_pixels, sample_pixel;
    wire [4:0] teststate;

    // Volume data from Audio_capture
    wire [11:0] mic_in;
    wire [3:0] vol_lvl; 

    // Pixel_index from Oled_Display
    wire [12:0] pixel_index;
    wire [6:0] x,y;

    // Wires to store data from various modules
    wire [15:0] oled_data, oled_menu, oled_vol;
    wire [15:0] led_vol;
    wire [3:0] an_vol;
    wire [7:0] seg_vol;

    // Clocks
    clk_variable c0(CLK100MHZ, 7, clk6p25m); // 6.25 MHz -> OLED clk
    clk_variable c1(CLK100MHZ, 2499, clk20k); // 20 kHz  -> OLED sample
    clk_variable c2(CLK100MHZ, 13122, clk381); // 381 Hz -> 7 SEG
    clk_variable c3(CLK100MHZ, 999999, clk50); // 50 Hz  -> btnX
    clk_variable c4(CLK100MHZ, 9999999, clk5); // 5 Hz  -> peak_volume
    clk_variable c5(CLK100MHZ, 49999999,clk1); // 1 Hz -> screen saver mode
    clk_variable c6(CLK100MHZ, 2499999, clk10); // 20 Hz, not 10 Hz (too lazy to change all again) -> frog
    
    
    // Buttons
    single_pulse sp0 (btnC, clk6p25m, reset); // To change to be menu button
    single_pulse sp1 (btnC, clk50, bC);
    single_pulse sp2 (btnU, clk50, bU);
    single_pulse sp3 (btnL, clk50, bL);
    single_pulse sp4 (btnR, clk50, bR);
    single_pulse sp5 (btnD, clk50, bD);

    // Audio Capture
    Audio_Capture ac0(
        .CLK(CLK100MHZ),             // 100MHz clock
        .cs(clk20k),                // sampling clock, 20kHz
        .MISO(J_MIC3_Pin3),          // J_MIC3_Pin3, serial mic input
        .clk_samp(J_MIC3_Pin1),      // J_MIC3_Pin1
        .sclk(J_MIC3_Pin4),          // J_MIC3_Pin4, MIC3 serial clock
        .sample(mic_in)              // 12-bit audio sample data
    );
    
    // OLED Display
    Oled_Display od0 (.clk(clk6p25m), .reset(reset), .pixel_data(oled_data), .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index), 
        .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), 
        .pmoden(JC[7]), .teststate(teststate));
    assign JC[2] = 0;

    // convert pixel_index to (x, y) coordinate system
    pi2XY xy0(pixel_index, x, y);
    
    // MENU
    wire [2:0] menu_state;
    menu m0(.x(x), .y(y), .clk(clk50), .btnU(bU), . btnD(bD), .sw(sw[4:0]), .oled_data(oled_menu), .state(menu_state));
    menu_ctl mc0(.clk(clk50), .btnC(bC), .btnL(bL), .btnR(bR), .menu_state(menu_state), .state(state));
    
    // PEAK DETECTOR
    peak_volume pv0(.fastclock(clk20k), .slowclock(clk381), .switch(sw[0]), .switch2(sw[1]),
                    .audio_input(mic_in), .led_output(led_vol), .anode_output(an_vol), 
                    .segment_output(seg_vol), .number(vol_lvl));

    vol_disp vd0(sw[15:2], clk20k, CLK100MHZ, vol_lvl, x, y, bU, bL, bR, oled_vol);
    
    wire [15:0] oled_react, oled_season, oled_rainbow, oled_frog;
    wire [3:0] react_an;
    wire [7:0] react_seg;
    react r0(.clk50(clk50), .clk381(clk381), .btnU(bU), .oled_react(oled_react), 
             .mic_in(mic_in), .vol_lvl(vol_lvl), .react_an(react_an), .btnL(bL), .btnR(bR),
             .react_seg(react_seg), .pixel_index(pixel_index), .btnD(bD), .btnC(bC), .state(state));
    
    // FOUR SEASONS
    four_seasons fs0(
                 .clk(clk6p25m),
                 .pixel_index(pixel_index),
                 .oled_season(oled_season),
                 .number(vol_lvl)
                 );
    // RAINBOW
    rainbow rb0(.clk1(clk1), .pixel_index(pixel_index), .oled_rainbow(oled_rainbow));
    
    // FROG
    frog f0(.clk10(clk10),.pixel_index(pixel_index),.oled_frog(oled_frog));
    // 0: menu, 1: peak detector & bar, 2: react, 3: 4 seasons, 4: memes, 5: screen-saver, 6: power-saving
    state_ctl sc0(.clk(CLK100MHZ), .state(state), .an_vol(an_vol), .seg_vol(seg_vol),
                  .oled_menu(oled_menu), .oled_vol(oled_vol), .led_vol(led_vol), .oled_react(oled_react), 
                  .an(an), .seg(seg), .oled_data(oled_data), .led(led), .react_an(react_an),
                  .react_seg(react_seg), .oled_season(oled_season), .oled_rainbow(oled_rainbow),
                  .oled_frog(oled_frog));

endmodule