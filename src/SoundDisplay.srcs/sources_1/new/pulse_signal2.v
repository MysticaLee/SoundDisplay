`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2020 12:05:17 PM
// Design Name: 
// Module Name: pulse_signal2
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


module pulse_signal2(
    input PUSHBUTTON,
input CLOCK,
output PULSE
);

wire Q1;
wire Q2;
wire OUTCLOCK;


my_dff dut1(CLOCK, PUSHBUTTON, Q1);
my_dff dut2(CLOCK, Q1, Q2);

assign PULSE = (Q1 & ~Q2);

endmodule
