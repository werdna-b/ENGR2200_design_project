`timescale 1ns / 1ps


// This code was taken from Google Gemini and edited by Cohen Young

module ThreeBitCounter(
    input ScrambleButton, 
    output reg [2:0] count_out
    );
    
    always @(posedge ScrambleButton) begin
        count_out <= count_out + 3'b001;
 
end
    
    
    
endmodule
