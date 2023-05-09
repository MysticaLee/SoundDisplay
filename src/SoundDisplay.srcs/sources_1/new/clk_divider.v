`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:22:22 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input CLOCK,
    output reg OUTCLOCK
    );

    reg [17:0] COUNT = 0;  

    always @ (posedge CLOCK)
    begin
    COUNT <= COUNT + 1;
    OUTCLOCK <= (COUNT == 0) ? 1 : 0;
    end

endmodule
