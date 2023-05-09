`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2020 11:22:09 PM
// Design Name: 
// Module Name: game
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


module game(
    input CLOCK, 
    input [15:0] sw, 
    input [12:0] pixel_index,
    output reg [15:0] pixel_data,
    input [11:0] Max,
    
    input C,
    input U,
    input L,
    input R,
    input D
    
    );
    wire R1;
    wire U1;
    wire L1;
    wire D1;
    wire C1;
    
    pulse_signal2 dev11 (R, CLOCK, R1);
    pulse_signal2 dev12 (U, CLOCK, U1);
    pulse_signal2 dev13 (L, CLOCK, L1);
    pulse_signal2 dev14 (D, CLOCK, D1);
    pulse_signal2 dev15 (C, CLOCK, C1);
    
    wire [28:0] Y; 
    wire [28:0] X; 
    reg [15:0] Max_holder;
    
    reg [15:0] black = 16'b0000000000000000;
    reg [15:0] green = 16'b0000110011000011 ;
    reg [15:0] blue = 16'b0000000000111111;
    reg [15:0] yellow = 16'b1111111111000000;
    reg [15:0] pink = 16'b1110110000111011;
    reg [15:0] brown = 16'b111000101000101;
    reg [15:0] lightbrown = 16'b1100000001100000;
    reg [15:0] cyan = 16'b0000011111111111;
    reg [15:0] orange = 16'b1111001010100001;
    reg [15:0] white = 16'b1111111111111111;
    reg [15:0] red = 16'b1101100000100000;
    reg [15:0] darkpink = 16'hE271;
    reg [15:0] grey = 16'b1001101111101111;
    
    
    assign Y = pixel_index/96;
    assign X = pixel_index % 96;
    
    reg [27:0] up = 0;
    reg [27:0] left = 0;
    reg [27:0] right = 0;
    
    reg [27:0]leftedge;
    reg [27:0]rightedge;
    reg [27:0]upedge;
    reg [27:0]downedge;
    
    reg [27:0] leftmax = 28'd6;
    reg [27:0] rightmax = 28'd90; 
    reg [27:0] upmax = 28'd5;
    reg [27:0] downmax = 28'd62;
    
    reg [5:0] page = 0; 
    reg [5:0] subpage = 6'd0;
    reg store = 0;
    reg [1:0] level = 2'd1;
    reg [2:0] lives = 3'd3;
    
    
    reg [15:0] HammerColor;
    reg [15:0] HeartColor;
    reg [25:0] COUNTER;
    reg [26:0] COUNTER2 = 27'b0000_0000_0000_0000_0000_0000_001;
    reg [27:0] COUNTER3;
    reg chosen = 0;
    always @ (posedge CLOCK) begin
    
    if(sw[10] == 0) begin //reset
    page = 0;
    subpage <= 0;
    Max_holder <= 0;
    left <= 0;
    right <= 0;
    up <= 0;
    store <= 0;
    lives <= 3'd3;
    level <= 2'd1;
    chosen = 0;
    end
    
    if(sw[10] == 1) begin //game on
    COUNTER <= COUNTER + 1;
    COUNTER2 <= COUNTER2 + 1;
    COUNTER3 <= COUNTER3 + 1;
    
    
    if(store == 1) begin
    if(Max > Max_holder) begin
    Max_holder = Max;
    end
 
    end 
    
    
    case(page) 
    3'd0: begin
    pixel_data = blue;
    // hammer upright 1
    //hammer outline
    //Vertical Hammer Outline
   
    lives = 3;

    if(((X >= 39 && X <= 55) && (Y>=12 && Y<= 24)) 
    || ((X >= 36 && X <= 38) && (Y>=13 && Y<= 23))
    || ((X >= 56 && X <= 58) && (Y>=13 && Y<= 23)) 
    || ((X >= 44 && X <= 50) && (Y>=25 && Y<= 47)) 
    || ((X >= 45 && X <= 49) && Y == 48) 
    || ((X >= 46 && X <= 48) && Y == 49)
    || (X == 47 && Y == 50))
    pixel_data = red;
    
    //hammer heart and sides
    if(((X >= 31 && X <= 35) && (Y>=13 && Y<= 23)) 
    || ((X >= 59 && X <= 63) && (Y>=13 && Y<= 23))
    || ((X >= 43 && X <= 45) && (Y == 16))
    || ((X >= 49 && X <= 51) && (Y == 16))
    || ((X >= 42 && X <= 46) && (Y == 17))
    || ((X >= 48 && X <= 52) && (Y == 17))
    || ((X >= 42 && X <= 52) && (Y == 18))
    || ((X >= 43 && X <= 51) && (Y == 19))
    || ((X >= 44 && X <= 50) && (Y == 20))
    || ((X >= 45 && X <= 49) && (Y == 21))
    || ((X >= 46 && X <= 48) && (Y == 22))
    || (X == 47 && (Y == 23)))
    pixel_data = pink;
    
    if (Y >= 13 && Y <= 23 && (X == 31 || X == 63) ||
           Y >= 24 && Y <= 47 && (X == 44 || X == 50) ||
           Y == 12 && (X >= 39 && X <= 55) ||
           Y == 13 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 23 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 24 && (X >= 39 && X <= 43 || X >= 51 && X <= 55) ||
           Y == 48 && (X == 45 || X == 49) ||
           Y == 49 && (X == 46 || X == 48) ||
           Y == 50 && X == 47)
           pixel_data = black;
    
    if (C1 == 1) begin
    HammerColor = red;
    HeartColor = pink; 
    chosen = 1;
    end
    
    if(COUNTER2 == 0 && chosen == 1) begin
    page <= 6;
    end
    else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
    page <= page + 1;
    end
    
    
    
    6'd1: begin
    pixel_data = blue;
    // hammer sideways 1
    // hammer handle
    

            
            
    if(((X >= 56 && X<= 66) && (Y>=20 && Y<= 42))
    || ((X == 55 || X == 67) && (Y>=23 && Y<=39))
    || ((X >= 32 && X<= 54) && (Y>=28 && Y<= 34))
    || (X == 31 && (Y >= 29 && Y <= 33))
    || (X == 30 && (Y >= 30 && Y <= 32))
    || (X == 29 && Y == 31))
    pixel_data = red;
    
    // hammer heart and sides
    if(((X >= 56 && X <= 66) && ((Y>= 15 && Y<= 19) || (Y>=43 && Y <= 47)))
    || (X == 63  && ((Y>= 27 && Y<= 29) || (Y>=33 && Y <= 35)))
    || (X == 62  && ((Y>= 26 && Y<= 30) || (Y>=32 && Y <= 36)))
    || (X == 61 && (Y>= 26 && Y <= 36))
    || (X == 60 && (Y >= 27 && Y <= 35))
    || (X == 59 && (Y >= 28 && Y <= 34))
    || (X == 58 && (Y >= 29 && Y <= 33))
    || (X == 57 && (Y >= 30 && Y <= 32))
    || (X == 56 && Y == 31))
    pixel_data = pink; //
    
        if (X >= 32 && X <= 55 && (Y == 28 || Y == 34) ||
            X == 29 && Y == 31 ||
            X == 30 && (Y == 30 || Y == 32) ||
            X == 31 && (Y == 29 || Y == 33) ||
            X == 55 && (Y >= 23 && Y <= 27 || Y >= 35 && Y <= 39) ||
            X == 56 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47) ||
            X >= 57 && X <= 65 && (Y == 15 || Y == 47) ||
            X == 67 && Y >= 23 && Y <= 39 ||
            X == 66 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47))
            
            pixel_data = black;
            
    if (C1 == 1) begin
            HammerColor = red;
            HeartColor = pink; 
            chosen = 1;
    end
            
            if(COUNTER2 == 0 && chosen == 1) begin
            page <= 6;
            end
            else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
            page <= page + 1;
            end

    
    6'd2: begin
    pixel_data = blue;
    // hammer upright 2
        //hammer outline
        //Vertical Hammer Outline

    if(((X >= 39 && X <= 55) && (Y>=12 && Y<= 24)) 
    || ((X >= 36 && X <= 38) && (Y>=13 && Y<= 23))
    || ((X >= 56 && X <= 58) && (Y>=13 && Y<= 23)) 
    || ((X >= 44 && X <= 50) && (Y>=25 && Y<= 47)) 
    || ((X >= 45 && X <= 49) && Y == 48) 
    || ((X >= 46 && X <= 48) && Y == 49)
    || (X == 47 && Y == 50))
    pixel_data = yellow; //change to scheme 2
    
    //hammer heart and sides
    if(((X >= 31 && X <= 35) && (Y>=13 && Y<= 23)) 
    || ((X >= 59 && X <= 63) && (Y>=13 && Y<= 23))
    || ((X >= 43 && X <= 45) && (Y == 16))
    || ((X >= 49 && X <= 51) && (Y == 16))
    || ((X >= 42 && X <= 46) && (Y == 17))
    || ((X >= 48 && X <= 52) && (Y == 17))
    || ((X >= 42 && X <= 52) && (Y == 18))
    || ((X >= 43 && X <= 51) && (Y == 19))
    || ((X >= 44 && X <= 50) && (Y == 20))
    || ((X >= 45 && X <= 49) && (Y == 21))
    || ((X >= 46 && X <= 48) && (Y == 22))
    || (X == 47 && (Y == 23)))
    pixel_data = pink; //change to scheme 2
    
    
    if (Y >= 13 && Y <= 23 && (X == 31 || X == 63) ||
           Y >= 24 && Y <= 47 && (X == 44 || X == 50) ||
           Y == 12 && (X >= 39 && X <= 55) ||
           Y == 13 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 23 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 24 && (X >= 39 && X <= 43 || X >= 51 && X <= 55) ||
           Y == 48 && (X == 45 || X == 49) ||
           Y == 49 && (X == 46 || X == 48) ||
           Y == 50 && X == 47)
           pixel_data = black;
            
    
    if (C1 == 1) begin
    HammerColor = yellow;
    HeartColor = pink; 
    chosen = 1;
    end
    if(COUNTER2 == 0 && chosen == 1)begin
    page <= 6;
    end
    else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
    page <= page + 1;
    end
    
    6'd3: begin
    pixel_data = blue;
    // hammer sideways 2
    // hammer handle
    

        if(((X >= 56 && X<= 66) && (Y>=20 && Y<= 42))
    || ((X == 55 || X == 67) && (Y>=23 && Y<=39))
    || ((X >= 32 && X<= 54) && (Y>=28 && Y<= 34))
    || (X == 31 && (Y >= 29 && Y <= 33))
    || (X == 30 && (Y >= 30 && Y <= 32))
    || (X == 29 && Y == 31))
    pixel_data = yellow; //change to scheme 2
    
    // hammer heart and sides
    if(((X >= 56 && X <= 66) && ((Y>= 15 && Y<= 19) || (Y>=43 && Y <= 47)))
    || (X == 63  && ((Y>= 27 && Y<= 29) || (Y>=33 && Y <= 35)))
    || (X == 62  && ((Y>= 26 && Y<= 30) || (Y>=32 && Y <= 36)))
    || (X == 61 && (Y>= 26 && Y <= 36))
    || (X == 60 && (Y >= 27 && Y <= 35))
    || (X == 59 && (Y >= 28 && Y <= 34))
    || (X == 58 && (Y >= 29 && Y <= 33))
    || (X == 57 && (Y >= 30 && Y <= 32))
    || (X == 56 && Y == 31))
    pixel_data = pink; // change to scheme 2
    
        if (X >= 32 && X <= 55 && (Y == 28 || Y == 34) ||
        X == 29 && Y == 31 ||
        X == 30 && (Y == 30 || Y == 32) ||
        X == 31 && (Y == 29 || Y == 33) ||
        X == 55 && (Y >= 23 && Y <= 27 || Y >= 35 && Y <= 39) ||
        X == 56 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47) ||
        X >= 57 && X <= 65 && (Y == 15 || Y == 47) ||
        X == 67 && Y >= 23 && Y <= 39 ||
        X == 66 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47))
        
        pixel_data = black;
    
    if (C1 == 1) begin
        HammerColor = yellow;
        HeartColor = pink; 
        chosen = 1;
        end
        if(COUNTER2 == 0 && chosen == 1)begin
        page <= 6;
        end
        else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
        page <= page + 1;
        end
    
    6'd4: begin
    pixel_data = blue;
    // hammer upright 3
        //hammer outline
        

                
    if(((X >= 39 && X <= 55) && (Y>=12 && Y<= 24)) 
    || ((X >= 36 && X <= 38) && (Y>=13 && Y<= 23))
    || ((X >= 56 && X <= 58) && (Y>=13 && Y<= 23)) 
    || ((X >= 44 && X <= 50) && (Y>=25 && Y<= 47)) 
    || ((X >= 45 && X <= 49) && Y == 48) 
    || ((X >= 46 && X <= 48) && Y == 49)
    || (X == 47 && Y == 50))
    pixel_data = green; //change to scheme 3
    
    //hammer heart and sides
    if(((X >= 31 && X <= 35) && (Y>=13 && Y<= 23)) 
    || ((X >= 59 && X <= 63) && (Y>=13 && Y<= 23))
    || ((X >= 43 && X <= 45) && (Y == 16))
    || ((X >= 49 && X <= 51) && (Y == 16))
    || ((X >= 42 && X <= 46) && (Y == 17))
    || ((X >= 48 && X <= 52) && (Y == 17))
    || ((X >= 42 && X <= 52) && (Y == 18))
    || ((X >= 43 && X <= 51) && (Y == 19))
    || ((X >= 44 && X <= 50) && (Y == 20))
    || ((X >= 45 && X <= 49) && (Y == 21))
    || ((X >= 46 && X <= 48) && (Y == 22))
    || (X == 47 && (Y == 23)))
    pixel_data = pink; //change to scheme 3
    
    
    
    if (Y >= 13 && Y <= 23 && (X == 31 || X == 63) ||
           Y >= 24 && Y <= 47 && (X == 44 || X == 50) ||
           Y == 12 && (X >= 39 && X <= 55) ||
           Y == 13 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 23 && (X >= 32 && X <= 39 || X >= 55 && X <= 62) ||
           Y == 24 && (X >= 39 && X <= 43 || X >= 51 && X <= 55) ||
           Y == 48 && (X == 45 || X == 49) ||
           Y == 49 && (X == 46 || X == 48) ||
           Y == 50 && X == 47)
           pixel_data = black;
                
    if (C1 == 1 ) begin
    HammerColor = green;
    HeartColor = pink; 
    chosen = 1;
    end
    if(COUNTER2 == 0 && chosen == 1) begin
    page <= 6;
    end
    else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
    page <= page + 1;
    end
    
    6'd5: begin
    pixel_data = blue;
    // hammer sideways 3
    // hammer handle

            
            
        if(((X >= 56 && X<= 66) && (Y>=20 && Y<= 42))
    || ((X == 55 || X == 67) && (Y>=23 && Y<=39))
    || ((X >= 32 && X<= 54) && (Y>=28 && Y<= 34))
    || (X == 31 && (Y >= 29 && Y <= 33))
    || (X == 30 && (Y >= 30 && Y <= 32))
    || (X == 29 && Y == 31))
    pixel_data = green; // scheme 3
    
    // hammer heart and sides
    if(((X >= 56 && X <= 66) && ((Y>= 15 && Y<= 19) || (Y>=43 && Y <= 47)))
    || (X == 63  && ((Y>= 27 && Y<= 29) || (Y>=33 && Y <= 35)))
    || (X == 62  && ((Y>= 26 && Y<= 30) || (Y>=32 && Y <= 36)))
    || (X == 61 && (Y>= 26 && Y <= 36))
    || (X == 60 && (Y >= 27 && Y <= 35))
    || (X == 59 && (Y >= 28 && Y <= 34))
    || (X == 58 && (Y >= 29 && Y <= 33))
    || (X == 57 && (Y >= 30 && Y <= 32))
    || (X == 56 && Y == 31))
    pixel_data = pink; // scheme 3
    
        if (X >= 32 && X <= 55 && (Y == 28 || Y == 34) ||
        X == 29 && Y == 31 ||
        X == 30 && (Y == 30 || Y == 32) ||
        X == 31 && (Y == 29 || Y == 33) ||
        X == 55 && (Y >= 23 && Y <= 27 || Y >= 35 && Y <= 39) ||
        X == 56 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47) ||
        X >= 57 && X <= 65 && (Y == 15 || Y == 47) ||
        X == 67 && Y >= 23 && Y <= 39 ||
        X == 66 && (Y >= 15 && Y <= 23 || Y >= 39 && Y <= 47))
        
        pixel_data = black;
        
        
    if (C1 == 1 ) begin
        HammerColor = green;
        HeartColor = pink; 
        chosen = 1;
        end
        if(COUNTER2 == 0 && chosen == 1) begin
        page <= 6;
        end
        else if (COUNTER2 == 0 && C == 0 && chosen == 0) 
        page <= 0;
        end

    
    6'd7: begin
    subpage = 6'd0; // to restart power level subpage
    
    pixel_data = blue;
    // 3
    if (X >= 36 && X <= 54 && (Y >= 14 && Y <=19 || Y >= 29 && Y <= 34 || Y >= 44 && Y <= 49) ||
            X >= 55 && X <= 60 && Y >= 14 && Y <= 49) begin
                pixel_data = 16'b1111_1000_0000_0000;
                end
                

    if(COUNTER2 == 0)
    page <= page + 1;
                
    end
    
    6'd8: begin
    pixel_data = blue;
    //2
           if (X >= 36 && X <= 60 && (Y >= 14 && Y <=19 || Y >= 29 && Y <= 34 || Y >= 44 && Y <= 49) ||
           X >= 55 && X <= 60 && Y >= 20 && Y <= 28 ||
           X >= 36 && X <= 41 && Y >= 35 && Y <= 43)
               pixel_data = 16'b1111_1000_0000_0000;
               
        if(COUNTER2 == 0)
               page <= page + 1;
    end
    
    6'd9: begin
    //1 
    pixel_data = blue;

    if (X >= 45 && X <= 50 && Y >= 14 && Y <= 49)
            pixel_data = 16'b1111_1000_0000_0000;
            
   if(COUNTER2 == 0)
   page <= page + 1;
            
    end
    
    6'd6: begin
    pixel_data = blue;
    chosen = 0;
    store = 1;
    //CLAP
    if (Y >= 18 && Y <= 45 && (X >= 7 && X <= 11 || X >= 28 && X <= 32 || X >= 50 && X <= 54 || X >= 62 && X <= 66 || X >= 71 && X <= 75) ||
            X >= 12 && X <= 23 && (Y >= 18 && Y <= 22 || Y >= 41 && Y <= 45) ||
            X >= 33 && X <= 45 && Y >= 41 && Y <= 45 ||
            X >= 55 && X <= 61 && (Y >= 18 && Y <= 22 || Y >= 29 && Y <= 33) ||
            X >= 85 && X <= 89 && Y >= 18 && Y <= 33 ||
            X >= 76 && X <= 84 && (Y >= 18 && Y <= 22 || Y >= 29 && Y <= 33))
                pixel_data = 16'b1111_1000_0000_0000;
                
         if(level == 2'd1) begin
                        if (Y >= 7 && Y <= 16 && (X == 68 || X == 69 || X == 75 || X == 76 || X == 79 || X == 80 || X == 82 || X == 83 || X == 88 || X == 89) ||
                X >= 70 && X <= 73 && (Y == 15 || Y == 16) ||
                X >= 77 && X <= 78 && (Y == 7 || Y == 8 || Y == 15 || Y == 16) ||
                X >= 84 && X <= 87 && (Y == 15 || Y == 16) ||
                Y >= 11 && Y <= 14 && (X == 85 || X == 86))
                    pixel_data = 16'b1111_1000_0000_0000;
                end
                if(level == 2'd2) begin
                        if (Y >= 7 && Y <= 16 && (X == 68 || X == 69 || X == 74 || X == 75 || X == 77 || X == 78 || X == 84 || X == 85 || X == 88) ||
                        X == 89 && Y >= 8 && Y <= 15 ||
                        X >= 70 && X <= 73 && Y >= 7 && Y <= 8 ||
                        Y >= 9 && Y <= 12 && X >= 71 && X <= 72 ||
                        X >= 79 && X <= 82 && (Y == 7 || Y == 8 || Y == 11 || Y == 12 || Y == 15 || Y == 16) ||
                        X >= 86 && X <= 87 && (Y == 7 || Y == 8 || Y == 15 || Y == 16))
                            pixel_data = 16'b1111_1000_0000_0000;
                
                end
                if(level == 2'd3) begin
                if (Y >= 7 && Y <= 16 && (X == 67 || X == 68 || X == 71 || X == 72 || X == 74 || X == 75 || X == 77 || X == 78 || X == 84 || X == 85 || X == 88 || X == 89) ||
                        X >= 69 && X <= 70 && Y >= 11 && Y <= 12 ||
                        X >= 79 && X <= 82 && (Y == 7 || Y == 8 || Y == 15 || Y == 16) ||
                        X >= 81 && X <= 82 && Y >= 11 && Y <= 14 ||
                        X == 80 && Y >= 11 && Y <= 12 ||
                        X >= 86 && X <= 87 && Y >= 11 && Y <= 12)
                            pixel_data = 16'b1111_1000_0000_0000;
                
                end
                
        if(COUNTER2 == 0)
                page <= page + 1;
                
    
    end
    
    6'd10: begin
    store = 0;
    
    pixel_data = blue;
        if(Y == 63) 
    pixel_data = black;
    //game page 1
    if(((X == 51 || X == 40) && (Y>= 33 && Y <= 37))
    || ((X>= 41 && X <= 51) && ( Y>= 32 && Y<= 38))
    || ((X>= 44 && X <= 48) && (Y>= 39 && Y<= 46))
    || ((X>= 45 && X<= 47) && (Y == 47))
    || (X == 46 && Y == 48))
    pixel_data = HammerColor;
    
    if(((Y >= 33 && Y<= 37) && (X == 38 || X == 39 || X == 53 || X == 54)) 
    || (Y == 34 && (X == 44 || X == 45 || X == 47 || X == 48))
    || (Y == 35 && (X >= 44 && X <= 48))
    || (Y == 36 && (X>= 45 && X<= 47))
    || (Y == 37 && X == 46))
    pixel_data = HeartColor;
    
    //head && body
    if(((X>= 23 && X<= 35) && (Y>= 28 && Y<= 36))
    || ((X>= 27 && X<= 31) && Y == 27)
    || ((X>= 19 && X<= 36) && (Y>= 40 && Y<= 53)))
    pixel_data = yellow; //for now
    
    // 2 arms, different places
    if(((X>= 16 && X<= 18) && (Y>= 42 && Y<= 50)) 
    || ((X>= 37 && X<= 47) && (Y>= 42 && Y<= 45)))
    pixel_data = cyan; //for now
    
    // neck and legs same color as hands
    if((((X>= 23 && X <= 27) || (X>= 30 && X<= 34)) && (Y>= 54 && Y<= 62))
    || ((X == 29 || X == 30) && (Y>= 37 && Y<= 39)))
    pixel_data = cyan; // for now
    
    // button
    if(((X>= 53 && X <= 57) && Y == 54)
    || ((X>= 54 && X <= 56) && Y == 53))
    pixel_data = red;
    
    // blackbox and stand
    if(((X>= 48 && X<= 62) && (Y>= 55 && Y<= 62))
    || ((X>= 59 && X<= 78) && (Y>= 9 && Y<= 13))
    || ((X == 63 || X == 74) && (Y >= 14 && Y<= 63)))
    pixel_data = black;
    
    // eyes and mouth
    if(((X == 27 || X == 31) && ( Y == 31 || Y == 33)) || ((X>= 28 && X<= 30) && Y == 34))
    pixel_data = black;
    
    if(X>= 64 && X<= 73) begin
    // 1 bars that are always there
        if(Y == 14 || Y == 17 || Y == 20 || Y == 23 || Y == 26 || Y == 29
         || Y == 32 || Y == 35 || Y == 38 || Y == 41 || Y == 44 || Y == 47 || Y == 50
         || Y == 53 || Y == 56 || Y == 59 || Y == 62) 
         pixel_data = red;  
     end
     
     if(lives == 3'd3) begin
         if(((Y == 5 || Y == 9) && (X == 5 || X == 9)) || ((Y == 6 || Y == 8) && (X == 6 || X == 8)) 
         ||(Y == 7 && X == 7)) begin
         pixel_data = black;
     end
     end
     if(lives >= 3'd2) begin
        if(((Y == 5 || Y == 9) && (X == 11 || X == 15)) || ((Y == 6 || Y == 8) && (X == 12 || X == 14)) 
     ||(Y == 7 && X == 13)) begin
     pixel_data = black;
     end
     end
    if(lives >= 3'd1) begin
            if(((Y == 5 || Y == 9) && (X == 17 || X == 21)) || ((Y == 6 || Y == 8) && (X == 18 || X == 20)) 
     ||(Y == 7 && X == 19)) begin
     pixel_data = black;
     end
     end
     
      
     if(C == 1) // if middle button is pressed, will hit
     page <= page + 1;
    
    // hammer and heart color are based on colorscheme value
    end 
    
    6'd11: begin
    
    pixel_data = blue;
    if(Y == 63) 
    pixel_data = black;
    //game page 2
    // hammer handle
    if(((X>= 53 && X<= 57) && (Y>= 38 && Y <= 50))
    || ((X>= 44 && X<= 51) && (Y>= 42 && Y<= 46))
    || ((X>= 52 && X<= 58) && (Y>= 39 && Y<= 49)))
    pixel_data = HammerColor;
    
    
    if(((X>= 53 && X<= 57) && (Y == 36 || Y == 37 || Y == 51 || Y == 52))
    || (X == 56 && ( Y== 42 || Y == 43 || Y == 45 || Y == 46))
    || (X == 55 && (Y >= 42 && Y <= 46))
    || (X == 54 && (Y>= 43 && Y <= 45))
    || (X == 53 && Y == 44 ))
    pixel_data = HeartColor;
    
        //head && body
    if(((X>= 23 && X<= 35) && (Y>= 28 && Y<= 36))
    || ((X>= 27 && X<= 31) && Y == 27)
    || ((X>= 19 && X<= 36) && (Y>= 40 && Y<= 53)))
    pixel_data = yellow; //for now
    
        // neck and legs same color as hands
    if((((X>= 23 && X <= 27) || (X>= 30 && X<= 34)) && (Y>= 54 && Y<= 62))
    || ((X == 29 || X == 30) && (Y>= 37 && Y<= 39)))
    pixel_data = cyan; // for now
    
    // left and right arm
    if(((X >= 20 && X <= 26) && (Y>= 43 && Y<= 46))
    || ((X>= 37 && X <= 45) && (Y>= 42 && Y <= 45)))
    pixel_data = cyan; //for now
    
    // eyes and mouth
    if(((X == 27 || X == 32) && Y == 30)
    || ((X == 28 || X == 31) && Y == 31)
    || ((X == 27 || X == 32) && Y == 32)
    || ((X>=28 && X<= 31) && Y == 34))
    pixel_data = black;
    
        // button
    if(((X>= 53 && X <= 57) && Y == 54)
    || ((X>= 54 && X <= 56) && Y == 53))
    pixel_data = red;
    
    // blackbox and stand
    if(((X>= 48 && X<= 62) && (Y>= 55 && Y<= 62))
    || ((X>= 59 && X<= 78) && (Y>= 9 && Y<= 13))
    || ((X == 63 || X == 74) && (Y >= 14 && Y<= 63)))
    pixel_data = black;
    
    //bars
        if(X>= 64 && X<= 73) begin
    // 1 bars that are always there
        if(Y == 14 || Y == 17 || Y == 20 || Y == 23 || Y == 26 || Y == 29
         || Y == 32 || Y == 35 || Y == 38 || Y == 41 || Y == 44 || Y == 47 || Y == 50
         || Y == 53 || Y == 56 || Y == 59 || Y == 62) 
         pixel_data = red;  
     end
     
     if(lives == 3'd3) begin
         if(((Y == 5 || Y == 9) && (X == 5 || X == 9)) || ((Y == 6 || Y == 8) && (X == 6 || X == 8)) 
         ||(Y == 7 && X == 7)) begin
         pixel_data = black;
     end
     end
     if(lives >= 3'd2) begin
        if(((Y == 5 || Y == 9) && (X == 11 || X == 15)) || ((Y == 6 || Y == 8) && (X == 12 || X == 14)) 
     ||(Y == 7 && X == 13)) begin
     pixel_data = black;
     end
     end
    if(lives >= 3'd1) begin
            if(((Y == 5 || Y == 9) && (X == 17 || X == 21)) || ((Y == 6 || Y == 8) && (X == 18 || X == 20)) 
     ||(Y == 7 && X == 19)) begin
     pixel_data = black;
     end
     end
     
    
    case (subpage) 
    // l
    6'd0: begin
    if( Max_holder > 12'd0) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 60 || Y == 61 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin

        if(level == 2'd1 ) begin
        page <= 13; //good job
        
        end

        else if(level == 2'd2) begin
        page <= 14;
        
        
        end
        else if(level == 2'd3) begin
        page <= 14;
        
        
        end
    
    end
    end
    
    6'd1: begin
    if( Max_holder >= 12'd2100) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 57 || Y == 58 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin
        if(COUNTER2 == 0) begin

        if(level == 2'd1) begin
        page <= 13; //good job
        
        end
        else if(level == 2'd2) begin
        page <= 14;
       
        
        end
        else if(level == 2'd3) begin
        page <= 14;
        
        
        end
    end
    end
    end
    
        6'd2: begin
    if( Max_holder >= 12'd2230) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 54 || Y == 55 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin
        if(COUNTER2 == 0) begin

        if(level == 2'd1) begin
        page <= 13; //good job
        
        end
        else if(level == 2'd2) begin
        page <= 14;
        
        
        end
        else if(level == 2'd3) begin
        page <= 14;
        
        
        end
    end   
    end
    end
    
        6'd3: begin
    if( Max_holder >= 12'd2360) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 51 || Y == 52 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin
        if(COUNTER2 == 0) begin

        if(level == 2'd1) begin
        page <= 13; //good job
        
        end
        else if(level == 2'd2) begin
        page <= 14;
        
        
        end
        else if(level == 2'd3) begin
        page <= 14;
        
        
        end
    end
    end
    end
    
    
        6'd4: begin
    if( Max_holder >= 12'd2490) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 48 || Y == 49 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin
    if(COUNTER2 == 0) begin

        if(level == 2'd1) begin
        page <= 13; //good job
        
        end
        else if(level == 2'd2) begin
        page <= 14;
        
        
        end
        else if(level == 2'd3) begin
        page <= 14;
        
        
        end
     end   
    end
    end
    
    // end low
    6'd5: begin
    if( Max_holder >= 12'd2620) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 45 || Y == 46 ) && (X>= 64 && X<= 73))
    pixel_data = white;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 13; 
    
    end
    else if(level == 2'd2) begin
    page <= 14;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
    
    // start med
    6'd6: begin
    if( Max_holder >= 12'd2750) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 42 || Y == 43 ) && (X>= 64 && X<= 73))
    pixel_data = grey;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 13;
     
    end
    else if(level == 2'd2) begin
    page <= 14;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
        6'd7: begin
    if( Max_holder >= 12'd2880) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 39 || Y == 40 ) && (X>= 64 && X<= 73))
    pixel_data = grey;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 14; 
    
    end
    else if(level == 2'd2) begin
    page <= 13;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
    
        6'd8: begin
    if( Max_holder >= 12'd3010) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 36 || Y == 37 ) && (X>= 64 && X<= 73))
    pixel_data = grey;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 14; 
    
    end
    else if(level == 2'd2) begin
    page <= 13;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
        6'd9: begin
    if( Max_holder  >= 12'd3140) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 33 || Y == 34 ) && (X>= 64 && X<= 73))
    pixel_data = grey;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 14; 
    
    end
    else if(level == 2'd2) begin
    page <= 13;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
        6'd10: begin
    if( Max_holder >= 12'd3270) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 30 || Y == 31 ) && (X>= 64 && X<= 73))
    pixel_data = grey;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 14; 
    
    end
    else if(level == 2'd2) begin
    page <= 13;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
    
    // start high
        6'd11: begin
    if( Max_holder >= 12'd3400) begin
    subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
    if((Y == 27 || Y == 28 ) && (X>= 64 && X<= 73))
    pixel_data = black;
    end
    else begin
    if(COUNTER2 == 0) begin

    if(level == 2'd1) begin
    page <= 14; 
    
    end
    else if(level == 2'd2) begin
    page <= 13;
    
    end
    else if(level == 2'd3) begin
    page <= 14;
    
    end
    end
    end
    end
    
     6'd12: begin
       if( Max_holder >= 12'd3530) begin
       subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
       if((Y == 24 || Y == 25 ) && (X>= 64 && X<= 73))
       pixel_data = black;
       end
       else begin
       if(COUNTER2 == 0) begin

       if(level == 2'd1) begin
       page <= 14; 
       
       end
       else if(level == 2'd2) begin
       page <= 14;
       
       end
       else if(level == 2'd3) begin
       page <= 13;
       end
       end
       end
       end

     6'd13: begin
       if( Max_holder >= 12'd3660) begin
       subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
       if((Y == 21 || Y == 22 ) && (X>= 64 && X<= 73))
       pixel_data = black;
       end
       else begin
       if(COUNTER2 == 0) begin

       if(level == 2'd1) begin
       page <= 14; 
       
       end
       else if(level == 2'd2) begin
       page <= 14;
       
       end
       else if(level == 2'd3) begin
       page <= 13;
       end
       end
       end
       end  
       
        6'd14: begin
         if( Max_holder >= 12'd3790) begin
         subpage <= (COUNTER == 0) ? subpage + 1 : subpage;
         if((Y == 18 || Y == 19 ) && (X>= 64 && X<= 73))
         pixel_data = black;
         end
         
         else begin
         if(COUNTER2 == 0) begin

         if(level == 2'd1) begin
         page <= 14; 
         
         end
         else if(level == 2'd2) begin
         page <= 14;
         
         end
         else if(level == 2'd3) begin
         page <= 13;
         end
         end
         end
         end
       
            6'd15: begin
          if( Max_holder >= 12'd3920) begin
          if((Y == 15 || Y == 16 ) && (X>= 64 && X<= 73))
          pixel_data = black;
          
          if(COUNTER2 == 0) begin

          if(level == 2'd1) begin
          page <= 14; 
          end
          else if(level == 2'd2) begin
          page <= 14;
          end
          else if(level == 2'd3) begin
          page <= 13;
          end
          
          end
          
          end
          end
          
          endcase
    end
   

    // page
    6'd13: begin
    Max_holder = 0;
    pixel_data = blue;
    // good job 
     if (Y >= 16 && Y <= 28 && (X >= 25 && X <= 27 || X >= 37 && X <= 39 || X >= 44 && X <= 46 || X >= 49 && X <= 51 || X >= 56 && X <= 58 || X >= 61 && X <= 63) ||
          X == 70 && (Y >= 17 && Y <= 27) ||
          Y >= 16 && Y <= 18 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 69) ||
          X >= 68 && X <= 69 && Y >= 19 && Y <= 28 ||
          Y >= 21 && Y <= 23 && (X >= 30 && X <= 34) ||
          Y >= 26 && Y <= 28 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 67) ||
          Y >= 35 && Y <= 47 && (X >= 38 && X <= 40 || X >= 43 && X <= 45 || X >= 50 && X <= 52 || X >= 55 && X <= 57 || X >= 62 && X <= 63) ||
          X == 64 && (Y >= 36 && Y <= 40 || Y >= 42 && Y <= 46) ||
          Y >= 35 && Y <= 37 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
          Y >= 40 && Y <= 42 && X >= 58 && X <= 61 ||
          Y >= 45 && Y <= 47 && (X >= 31 && X <= 37 || X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
          Y >= 43 && Y <= 44 && X >= 31 && X <= 33 || 
          X >= 32 && X <= 34 && Y >= 24 && Y <= 25)
               pixel_data = 16'b1111_1000_0000_0000;
               
    if(COUNTER3 == 0) begin
    page <= 19;
    end
    end
    
    6'd14: begin
    Max_holder = 0;
    pixel_data = blue;
    // try again
    if (Y >= 16 && Y <= 18 && (X >= 30 && X <= 40 || X >= 43 && X <= 52) ||
           Y >= 19 && Y <= 28 && (X >= 34 && X <= 36 || X >= 43 && X <= 45) ||
           Y >= 19 && Y <= 23 && X >= 50 && X <= 52 ||
           Y == 24 && X >= 47 && X <= 49 ||
           Y == 25 && X >= 48 && X <= 50 ||
           Y == 26 && X >= 49 && X <= 51 ||
           Y >= 27 && Y <= 28 && X >= 50 && X <= 52 ||
           X >= 55 && X <= 57 && Y >= 16 && Y <= 23 ||
           X >= 62 && X <= 64 && Y >= 16 && Y <= 28 ||
           Y >= 21 && Y <= 23 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
           Y >= 26 && Y <= 28 && X >= 55 && X <= 61 ||
           Y >= 35 && Y <= 47 && (X >= 23 && X <= 25 || X >= 30 && X <= 32 || X >= 35 && X <= 37 || X >= 47 && X <= 49 || X >= 54 && X <= 56 || X >= 59 && X <= 61 || X >= 64 && X <= 66 || X >= 71 && X <= 73) ||
           Y >= 35 && Y <= 37 && (X >= 26 && X <= 29 || X >= 38 && X <= 44 || X >= 50 && X <= 53 || X >= 67 && X <= 70) ||
           Y >= 40 && Y <= 42 && (X >= 26 && X <= 29 || X >= 40 && X <= 44 || X >= 50 && X <= 53) ||
           X >= 38 && X <= 44 && Y >= 45 && Y <= 47 ||
           X >= 42 && X <= 44 && Y >= 43 && Y <= 44)
                pixel_data = 16'b1111_1000_0000_0000;
                
           
 
    if(COUNTER3 == 0) begin
      if(lives == 3'd3) begin
  
      page <= 17;
      end
      else if (lives == 3'd2) begin
      page <= 18;
      end
      else if(lives == 3'd1) begin
      page <= 16;
      end


      end
      end
      



    
    6'd15: begin 
    pixel_data = blue;
    if(Y == 63)
    pixel_data = black;
         if (Y >= 16 && Y <= 28 && (X >= 25 && X <= 27 || X >= 37 && X <= 39 || X >= 44 && X <= 46 || X >= 49 && X <= 51 || X >= 56 && X <= 58 || X >= 61 && X <= 63) ||
         X == 70 && (Y >= 17 && Y <= 27) ||
         Y >= 16 && Y <= 18 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 69) ||
         X >= 68 && X <= 69 && Y >= 19 && Y <= 28 ||
         Y >= 21 && Y <= 23 && (X >= 30 && X <= 34) ||
         Y >= 26 && Y <= 28 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 67) ||
         Y >= 35 && Y <= 47 && (X >= 38 && X <= 40 || X >= 43 && X <= 45 || X >= 50 && X <= 52 || X >= 55 && X <= 57 || X >= 62 && X <= 63) ||
         X == 64 && (Y >= 36 && Y <= 40 || Y >= 42 && Y <= 46) ||
         Y >= 35 && Y <= 37 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
         Y >= 40 && Y <= 42 && X >= 58 && X <= 61 ||
         Y >= 45 && Y <= 47 && (X >= 31 && X <= 37 || X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
         Y >= 43 && Y <= 44 && X >= 31 && X <= 33 || 
         X >= 32 && X <= 34 && Y >= 24 && Y <= 25)
              pixel_data = white;
              
    
    if(lives == 3'd3) begin
        if(((Y == 5 || Y == 9) && (X == 5 || X == 9)) || ((Y == 6 || Y == 8) && (X == 6 || X == 8)) 
        ||(Y == 7 && X == 7)) begin
        pixel_data = black;
    end
    end
    if(lives >= 3'd2) begin
       if(((Y == 5 || Y == 9) && (X == 11 || X == 15)) || ((Y == 6 || Y == 8) && (X == 12 || X == 14)) 
    ||(Y == 7 && X == 13)) begin
    pixel_data = black;
    end
    end
    if(lives >= 3'd1) begin
           if(((Y == 5 || Y == 9) && (X == 17 || X == 21)) || ((Y == 6 || Y == 8) && (X == 18 || X == 20)) 
    ||(Y == 7 && X == 19)) begin
    pixel_data = black;
    end
    end
    
        //head && body
    if(((X>= (40 - left + right) && X<= (52 - left + right)) && (Y>= (28 - up) && Y<= (36- up)))
    || ((X>= (44 - left + right) && X<= (48 - left + right)) && Y == (27 - up))
    || ((X>= (37 - left + right) && X<= (54 - left + right)) && (Y>= (40 - up) && Y<= (53 - up))))
    pixel_data = yellow; //for now
    
    // neck and legs same color as hands
    if((((X>= (40 - left + right) && X <= (44 - left + right)) 
    || (X>= (47 - left + right) && X<= (51 - left + right))) && (Y>= (54 - up) && Y<= (62 - up) ))
    || ((X >= (45 - left + right) && X <= (47 - left + right)) && (Y>= (37 - up) && Y<= (39 - up))))
    pixel_data = cyan; 
    
    // arms
    if((((X >= (30 - left + right) && X <= (36 - left + right)) 
    || (X >= (55 - left + right) && X <= (61 - left + right))) && (Y >= (43 - up) && Y <= (46 - up)))
        || (((X >= (30 - left + right) && X <= (33 - left + right)) 
        || (X >= (58 - left + right) && X <= (61 - left + right))) && (Y >= (35 - up) && Y <= (42 - up))))
        pixel_data = cyan;
        
    // eyes and mouth
        if(((X == (45 - left + right) || X == (49 - left + right))
         && ( Y == (31 - up) || Y == (33 - up))) || ((X>= (46 - left + right) && X<= (48 - left + right))
          && Y == (34 - up)))
        pixel_data = black;
        
        if((((X == (35 - left + right) || X == (36 - left + right)) ||( X == (55 - left + right) || X == (56 - left + right))) && (Y >= (41 - up) && Y <= (42 - up))))
        pixel_data = cyan;
        
     
    leftedge = 30 - left + right;
    rightedge = 61 - left + right;
    upedge =  27 - up;
    downedge = 62 - up;
    
    if(U1 == 1) begin 
        if(upedge > upmax) begin
            up = up + 6;
            end
     end
     else if (U1 == 0) begin
        if(downedge < downmax && up > 0 && COUNTER == 0) begin
            up = up - 2;
            
            end
     end
     if(D1 == 1) begin
        if(downedge < (downmax - 6)) begin
        up = up - 6;
        end
     end
     
    if (L1 == 1) begin
        if(leftedge > leftmax) begin
            left = left + 5;
            end
    end
    if (R1 == 1) begin
        if(rightedge < rightmax) begin
            right = right + 5;
            end
     end
    
    
    
    if(C1 == 1) begin
    left <= 0;
    right <= 0;
    up <= 0;
    page <= 0;
    end
    
    end
    6'd16: begin
    pixel_data = red;
    //game over
     if (Y >= 16 && Y <= 28 && (X >= 25 && X <= 27 || X >= 37 && X <= 39 || X >= 44 & X <= 46 || X >= 49 && X <= 51 || X >= 56 && X <= 58 || X >= 61 && X <= 63) ||
           Y >= 16 && Y <= 18 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 70) ||
           Y >= 26 && Y <= 28 && (X >= 28 && X <= 34 || X >= 64 && X <= 70) ||
           Y >= 21 && Y <= 23 && (X >= 30 && X <= 34 || X >= 40 && X <= 43 || X >= 64 && X <= 70) ||
           Y >= 24 && Y <= 25 && X >= 32 && X <= 34 ||
           Y >= 19 && Y <= 23 && X >= 53 && X <= 54 ||
           Y >= 35 && Y <= 47 && (X >= 25 && X <= 27 || X >= 32 && X <= 34 || X >= 49 && X <= 51 || X >= 61 && X <= 63) ||
           Y >= 35 && Y <= 37 && (X >= 28 && X <= 31 || X >= 52 && X <= 58 || X >= 64 && X <= 70) ||
           Y >= 45 && Y <= 47 && (X >= 28 && X <= 31 || X >= 52 && X <= 58) ||
           Y >= 40 && Y <= 42 && (X >= 52 && X <= 58 || X >= 64 && X <= 70) ||
           Y >= 35 && Y <= 43 && (X >= 37 && X <= 39 || X >= 44 && X <= 46) ||
           Y == 44 && (X >= 38 && X <= 40 || X >= 43 && X <= 45) ||
           Y == 45 && X >= 39 && X <= 44 ||
           Y == 46 && X >= 40 && X <= 43 ||
           Y == 47 && X >= 41 && X <= 42 ||
           Y >= 38 && Y <= 39 && X >= 68 && X <= 70 ||
           Y == 43 && X >= 65 && X <= 67 ||
           Y == 44 && X >= 66 && X <= 68 ||
           Y == 45 && X >= 67 && X <= 69 ||
           Y >= 46 && Y <= 47 && X >= 68 && X <= 70)
           pixel_data = black;
           
    lives = 3'd0;
    level = 3'd1;
    if(COUNTER2 == 0) begin
    page <= 0;
    end
    
    end
    
    6'd17 : begin
    pixel_data = blue;
        if (Y >= 16 && Y <= 18 && (X >= 30 && X <= 40 || X >= 43 && X <= 52) ||
           Y >= 19 && Y <= 28 && (X >= 34 && X <= 36 || X >= 43 && X <= 45) ||
           Y >= 19 && Y <= 23 && X >= 50 && X <= 52 ||
           Y == 24 && X >= 47 && X <= 49 ||
           Y == 25 && X >= 48 && X <= 50 ||
           Y == 26 && X >= 49 && X <= 51 ||
           Y >= 27 && Y <= 28 && X >= 50 && X <= 52 ||
           X >= 55 && X <= 57 && Y >= 16 && Y <= 23 ||
           X >= 62 && X <= 64 && Y >= 16 && Y <= 28 ||
           Y >= 21 && Y <= 23 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
           Y >= 26 && Y <= 28 && X >= 55 && X <= 61 ||
           Y >= 35 && Y <= 47 && (X >= 23 && X <= 25 || X >= 30 && X <= 32 || X >= 35 && X <= 37 || X >= 47 && X <= 49 || X >= 54 && X <= 56 || X >= 59 && X <= 61 || X >= 64 && X <= 66 || X >= 71 && X <= 73) ||
           Y >= 35 && Y <= 37 && (X >= 26 && X <= 29 || X >= 38 && X <= 44 || X >= 50 && X <= 53 || X >= 67 && X <= 70) ||
           Y >= 40 && Y <= 42 && (X >= 26 && X <= 29 || X >= 40 && X <= 44 || X >= 50 && X <= 53) ||
           X >= 38 && X <= 44 && Y >= 45 && Y <= 47 ||
           X >= 42 && X <= 44 && Y >= 43 && Y <= 44)
                pixel_data = 16'b1111_1000_0000_0000;
                
    lives = 3'd2;
        if(lives >= 3'd2) begin
       if(((Y == 5 || Y == 9) && (X == 11 || X == 15)) || ((Y == 6 || Y == 8) && (X == 12 || X == 14)) 
    ||(Y == 7 && X == 13)) begin
    pixel_data = black;
    end
    end
    if(lives >= 3'd1) begin
           if(((Y == 5 || Y == 9) && (X == 17 || X == 21)) || ((Y == 6 || Y == 8) && (X == 18 || X == 20)) 
    ||(Y == 7 && X == 19)) begin
    pixel_data = black;
    end
    end
    
    if(COUNTER2 == 0) 
    page <= 6;
    end
    
    6'd18 : begin
    pixel_data = blue;
        if (Y >= 16 && Y <= 18 && (X >= 30 && X <= 40 || X >= 43 && X <= 52) ||
           Y >= 19 && Y <= 28 && (X >= 34 && X <= 36 || X >= 43 && X <= 45) ||
           Y >= 19 && Y <= 23 && X >= 50 && X <= 52 ||
           Y == 24 && X >= 47 && X <= 49 ||
           Y == 25 && X >= 48 && X <= 50 ||
           Y == 26 && X >= 49 && X <= 51 ||
           Y >= 27 && Y <= 28 && X >= 50 && X <= 52 ||
           X >= 55 && X <= 57 && Y >= 16 && Y <= 23 ||
           X >= 62 && X <= 64 && Y >= 16 && Y <= 28 ||
           Y >= 21 && Y <= 23 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
           Y >= 26 && Y <= 28 && X >= 55 && X <= 61 ||
           Y >= 35 && Y <= 47 && (X >= 23 && X <= 25 || X >= 30 && X <= 32 || X >= 35 && X <= 37 || X >= 47 && X <= 49 || X >= 54 && X <= 56 || X >= 59 && X <= 61 || X >= 64 && X <= 66 || X >= 71 && X <= 73) ||
           Y >= 35 && Y <= 37 && (X >= 26 && X <= 29 || X >= 38 && X <= 44 || X >= 50 && X <= 53 || X >= 67 && X <= 70) ||
           Y >= 40 && Y <= 42 && (X >= 26 && X <= 29 || X >= 40 && X <= 44 || X >= 50 && X <= 53) ||
           X >= 38 && X <= 44 && Y >= 45 && Y <= 47 ||
           X >= 42 && X <= 44 && Y >= 43 && Y <= 44)
                pixel_data = 16'b1111_1000_0000_0000;
                
    lives = 3'd1;
    if(lives >= 3'd1) begin
           if(((Y == 5 || Y == 9) && (X == 17 || X == 21)) || ((Y == 6 || Y == 8) && (X == 18 || X == 20)) 
    ||(Y == 7 && X == 19)) begin
    pixel_data = black;
    end
    end
    if(COUNTER2 == 0) 
    page <= 6;
    end
    
    6'd19: begin
    Max_holder = 0;
    pixel_data = blue;
    // good job 2
     if (Y >= 16 && Y <= 28 && (X >= 25 && X <= 27 || X >= 37 && X <= 39 || X >= 44 && X <= 46 || X >= 49 && X <= 51 || X >= 56 && X <= 58 || X >= 61 && X <= 63) ||
          X == 70 && (Y >= 17 && Y <= 27) ||
          Y >= 16 && Y <= 18 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 69) ||
          X >= 68 && X <= 69 && Y >= 19 && Y <= 28 ||
          Y >= 21 && Y <= 23 && (X >= 30 && X <= 34) ||
          Y >= 26 && Y <= 28 && (X >= 28 && X <= 34 || X >= 40 && X <= 43 || X >= 52 && X <= 55 || X >= 64 && X <= 67) ||
          Y >= 35 && Y <= 47 && (X >= 38 && X <= 40 || X >= 43 && X <= 45 || X >= 50 && X <= 52 || X >= 55 && X <= 57 || X >= 62 && X <= 63) ||
          X == 64 && (Y >= 36 && Y <= 40 || Y >= 42 && Y <= 46) ||
          Y >= 35 && Y <= 37 && (X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
          Y >= 40 && Y <= 42 && X >= 58 && X <= 61 ||
          Y >= 45 && Y <= 47 && (X >= 31 && X <= 37 || X >= 46 && X <= 49 || X >= 58 && X <= 61) ||
          Y >= 43 && Y <= 44 && X >= 31 && X <= 33 || 
          X >= 32 && X <= 34 && Y >= 24 && Y <= 25)
               pixel_data = 16'b1111_1000_0000_0000;
               
    if(COUNTER2 == 0) begin
    if(level == 2'd2) begin
    level = 2'd3;
    page <= 6;
    end
    else if (level == 2'd3) begin
    level = 2'd1;
    page <= 15;
    end
    else if (level == 2'd1) begin
    level = 2'd2;
    page <= 6;
    end
    end
    end
    
    
    endcase
    
    end // if sw10 is on
    end  //always clock
    
    
    
    
endmodule
