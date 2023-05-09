`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2020 04:00:45 PM
// Design Name: 
// Module Name: oledvbar
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


module oledvbar( 
    input CLOCK,
    input [15:0] sw, 
    input [12:0] pixel_index,
    output reg [15:0] pixel_data,
    input [11:0] Max,
    input idle_state,
    input [3:0] seasonstate,
    input [2:0] name
    );
    
    wire [7:0] Y;
    wire [7:0] X;
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
    
    
    reg [3:0] winter = 4'b0001;
    reg [3:0] spring = 4'b0010;
    reg [3:0] summer = 4'b0100;
    reg [3:0] autumn = 4'b1000;
    
    
    assign Y = pixel_index/96;
    assign X = pixel_index % 96;


    always @ (posedge CLOCK) begin
    
     if(sw[6] == 0) begin
     Max_holder = Max;
     end 
    
    // if sw[6] is on, it will freeze the value of Max_holder so the bars will freeze
    
    if(sw[10] == 0) begin
    if (idle_state == 0) begin
    
    if(sw[4] == 1 && sw[5] == 0) begin
        pixel_data = 16'b1111111111111111; //White
    end
    else begin
    pixel_data = 16'b0000000000000000; //Black
    end
    
     
    if((X >= 39 && X<=56) && sw[3] == 1) begin //bar of colors + if sw[3] is on
                // top 5 high value bar chunks
                // remember to include threshold values for each bar
       if((Y>=8 && Y<= 9 && Max_holder >= 12'd3920) 
       || (Y>=11 && Y<= 12 && Max_holder >= 12'd3790) 
       || (Y>=14 && Y<=15 && Max_holder >= 12'd3660) 
       || (Y>=17 && Y<=18 && Max_holder >= 12'd3530) 
       || (Y>=20 && Y<=21 && Max_holder >= 12'd3400)) begin //5 bars of 2 height each 
          if (sw[4] == 0 && sw[5] == 0) begin
             pixel_data = 16'b1111100000000000; //red , colorscheme 1
           end
          else if (sw[4] == 1 && sw[5] == 0) begin
              pixel_data = 16'b0000000000000011; //blue? colorscheme 2
           end
           else if (sw[4] == 1 && sw[5] == 1) begin
              pixel_data = 16'b1101100000100000; // dark red? colorscheme 3
           end
                              
       end
      if((Y>=23 && Y<=24 && Max_holder >= 12'd3270) 
      || (Y>=26 && Y<=27 && Max_holder >= 12'd3140) 
      || (Y>=29 && Y<=30 && Max_holder >= 12'd3010) 
      || (Y>= 32 && Y<=33 && Max_holder >= 12'd2880) 
      || (Y>=35 && Y<=36 && Max_holder >= 12'd2750)) begin
            if (sw[4] == 0 && sw[5] == 0) begin
                pixel_data = 16'b1111111111000000; //yellow , colorscheme 1
             end
             else if (sw[4] == 1 && sw[5] == 0) begin
                pixel_data = 16'b0000000000001111; // lighter blue colorscheme 2
             end
             else if (sw[4] == 1 && sw[5] == 1) begin
                pixel_data = 16'b1111001010100001; // red colorscheme 3
             end
                          
       end
       if((Y>=38 && Y<=39 && Max_holder >= 12'd2620) 
       || (Y>=41 && Y<=42 && Max_holder >= 12'd2490) 
       || (Y>=44 && Y<=45 && Max_holder >= 12'd2360) // 3
       || (Y>=47 && Y<=48 && Max_holder >= 12'd2230) // 2
       || (Y>=50 && Y<=51 && Max_holder >= 12'd2100) // 1
       ||(Y>=53 && Y<=54 && Max_holder >= 12'd0)) begin // 0
             if (sw[4] == 0 && sw[5] == 0) begin
                  pixel_data = 16'b0000000111000000; //green , colorscheme 1
             end
             else if (sw[4] == 1 && sw[5] == 0) begin
                   pixel_data = 16'b0000000000111111; // lightest blue colorscheme 2
              end
              else if (sw[4] == 1 && sw[5] == 1) begin
                   pixel_data = 16'b1111010010000001; //  brightest orange colorscheme 3
               end
                       
         end
            
    end
    if(X == 0 || X == 95 || Y == 0 || Y == 63) begin 
        if(sw[1] == 1) begin
            if(sw[4] == 1 && sw[5] == 0) begin
            pixel_data = 16'b0000011111111111; //cyan border?
            end
            else if(sw[4] == 1 && sw[5] == 1) begin
                pixel_data = 16'b1111111111000000; //yellow border
            end
            else begin
            pixel_data = 16'b1111111111111111; //white colorscheme 1
            end
        end
    end
        //end
    if(Y == 1 || Y == 2 || X == 1 || X == 2 || Y == 62 || Y == 61 || X == 93 || X == 94) begin 
        if(sw[1] == 1 && sw[2] == 1) begin
           if(sw[4] == 1 && sw[5] == 0) begin
                pixel_data = 16'b0000011111111111; //cyan border
            end
            else if(sw[4] == 1 && sw[5] == 1) begin
                pixel_data = 16'b1111111111000000; // yellow border
             end
            else begin
            pixel_data = 16'b1111111111111111; //white colorscheme 1
            end
        end
    end
    
        if (sw[0] == 1 && sw[7] == 1) begin
            case (name)
                3'b000: //A
                begin
                    if (Y >= 7 && Y <= 16 && (X == 7 || X == 8 || X == 12 || X == 13) ||
                    X >= 9 && X <= 11 && (Y == 7 || Y == 8 || Y == 11 | Y == 12)) begin
                        if (sw[8] == 1)
                            pixel_data = 16'b0000_0000_0001_1111; //Blue
                        else if (sw[8] == 0)
                            pixel_data = 16'b1111_1000_0000_0000; //Red
                    end
                    if (sw[9] == 1) begin
                        if (X == 14 && Y >= 7 && Y <= 17 ||
                        Y == 17 && (X >= 7 && X <= 9 || X >= 12 && X <= 13) ||
                        X == 9 && (Y >= 9 && Y <= 10 || Y >= 13 && Y <= 16) ||
                        X >= 10 && X <= 11 && (Y == 9|| Y == 13)) begin //Shadow
                            if (sw[4] == 1 && sw[5] == 0) //White background
                                pixel_data = 16'b0000_0000_0000_0000; //Black Shadow
                            else
                                pixel_data = 16'b1111_1111_1111_1111; //White Shadow
                        end
                    end
                end
                
                3'b001: //b
                begin
                    if (Y >= 7 && Y <= 16 && (X == 7 || X == 8) ||
                    X >= 9 && X <= 11 && (Y == 11 || Y == 12 || Y == 15 | Y == 16) ||
                    Y >= 11 && Y <= 16 && (X == 12 || X == 13)) begin
                        if (sw[8] == 1)
                            pixel_data = 16'b0000_0000_0001_1111; //Blue
                        else if (sw[8] == 0)
                            pixel_data = 16'b1111_1000_0000_0000; //Red
                    end
                    if (sw[9] == 1) begin
                        if (Y == 17 && X >= 7 && X <= 14 ||
                        X == 14 && Y >= 11 && Y <= 16 ||
                        X == 9 && (Y >= 7 && Y <= 10 || Y >= 13 && Y <= 14) ||
                        Y == 13 && X >= 10 && X <= 11) begin //Shadow
                            if (sw[4] == 1 && sw[5] == 0) //White background
                                pixel_data = 16'b0000_0000_0000_0000; //Black Shadow
                            else
                                pixel_data = 16'b1111_1111_1111_1111; //White Shadow
                       end     
                    end
                end
                
                3'b10: //C
                begin
                    if (Y >= 7 && Y <= 16 && (X == 7 || X == 8) ||
                    X >= 9 && X <= 13 && (Y == 7 || Y == 8 || Y == 15 | Y == 16)) begin
                        if (sw[8] == 1)
                            pixel_data = 16'b0000_0000_0001_1111; //Blue
                        else if (sw[8] == 0)
                            pixel_data = 16'b1111_1000_0000_0000; //Red
                    end
                    if (sw[9] == 1) begin
                        if (Y == 17 && X >= 7 && X <= 14 ||
                        X == 9 && Y >= 9 && Y <= 14 ||
                        Y == 9 && X >= 10 && X <= 14 ||
                        X == 14 && (Y >= 7 && Y <= 8 || Y >= 15 && Y <= 16)) begin //Shadow
                            if (sw[4] == 1 && sw[5] == 0) //White background
                                pixel_data = 16'b0000_0000_0000_0000; //Black Shadow
                            else
                                pixel_data = 16'b1111_1111_1111_1111; //White Shadow
                        end
                    end
                end
                
                3'b011: //d
                begin
                    if (Y >= 7 && Y <= 16 && (X == 12 || X == 13) ||
                    X >= 9 && X <= 11 && (Y == 11 || Y == 12 || Y == 15 | Y == 16) ||
                    Y >= 11 && Y <= 16 && (X == 7 || X == 8)) begin
                        if (sw[8] == 1)
                            pixel_data = 16'b0000_0000_0001_1111; //Blue
                        else if (sw[8] == 0)
                            pixel_data = 16'b1111_1000_0000_0000; //Red
                    end
                    if (sw[9] == 1) begin
                        if (X == 14 && Y >= 7 && Y <= 17 ||
                        Y == 17 && X >= 7 && X <= 13 ||
                        X == 9 && Y >= 13 && Y <= 14 ||
                        Y == 13 && X >= 10 && X <= 11) begin //Shadow
                        if (sw[4] == 1 && sw[5] == 0) //White background
                            pixel_data = 16'b0000_0000_0000_0000; //Black Shadow
                        else
                            pixel_data = 16'b1111_1111_1111_1111; //White Shadow
                        end        
                    end
                end
                
                3'b100: //E
                begin
                    if (Y >= 7 && Y <= 16 && (X == 7 || X == 8) ||
                    X >= 9 && X <= 13 && (Y == 7 || Y == 8 || Y == 11 || Y == 12 || Y == 15 | Y == 16)) begin
                        if (sw[8] == 1)
                            pixel_data = 16'b0000_0000_0001_1111; //Blue
                        else if (sw[8] == 0)
                            pixel_data = 16'b1111_1000_0000_0000; //Red
                    end
                    if (sw[9] == 1) begin
                        if (Y == 17 && X >= 7 && X <= 14 ||
                        X == 14 && (Y >= 7 && Y <= 9 || Y >= 11 && Y <= 13 || Y >= 15 && Y <= 16) ||
                        X == 9 && (Y >= 9 && Y <= 10 || Y >= 13 && Y <= 14) ||
                        X >= 10 && X <= 13 && (Y == 9 || Y == 13)) begin//Shadow
                            if (sw[4] == 1 && sw[5] == 0) //White background
                                pixel_data = 16'b0000_0000_0000_0000; //Black Shadow
                            else
                                pixel_data = 16'b1111_1111_1111_1111; //White Shadow
                        end
                    end
                end
                
            endcase

    end
    
    end // if idle_state == 0
    else begin // idlestate == 1
    
    //sky color
    if(seasonstate == spring) begin
    pixel_data = darkpink; 
    end
    else if(seasonstate == summer) begin
    pixel_data = blue;
    end
    else if(seasonstate == autumn) begin
    pixel_data = red;
    end
    else if(seasonstate == winter) begin
    pixel_data = cyan;
    end
    
    //ground
    
    if(Y == 62 || Y == 63) begin
    pixel_data = brown;
    end
    
    // outline of tree start
    if(Y == 61 || ( (X == 56 || X == 40) && Y >= 39 && Y<= 60) || ( (X == 46 || X == 50) && Y>= 26 && Y<=39)
    || ((X == 47 || X == 48 || X == 49) && Y == 25)) begin
    pixel_data = black; 
    end
    
    if((Y == 39 && (X == 39 || X == 45 || X == 51 || X == 57)) || (Y == 38 && ( X == 38 || X == 44 || X == 52 || X == 58)) 
    || (Y == 37 && (X == 37 || X == 43 || X == 53 || X == 59)) || (Y == 36 && (X == 36 || X == 42 || X == 54 || X == 60)) 
    || (Y == 35 && (X == 35 || X == 41 || X == 55 || X == 61)) || (Y == 34 && (X == 34 || X == 40 || X == 56 || X == 62))
    || (Y == 33 && (X == 33 || X == 39 || X == 57 || X == 63)) || (Y == 32 && (X == 32 || X == 38 || X == 58 || X == 64)) 
    || (Y == 31 && (X == 31 || X == 37 || X == 59 || X == 65)) || (Y == 30 && (X == 30 || X == 36 || X == 60 || X == 66)))
    begin
    pixel_data = black;
    end
    
    if((Y == 29 && (X == 35 || X == 30 || X == 61 || X == 66)) || (Y == 28 && (X == 34 || X == 31 || X == 62 || X == 65)) 
    || (Y == 27 && (X == 33 || X == 32 || X == 63 || X == 64))) begin
    pixel_data = black;
    end
    
    // leaves outline
    if(seasonstate != winter) begin
    if((Y == 8 && (X >= 44 && X<= 52)) || (Y == 9 && ((X >= 53 && X<= 56)||(X >= 40 && X<= 43))) || (Y == 10 && (X == 38 || X == 39 || X == 57 || X == 58))
    || (Y == 11 && (X == 36 || X == 37 || X == 59 || X == 60))
    || (Y == 12 && (X == 35 || X == 61)) || (Y == 13 && (X == 34 || X == 62)) || (Y == 14 && (X == 33 || X == 63))
    || (Y == 15 && (X == 32 || X == 64)) || (Y == 16 && (X == 31 || X == 65)) || (Y == 17 && (X == 30 || X == 66)) 
    || (Y == 18 && (X == 30 || X == 66)) || (Y == 19 && (X == 29 || X == 67)) || (Y == 20 && (X == 28 || X == 68)))
    begin
    pixel_data = black;
    end
    
    if((X == 28 && (Y == 21 || Y == 22)) || (X == 68 && (Y == 21 || Y == 22)) 
    || (X == 27 && (Y>= 23 && Y <= 31)) || (X == 69 && (Y >= 23 && Y <= 31)) 
    || (X == 28 && (Y>= 32 && Y <= 34)) || (X == 68 && (Y >= 32 && Y<= 34)) 
    || (Y == 35 && (X == 29 || X == 67)) 
    || (X == 30 && (Y == 36 || Y == 37)) || (X == 66 && (Y == 36 || Y == 37)))
    begin
    pixel_data = black;
    end
    
    if (( Y == 38 && (X == 31 || X == 65)) || (Y == 39 &&(X == 32 || X == 64)) || (Y == 40 && (X == 33 || X == 63))
    || ( Y == 41 && (X == 34 || X == 62)) || (Y == 42 && (X == 35 || X == 61)) || (Y == 43 && (X == 36 || X == 60)) 
    || ( Y == 43 && (X == 37 || X == 59)) || (Y == 44 && (X == 57 || X == 58)) || (Y == 44 && (X == 38 || X == 39)))
    begin
    pixel_data = black;
    end
    // outline of tree end
    end // if not winter
    
    if(seasonstate == spring) begin
    //flowers
    if(((X == 22 || X == 74) && ((Y >= 57 && Y<= 60))))
    begin
    pixel_data = lightbrown; //brown stalk
    end
    
    if ((Y == 56 && (X == 21 || X == 23 || X == 73 || X == 75)) 
    || (Y == 55 && (X == 20 || X == 24 || X == 72 || X == 76)) || (Y == 57 && (X==20 || X == 24 || X == 72 || X == 76))
    || ((X == 22 || X == 74) && (Y == 55)))
    begin
    pixel_data = pink; // petals
    end
    
    if((X == 22 || X == 74) && Y == 56)
    begin
    pixel_data = yellow; // yellow middle of flower
    end
    
    end // if spring
    
    if(seasonstate == winter) begin
    //winter
    if(((Y == 23 || Y == 25) && (X == 8 || X == 10)) || ( X == 9 && Y == 24) 
    || ((Y == 26 || Y == 28) && (X == 18 || X == 20)) || ( X == 19 && Y == 27)
    || ((Y == 30 || Y == 32) && (X == 12 || X == 14)) || (X == 13 && Y == 31) //left snowflakes
    || ((Y == 15 || Y == 17) && (X == 78 || X == 80)) || (X == 79 && Y == 16)
    || ((Y == 19 || Y == 21) && (X == 89 || X == 91)) || (X == 90 && Y == 20)
    || ((Y == 27 || Y == 29) && (X == 83 || X == 85)) || (X == 84 && Y == 28))
    begin
    pixel_data = white;
    end
    end // end winter
    
    
    // sun outline
    if(((Y == 6 || Y == 16) && (X>= 11 && X<= 15)) || ((X == 8 || X == 18) && (Y >= 9 && Y<= 13)) 
    || (Y == 7 && (X == 10 || X == 16)) || (Y == 8 && (X == 9 || X == 17)) 
    || (Y == 14 && (X == 9 || X == 17)) || (Y == 15 && (X == 10 || X == 16))
    || (X == 13 && (Y == 2 || Y == 3 || Y == 4 || Y == 18 || Y == 19 || Y == 20)) 
    || (Y == 11 && (X == 4 || X == 6 || X == 5 || X == 20 || X == 21 || X == 22)) 
    || (X == 6 && (Y == 4 || Y == 18)) || (X == 7 &&(Y == 5 || Y == 17)) || (X == 8 && (Y == 6 || Y == 16))
    || (X == 18 && (Y == 16 || Y == 6)) || ( X == 19 && (Y == 17 || Y == 5)) || (X == 20 && (Y == 18 || Y == 4)))
    begin
    pixel_data = black;
    end
    
    if(seasonstate != winter)begin
    //leaves colored
    if(((X == 28 || X == 68) && (Y >= 23 && Y <= 31)) || ((X == 29 || X == 67) && (Y>=20 && Y<= 34))
    || ((X == 30 || X == 66 ) && ((Y>= 19 && Y <= 28 ) || (Y>= 31 && Y<= 35 ))) 
    || ((X == 31 || X == 65 ) && ((Y>= 17 && Y <= 27 ) || (Y>= 32 && Y<=37  )))
    || ((X == 32 || X == 64 ) && ((Y >= 16 && Y <= 26) || (Y >= 33 && Y<= 38)))
    || ((X == 33 || X == 63  ) && ((Y >= 15 && Y <= 26 ) || (Y >= 34  && Y <= 39 )))
    || ((X == 34 || X == 62 ) && ((Y >= 14 && Y <= 27) || (Y >= 35 && Y <= 40 )))
    || ((X == 35 || X == 61 ) && ((Y >= 13 && Y <= 28) || (Y >= 36 && Y <= 41 )))
    || ((X == 36 || X == 60 ) && ((Y >= 12 && Y <= 29 ) || (Y >= 37 && Y <= 42 ))) 
    || ((X == 37 || X == 59 ) && ((Y >= 12 && Y <= 30 ) || (Y >= 38 && Y <= 42 )))
    || ((X == 38 || X == 58 ) && ((Y >= 11 && Y <= 31 ) || (Y >= 39 && Y <= 43 )))
    || ((X == 39 || X == 57 ) && ((Y >= 11 && Y <= 32 ) || (Y >= 40 && Y <= 43 )))
    || ((X == 40 || X == 56 ) && (Y >= 10 && Y <= 33 ))
    || ((X == 41 || X == 55 ) && (Y >= 10 && Y <= 34 ))
    || ((X == 42 || X == 54 ) && (Y >= 10 && Y <= 35 ))
    || ((X == 43 || X == 53 ) && (Y >= 10 && Y <= 36 ))
    || ((X == 44 || X == 52 ) && (Y >= 9 && Y <= 37 ))
    || ((X == 45 || X == 51 ) && (Y >= 9 && Y <= 38 ))
    || ((X == 46 || X == 50 ) && (Y >= 9 && Y <= 25 ))
    || ((X == 47 || X == 49 ) && (Y >= 9 && Y <= 24 ))
    || ((X == 48) && (Y >= 9 && Y <= 24 )))
    begin
    
        if(seasonstate == summer) begin
        pixel_data = green;
        end
        else if(seasonstate == spring) begin
        pixel_data = pink;
        end
        else if(seasonstate == autumn) begin
        pixel_data = orange ;
        end
        

    end
    end
    
    if(((X == 31 || X == 65 ) && (Y >= 29 && Y <= 30 ))
    || ((X == 32 || X == 64 ) && (Y >= 28 && Y <= 31 ))
    || ((X == 33 || X == 63 ) && (Y >= 28 && Y <= 32 ))
    || ((X == 34 || X == 62 ) && (Y >= 29 && Y <= 33 ))
    || ((X == 35 || X == 61 ) && (Y >= 30 && Y <= 34 ))
    || ((X == 36 || X == 60 ) && (Y >= 31 && Y <= 35 ))
    || ((X == 37 || X == 59 ) && (Y >= 32 && Y <= 36 ))
    || ((X == 38 || X == 58 ) && (Y >= 33 && Y <= 37 ))
    || ((X == 39 || X == 57 ) && (Y >= 34 && Y <= 38 ))
    || ((X == 40 || X == 56 ) && (Y >= 35 && Y <= 38 ))
    || ((X == 41 || X == 55 ) && (Y >= 36 && Y <= 39 ))
    || ((X == 42 || X == 54 ) && (Y >= 37 && Y <= 39 ))
    || ((X == 43 || X == 53 ) && (Y >= 38 && Y <= 39 ))
    || ((X == 44 || X == 52 ) && Y == 39))
    begin
    pixel_data = lightbrown; //brown
    end
    
    // trunk and mid branch
    if(((X >= 47 && X <= 49) && (Y >= 26 && Y <= 39)) 
    || ((X >= 41 && X <= 55) && (Y >= 40 && Y <= 60)))
    begin
    pixel_data = lightbrown; //brown
    end
    
    //sunfill in
    if(((X == 9 || X == 17 ) && (Y >= 9 && Y <= 13 ))
    || ((X == 10 || X == 16 ) && (Y >= 8 && Y <= 14 ))
    || ((X == 11 || X == 15 ) && (Y >= 7 && Y <= 15 ))
    || ((X == 12 || X == 14 ) && (Y >= 7 && Y <= 15 ))
    || (X == 13  && (Y >= 7 && Y <= 15 )))
    begin
    pixel_data = yellow; //yellow
    end
    
    if(seasonstate == autumn) begin
    if((Y == 7 && ((X >= 24 && X <= 28) || (X >= 67 && X <= 71))) 
    || (Y == 5 && (X == 24 || X == 28 || X == 67 || X == 71)) 
    || (Y == 6 && (X == 25 || X == 27 || X == 68 || X == 70))
    || (Y == 35 && (X >= 18 && X <= 22)) || (Y == 33 && (X == 18 || X == 22)) || (Y == 34 && (X == 19 || X == 21))
    || (Y == 27 && (X >= 74 && X <= 78)) || (Y == 25 && (X == 74 || X == 78)) || (Y == 26 && (X == 75 || X == 77))
    || (Y == 46 && (X >= 3 && X <= 7)) || (Y == 44 && (X == 3 || X == 7)) || (Y == 45 && (X == 4 || X == 6))
    || (Y == 48 && (X >= 84 && X <= 88)) || (Y == 46 && (X == 84 || X == 88)) || (Y == 47 && (X == 85 || X == 87)))
     begin
    pixel_data = black;
    end
    end
    
    if(seasonstate == winter) begin
    if(((X == 9 || X == 11 || X == 73 || X == 75) && (Y == 35 || Y == 37)) 
    || ((X == 10 || X == 74) && Y == 36)
    || ((X == 17 || X == 19 || X == 82 || X == 84) && (Y == 39 || Y == 41))
    || ((X == 18 || X == 83) && Y == 40)
    || ((X == 12 || X == 14 || X == 73 || X == 75) && (Y == 45 || Y == 47))
    || ((X == 13 || X == 74) && Y == 46))
    begin
    pixel_data = white;
    end
    end
    
    if(seasonstate == summer) begin
    if(((X == 24 || X == 25) && (Y >= 50 && Y <= 54)) 
    || ((X >= 25 && X <= 29) && (Y >= 49 && Y <= 50))
    || ((X >= 26 && X <= 28) && Y == 54)
    || (X == 29 && (Y >= 51 && Y <= 53))
    || ((X == 27 || X == 35) && (Y >= 55 && Y <= 59))
    || (Y == 57 && ((X >= 25 && X <= 29) || ( X >= 33 && X <= 37)))
    || ((X == 26 || X == 28 || X == 34 || X == 36) && (Y == 59 || Y == 60)))
    begin
    pixel_data = black;
    end
    
    //white face
    if(((X >= 26 && X <= 28) || (X >= 34 && X <= 36)) && (Y >= 51 && Y <= 53))
    begin
    pixel_data = white;
    end
    
    if(((X == 33 || X == 37) && (Y >= 51 && Y <= 53))
    || ((X >= 34 && X <= 36) && (Y == 50 || Y == 54)))
    begin
    pixel_data = black;
    end
    
    if((X == 33 && Y == 50) || ((X >= 34 && X <= 37) && Y == 49)
    || ((X == 37 || X == 38) && (Y == 50))
    || (X == 38 && ( Y >= 51 && Y <= 57)) 
    || (X == 37 && (Y >= 54 && Y <= 56)))
    begin
    pixel_data = red;
    end
    end
    
    
    
    end
    
    end //if switch 10 is on
    end//always
    
endmodule
