`timescale 1ns / 1ps

module color_decoder(
    input [7:0] colorVec,
    input clk,
    output [47:0] fullColor
);

    parameter color1 = 12'hF00; //Red 
    parameter color2 = 12'h0F0; //Green 
    parameter color3 = 12'h00F; //Blue 
    parameter color4 = 12'hFF0; //Yellow - Hopefully

    always @(*) begin

        case (colorVec [1:0])
            00: fullColor [11:0] = color1;
            01: fullColor [11:0] = color2;
            10: fullColor [11:0] = color3;
            11: fullColor [11:0] = color4;
        endcase

        case (colorVec [3:2])
            00: fullColor [23:12] = color1;
            01: fullColor [23:12] = color2;
            10: fullColor [23:12] = color3;
            11: fullColor [23:12] = color4;
        endcase
        
        case (colorVec [5:4])
            00: fullColor [35:24] = color1;
            01: fullColor [35:24] = color2;
            10: fullColor [35:24] = color3;
            11: fullColor [35:24] = color4;
        endcase
        
        case (colorVec [7:6])
            00: fullColor [47:36] = color1;
            01: fullColor [47:36] = color2;
            10: fullColor [47:36] = color3;
            11: fullColor [47:36] = color4;
        endcase


    end




endmodule
