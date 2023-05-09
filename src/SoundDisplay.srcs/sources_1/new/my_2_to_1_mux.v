`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:35:39 PM
// Design Name: 
// Module Name: my_2_to_1_mux
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


module my_2_to_1_mux(
    input sw0, [11:0] sample, [15:0] LED,
    output [15:0] A
);

assign A [15:0] = sw0 ? LED [15:0] : sample [11:0];

endmodule
