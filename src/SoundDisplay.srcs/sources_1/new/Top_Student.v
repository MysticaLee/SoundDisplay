`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): THURSDAY P.M
//
//  STUDENT A NAME: Lee Xin Yu Jasmine
//  STUDENT A MATRICULATION NUMBER: A0205815J
//
//  STUDENT B NAME: Matthew Gani
//  STUDENT B MATRICULATION NUMBER: A0204882A
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input CLOCK,
    input btnC,
    input btnR,
    input btnL,
    input btnU,
    input btnD,
    input [15:0]sw,
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output [15:0] led,
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,
    cs,sdin, sclk, d_cn, resn, vccen, pmoden,   // Connect to this signal from Audio_Capture.v
    // Delete this comment and include other inputs and outputs here
    output [7:0] seg,
    output [3:0] an
    
    );
    wire [11:0] Mic_in;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    wire clk6p25;
    wire pb_reset;
    wire [4:0] teststate;
    wire [11:0] sample;
    wire clk20khz;
 
    wire [15:0] pixel_data; 

    
    wire slowclk;
    wire freq;
    wire [15:0] LD;
    wire [7:0] seg0;
    wire [7:0] seg1;
    
    wire [2:0] name;
    wire [7:0] seg2;
    
    wire [11:0] Max;
    wire idle_state;
    wire [3:0] seasonstate;
    
    wire [15:0] pixel_data0;
    wire [15:0] pixel_data1;
    
    wire R;
    wire U;
    wire L;
    wire D;
    
    idle_mode dev8 (CLOCK, Max[11:0], idle_state, seasonstate[3:0], btnL, btnR);
    
    clk6p25 dev3 (CLOCK, clk6p25); 
    clk20k dev5 (CLOCK, clk20khz);
    
    pulse_signal dev4 (btnC, CLOCK, pb_reset);
    pulse_signal dev11 (btnR, CLOCK, R);
    pulse_signal dev12 (btnU, CLOCK, U);
    pulse_signal dev13 (btnL, CLOCK, L);
    pulse_signal dev14 (btnD, CLOCK, D);
    
    slowerclock sc (CLOCK, slowclk);
    clk381hz c3 (CLOCK, freq);
    
    Audio_Capture dev1 (CLOCK, clk20khz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, Mic_in[11:0]);

    LED_display d2 (slowclk, Mic_in[11:0], LD[15:0], seg0[7:0], seg1[7:0], Max[11:0]);
        
    volume_level_display d3 (freq, sw[15:0], seg0[7:0], seg1[7:0], seg2[7:0], seg[7:0], an[3:0]);
        
    my_2_to_1_mux d4 (sw[0], Mic_in[11:0], LD[15:0], led[15:0]);
    
    
    Oled_Display dev2 (clk6p25, pb_reset, frame_begin, sending_pixels,
     sample_pixel, pixel_index[12:0], pixel_data[15:0], cs, sdin, sclk, d_cn, resn, vccen, pmoden, teststate[4:0]);

    
    oledvbar dev10(clk6p25, sw[15:0], pixel_index[12:0], pixel_data0[15:0], Max[11:0], idle_state, seasonstate[3:0],
    name[2:0]);
    
    my_initial d5 (CLOCK, btnU, btnD, sw[15:0], seg2[7:0], name[2:0]);
    
     game d6 (CLOCK, sw[15:0], pixel_index[12:0], pixel_data1[15:0], Max[11:0], pb_reset, U, L, R, D); 
     
     oled_mux d7 (sw[10], pixel_data0[15:0] , pixel_data1[15:0], pixel_data[15:0]);
    
 
 
endmodule