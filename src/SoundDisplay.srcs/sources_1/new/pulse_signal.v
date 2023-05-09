`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2020 03:21:05 PM
// Design Name: 
// Module Name: pulse_signal
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


module pulse_signal(
    input PUSHBUTTON,
    input CLOCK,
    output PULSE
    );
    
    wire Q1;
    wire Q2;
    wire OUTCLOCK;
    
    clk_divider dut0(CLOCK, OUTCLOCK);
    my_dff dut1(OUTCLOCK, PUSHBUTTON, Q1);
    my_dff dut2(OUTCLOCK, Q1, Q2);
    
    assign PULSE = (Q1 & ~Q2);
    
    
endmodule