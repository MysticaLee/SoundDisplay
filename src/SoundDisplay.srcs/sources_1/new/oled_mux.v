`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2020 10:00:11 AM
// Design Name: 
// Module Name: oled_mux
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


module oled_mux(
input sw10,
input [15:0] pixel_data0,
input [15:0] pixel_data1,

output  [15:0] pixel_data

    );
    
    assign pixel_data [15:0] = (sw10) ? pixel_data1 [15:0] : pixel_data0 [15:0];
endmodule
