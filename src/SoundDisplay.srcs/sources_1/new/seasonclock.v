`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2020 11:43:49 PM
// Design Name: 
// Module Name: seasonclock
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


module seasonclock(
    input CLOCK,
    output reg Z
    );
        reg [24:0] COUNTER;
    
        always @ (posedge CLOCK) begin  
        COUNTER <= COUNTER + 1;
        Z <= (COUNTER == 0) ? ~Z : Z;
        end
        
endmodule
