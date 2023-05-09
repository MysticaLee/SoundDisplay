`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2020 06:01:06 PM
// Design Name: 
// Module Name: volume_level_display
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


module volume_level_display(
    input CLOCK, [15:0] sw, [7:0] seg0, [7:0] seg1, [7:0] seg2,
output reg [7:0] seg, reg [3:0] an
);

reg [1:0] COUNT; 

always @ (posedge CLOCK) begin
    if (sw[0] == 1) begin
        COUNT = (COUNT + 1) % 3;

        case (COUNT)
            2'd0:
            begin
                an = 4'b1110; //AN0
                seg = seg0;
            end
        
            2'd1:
            begin
                an = 4'b1101; //AN1
                seg = seg1;
            end
        
            2'd2:
            begin
                if (sw[7] == 1 && sw[10] == 0) begin //On AN3 if SW7 is ON
                    an = 4'b0111; //AN3
                    seg = seg2; //initals
                end
                else
                    an = 4'b1111; //Off AN3 if SW7 is OFF
            end
        
        endcase
    end

    else begin //OFF everything when SW0 is OFF
        an = 4'b1111;
        seg = 8'b1111_1111;
    end

end
endmodule
