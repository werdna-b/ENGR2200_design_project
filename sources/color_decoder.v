`timescale 1ns / 1ps

module color_decoder(
    input [7:0] colorVec,
    input color_shift,
    output reg [47:0] fullColor
);
    reg [11:0] color1, color2, color3, color4;

    parameter color1_a = 12'hF00; //Red 
    parameter color2_a = 12'h0F0; //Green 
    parameter color3_a = 12'h00F; //Blue 
    parameter color4_a = 12'hFF0; //Yellow - Hopefully

    parameter color1_b = 12'h0FF; //cyan
    parameter color2_b = 12'hF0F; //magenta
    parameter color3_b = 12'hFF0; //yellow
    parameter color4_b = 12'h08C; //weird purple

    always @(*) begin
        if (color_shift) begin
            color1 = color1_b;
            color2 = color2_b;
            color3 = color3_b;
            color4 = color4_b;
        end
        else begin
            color1 = color1_a;
            color2 = color2_a;
            color3 = color3_a;
            color4 = color4_a;
        end
    end




    always @(*) begin

        case (colorVec [1:0])
            2'b00: fullColor [11:0] = color1;
            2'b01: fullColor [11:0] = color2;
            2'b10: fullColor [11:0] = color3;
            2'b11: fullColor [11:0] = color4;
        endcase

        case (colorVec [3:2])
            2'b00: fullColor [23:12] = color1;
            2'b01: fullColor [23:12] = color2;
            2'b10: fullColor [23:12] = color3;
            2'b11: fullColor [23:12] = color4;
        endcase

        case (colorVec [5:4])
            2'b00: fullColor [35:24] = color1;
            2'b01: fullColor [35:24] = color2;
            2'b10: fullColor [35:24] = color3;
            2'b11: fullColor [35:24] = color4;
        endcase

        case (colorVec [7:6])
            2'b00: fullColor [47:36] = color1;
            2'b01: fullColor [47:36] = color2;
            2'b10: fullColor [47:36] = color3;
            2'b11: fullColor [47:36] = color4;
        endcase


    end




endmodule
