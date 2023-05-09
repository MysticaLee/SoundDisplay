`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 05:58:06 PM
// Design Name: 
// Module Name: clk381hz
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


module clk381hz(
    input CLK,
    output reg Z
    );

    reg [17:0] COUNTER;

    always @ (posedge CLK) begin  
        COUNTER <= COUNTER + 1;
        Z <= (COUNTER == 0) ? ~Z : Z;
    end
endmodule
