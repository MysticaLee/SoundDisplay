`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 01:28:22 PM
// Design Name: 
// Module Name: clk1p5
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


module clk1p5(
    input CLK,
    output reg Z
);

    reg [25:0] COUNTER;

    always @ (posedge CLK) begin  
    COUNTER <= COUNTER + 1;
    Z <= (COUNTER == 0) ? ~Z : Z;
    end
endmodule
