`timescale 1ns / 1ps

module display(
    input [9:0] x, y,
    input [47:0] x1, x2, x3, x4,
    // input [15:0] switches, //For testing
    input clk, videoOn, error, 
    output reg [11:0] rgb
);
    wire red, green, blue;




    localparam xMax = 640;
    localparam yMax = 480;

    localparam cellWidth = 100;
    localparam borderY = 30;
    localparam borderX = 110;
    localparam gapWidth = 4;

    localparam gapColor = 12'h7FF;
    reg [11:0] borderColor;
    localparam borderColor_default = 12'h606;
    localparam borderColor_error = 12'hFFF;

    

    always @(*) begin
        if (error)
            borderColor = borderColor_error;
        else
            borderColor = borderColor_default;
    end


    //  localparam x1 = 48'hFF8FF0F8FF08;
    //  localparam x2 = 48'h08F89F7FEC6E;
    //  localparam x3 = 48'hF000FF00FF0F;
    //  localparam x4 = 48'hF0F0F0F0F0FF;


    always @(posedge clk) begin
        if (videoOn) begin

            if (y <= borderY)
                rgb =  borderColor;

            else if ( y <= borderY + gapWidth)
                if (x <= borderX)
                    rgb = borderColor;
                else if (x <= (borderX + 5*gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            else if ( y <= (borderY + gapWidth + cellWidth)) begin
                if ( x <= borderX )
                    rgb = borderColor;
                else if ( x <= (borderX + gapWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + gapWidth + cellWidth)) begin
                    rgb = x1[11:0];
                end
                else if ( x <= (borderX + 2 * gapWidth + cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 2 * gapWidth + 2 * cellWidth)) begin
                    rgb = x1[23:12];
                end
                else if ( x <= (borderX + 3 * gapWidth + 2 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 3 * gapWidth + 3 * cellWidth)) begin
                    rgb = x1[35:24];
                end
                else if ( x <= (borderX + 4 * gapWidth + 3 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 4 * gapWidth + 4 * cellWidth)) begin
                    rgb = x1[47:36];
                end
                else if ( x <= (borderX + 5 * gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            end

            else if (y <= (borderY + 2 * gapWidth + cellWidth))
                if (x <= borderX)
                    rgb = borderColor;
                else if (x <= (borderX + 5*gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            else if (y <= (borderY + 2*gapWidth + 2 * cellWidth)) begin
                if ( x <= borderX )
                    rgb = borderColor;
                else if ( x <= (borderX + gapWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + gapWidth + cellWidth)) begin
                    rgb = x2[11:0];
                end
                else if ( x <= (borderX + 2 * gapWidth + cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 2 * gapWidth + 2 * cellWidth)) begin
                    rgb = x2[23:12];
                end
                else if ( x <= (borderX + 3 * gapWidth + 2 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 3 * gapWidth + 3 * cellWidth)) begin
                    rgb = x2[35:24];
                end
                else if ( x <= (borderX + 4 * gapWidth + 3 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 4 * gapWidth + 4 * cellWidth)) begin
                    rgb = x2[47:36];
                end
                else if ( x <= (borderX + 5 * gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;
            end

            else if (y <= (borderY + 3 * gapWidth + 2 * cellWidth))
                if (x <= borderX)
                    rgb = borderColor;
                else if (x <= (borderX + 5*gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            else if (y <= (borderY + 3*gapWidth + 3 * cellWidth)) begin
                if ( x <= borderX )
                    rgb = borderColor;
                else if ( x <= (borderX + gapWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + gapWidth + cellWidth)) begin
                    rgb = x3[11:0];
                end
                else if ( x <= (borderX + 2 * gapWidth + cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 2 * gapWidth + 2 * cellWidth)) begin
                    rgb = x3[23:12];
                end
                else if ( x <= (borderX + 3 * gapWidth + 2 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 3 * gapWidth + 3 * cellWidth)) begin
                    rgb = x3[35:24];
                end
                else if ( x <= (borderX + 4 * gapWidth + 3 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 4 * gapWidth + 4 * cellWidth)) begin
                    rgb = x3[47:36];
                end
                else if ( x <= (borderX + 5 * gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;
            end

            else if (y <= (borderY + 4*gapWidth + 3 * cellWidth))
                if (x <= borderX)
                    rgb = borderColor;
                else if (x <= (borderX + 5*gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            else if (y <= (borderY + 4*gapWidth + 4 * cellWidth)) begin
                if ( x <= borderX )
                    rgb = borderColor;
                else if ( x <= (borderX + gapWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + gapWidth + cellWidth)) begin
                    rgb = x4[11:0];
                end
                else if ( x <= (borderX + 2 * gapWidth + cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 2 * gapWidth + 2 * cellWidth)) begin
                    rgb = x4[23:12];
                end
                else if ( x <= (borderX + 3 * gapWidth + 2 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 3 * gapWidth + 3 * cellWidth)) begin
                    rgb = x4[35:24];
                end
                else if ( x <= (borderX + 4 * gapWidth + 3 * cellWidth))
                    rgb = gapColor;
                else if ( x <= (borderX + 4 * gapWidth + 4 * cellWidth)) begin
                    rgb = x4[47:36];
                end
                else if ( x <= (borderX + 5 * gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;
            end

            else if (y <= (borderY + 5*gapWidth + 4 * cellWidth))
                if (x <= borderX)
                    rgb = borderColor;
                else if (x <= (borderX + 5*gapWidth + 4 * cellWidth))
                    rgb = gapColor;
                else
                    rgb = borderColor;

            else
                rgb = borderColor;
        end


        else begin
            rgb = 12'h000;
        end

    end





endmodule
