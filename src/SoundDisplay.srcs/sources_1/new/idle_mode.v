`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 01:32:44 PM
// Design Name: 
// Module Name: idle_mode
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


module idle_mode(
    input CLOCK,
    input [11:0] Max,
    output reg idle_state = 0,
    output reg [3:0] seasonstate = 4'b0001,
    input btnL,
    input btnR
    );
    
    reg [6:0] idle_counter;
    reg idle_mode = 0;
    wire clk1p5;
    wire seasonclock;
    wire L;
    wire R;
    wire OUTCLOCK;
    clk1p5 dev9 (CLOCK, clk1p5);
    seasonclock dev10 (CLOCK, seasonclock);
    pulse_signal dev1 (btnL, CLOCK, L);
    pulse_signal dev2 (btnR, CLOCK, R);
    
    clk_divider dut0(CLOCK, OUTCLOCK);
    reg [27:0] COUNTER;
    reg [26:0] COUNTER2;
    
    always @ (posedge CLOCK) begin 
    
    COUNTER <= COUNTER + 1;
    COUNTER2 <= COUNTER2 + 1;
    
    if(Max < 12'd2620) begin  
    if(COUNTER2 == 0) 
    idle_counter <= idle_counter + 1; 
    end
    else begin
    idle_counter <= 0;
    idle_state <= 0;
    end
    
    if(idle_counter == 7'd15) begin 
    idle_state <= 1; 
    idle_counter <= 0; // to restart idle counter 
    end
    end //always
    

    always @ (posedge OUTCLOCK) begin
    if(L == 1) begin
    if(seasonstate != 4'b1000) begin
    seasonstate <= seasonstate << 1;
    end 
    else begin
    seasonstate <= 4'b0001;
    end
    end

    if(R == 1) begin
    if(seasonstate != 4'b0001) begin
    seasonstate <= seasonstate >> 1; 
    end 
    else begin
    seasonstate <= 4'b1000;
    end
    end
    
    
    if(Max < 12'd2620 && idle_state == 1 && L == 0 && R == 0 && COUNTER == 0) begin
    if(seasonstate != 4'b1000) begin
    seasonstate <= seasonstate << 1;
    end 
    else begin
    seasonstate <= 4'b0001;
    end
    end
    
    end

    
endmodule
