`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 08:18:55 PM
// Design Name: 
// Module Name: my_initial
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


module my_initial(
    input CLOCK, btnU, btnD, [15:0] sw,
output reg [7:0] seg, reg [2:0] name
);

wire slow_clk, Q1, Q2;
reg pushbutton;

clk_divider dut0(CLOCK, slow_clk);
my_dff dut1(slow_clk, pushbutton, Q1);
my_dff dut2(slow_clk, Q1, Q2);

wire PULSE;
assign PULSE = Q1 & ~Q2;
        
always @(posedge slow_clk) begin
    if (sw[0] == 1 && sw[7] == 1 && sw[10] == 0) begin //If Volume Mode is ON and Game Mode is OFF
        if (btnU == 1 || btnD == 1) //btnU & btnD
            pushbutton = 1;
        else
            pushbutton = 0;
        
        if (PULSE == 1 && btnU == 1) //Forward cycle
            name <= (name + 1) % 5;
        else if (PULSE == 1 && btnD == 1) //Reverse cycle
            name <= (name + 3'd4) % 5;
    end
        
    else //Reset to default
        name = 0;
end
    
always @ (name) begin
    case (name)
        2'b000: seg = 8'b1000_1000; //A
        2'b001: seg = 8'b1000_0011; //B
        2'b010: seg = 8'b1100_0110; //C
        2'b011: seg = 8'b1010_0001; //D
        3'b100: seg = 8'b1000_0110; //E
    endcase
    end
endmodule
