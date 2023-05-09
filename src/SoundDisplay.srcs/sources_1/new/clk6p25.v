`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:03:46 PM
// Design Name: 
// Module Name: clk6p25
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


module clk6p25(
    input CLOCK,
    output reg CLKOUT
    );
    
    reg [3:0] COUNT;
    always @(posedge CLOCK) begin
    COUNT <= COUNT + 1;
    CLKOUT <= (COUNT == 0) ? 1 : 0;
    end
    
 endmodule
