////////////////////////////////////////////////////
////////////////      CONSTANTS      ///////////////
////////////////////////////////////////////////////

// Screen dimmensions
`define WIDTH 96
`define HEIGHT 64

// Colors
`define P_RED 				16'hFC10
`define P_YELLOW			16'hFFF0
`define P_GREEN				16'h87F0
`define P_CYAN				16'h87FF
`define P_BLUE 				16'h041F
`define P_PINK				16'hFC18

`define GREEN 				16'h07E0
`define MAGENTA				16'hF81F
`define BLUE 				16'h001F
`define ORANGE				16'hFC00
`define RED 				16'hF800
`define PINK                16'hF81F
`define YELLOW 				16'hFFE0
`define PURPLE				16'h801F
`define WHITE				16'hFFFF
`define BLACK				16'h0000
`define BROWN				16'h8200
`define L_GRAY				16'hC618
`define D_GRAY				16'h8410

 // To clear AN/SEG
`define CLR_AN  ~4'b0
`define CLR_SEG ~8'b0

 // 7SEG DIGITS
 `define DIG0    7'b1000000
 `define DIG1    7'b1111001
 `define DIG2    7'b0100100
 `define DIG3    7'b0110000
 `define DIG4    7'b0011001
 `define DIG5    7'b0010010
 `define DIG6    7'b0000010
 `define DIG7    7'b1111000
 `define DIG8    7'b0000000
 `define DIG9    7'b0010000   


// ////////////////////////////////////////////////////
// ////////////////      VOL BAR      ////////////////
// //////////////////////////////////////////////////

 // Vol Bar Levels
 `define LVLD 4
 `define LVLH 2
 `define LVL1 60
 `define LVL2 (`LVL1 - `LVLD)
 `define LVL3 (`LVL2 - `LVLD)
 `define LVL4 (`LVL3 - `LVLD)
 `define LVL5 (`LVL4 - `LVLD)
 `define LVL6 (`LVL5 - `LVLD)
 `define LVL7 (`LVL6 - `LVLD)
 `define LVL8 (`LVL7 - `LVLD)
 `define LVL9 (`LVL8 - `LVLD)
 `define LVL10 (`LVL9 - `LVLD)
 `define LVL11 (`LVL10 - `LVLD)
 `define LVL12 (`LVL11 - `LVLD)
 `define LVL13 (`LVL12 - `LVLD)
 `define LVL14 (`LVL13 - `LVLD)
 `define LVL15 (`LVL14 - `LVLD)