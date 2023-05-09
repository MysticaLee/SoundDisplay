`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:36:12 PM
// Design Name: 
// Module Name: clk20k
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


module clk20k(
    input CLK,
    output reg Z
    );

    reg [11:0] COUNTER;

    always @ (posedge CLK) begin  
    COUNTER <= COUNTER + 1;
    Z <= (COUNTER == 0) ? ~Z : Z;
    end

endmodule
