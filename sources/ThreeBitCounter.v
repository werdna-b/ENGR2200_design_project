`timescale 1ns / 1ps

//There was something written by Google Gemini at some point in her but I pretty much replaced it all - CY
module ThreeBitCounter(
    input ScrambleButton,
    output reg [2:0] ThreeBitIncrement
);

    always @(posedge ScrambleButton) begin
        ThreeBitIncrement <= ThreeBitIncrement + 3'b001;

    end



endmodule
