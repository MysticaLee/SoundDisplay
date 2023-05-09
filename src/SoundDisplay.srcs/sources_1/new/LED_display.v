`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 06:03:09 PM
// Design Name: 
// Module Name: LED_display
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


module LED_display(
    input CLOCK, [11:0] Mic_In,
output reg [15:0] led, reg [7:0] seg0, reg [7:0] seg1,
output reg [11:0] Max
);


reg [7:0] COUNT;

always @ (posedge CLOCK) begin
    COUNT <= (COUNT + 1) % 300;
    if (COUNT != 0) begin //Finding the Max Volume
        if (Mic_In > Max)
            Max = Mic_In;
    end
    else if (COUNT == 0) //Resets whenever COUNT = 0
        Max <= 0;
end

always @ (Max) begin
    if (Max < 12'd2100) begin
        led = 16'b0000_0000_0000_0001;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1100_0000; //0
    end
    
    else if (Max >= 12'd2100 && Max < 12'd2230) begin
        led = 16'b0000_0000_0000_0011;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1111_1001; //1
    end
    
    else if (Max >= 12'd2230 && Max < 12'd2360) begin
        led = 16'b0000_0000_0000_0111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1010_0100; //2
    end
    
    else if (Max >= 12'd2360 && Max < 12'd2490) begin
        led = 16'b0000_0000_0000_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1011_0000; //3
    end
        
    else if (Max >= 12'd2490 && Max < 12'd2620) begin
        led = 16'b0000_0000_0001_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1001_1001; //4
    end
        
    else if (Max >= 12'd2620 && Max < 12'd2750) begin
        led = 16'b0000_0000_0011_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1001_0010; //5
    end
        
    else if (Max >= 12'd2750 && Max < 12'd2880) begin
        led = 16'b0000_0000_0111_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1000_0010; //6
    end
        
    else if (Max >= 12'd2880 && Max < 12'd3010) begin
        led = 16'b0000_0000_1111_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1111_1000; //7
    end
        
    else if (Max >= 12'd3010 && Max < 12'd3140) begin
        led = 16'b0000_0001_1111_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1000_0000; //8
    end
        
    else if (Max >= 12'd3140 && Max < 12'd3270) begin
        led = 16'b0000_0011_1111_1111;
        seg1 = 8'b1100_0000; //0
        seg0 = 8'b1001_0000; //9
    end
        
    else if (Max >= 12'd3270 && Max < 12'd3400) begin
        led = 16'b0000_0111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1100_0000; //0
    end
        
    else if (Max >= 12'd3400 && Max < 12'd3530) begin
        led = 16'b0000_1111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1111_1001; //1
    end
        
    else if (Max >= 12'd3530 && Max < 12'd3660) begin
        led = 16'b0001_1111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1010_0100; //2
        
    end
        
    else if (Max >= 12'd3660 && Max < 12'd3790) begin
        led = 16'b0011_1111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1011_0000; //3
        
    end
        
    else if (Max >= 12'd3790 && Max < 12'd3920) begin
        led = 16'b0111_1111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1001_1001; //4
    end
        
    else if (Max >= 12'd3920) begin
        led = 16'b1111_1111_1111_1111;
        seg1 = 8'b1111_1001; //1
        seg0 = 8'b1001_0010; //5
    end
end
endmodule
