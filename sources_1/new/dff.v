`timescale 1ns / 1ps

module dff(
    input DFF_CLOCK, 
    input D,
    output reg Q = 0
    );

    always @ (posedge DFF_CLOCK)
    begin
        Q <= D;
    end
    
endmodule
