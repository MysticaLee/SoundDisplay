`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 05:53:54 PM
// Design Name: 
// Module Name: slowerclock
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


module slowerclock(
    input CLOCK,
    output reg Z
    );
    reg [15:0] COUNT;  
        
    always @ (posedge CLOCK) begin
         COUNT <= COUNT + 1;
         Z <= (COUNT == 0) ? ~Z : Z;
     end
        
endmodule
