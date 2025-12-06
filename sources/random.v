`timescale 1ns / 1ps

/*
random number generator
module taken from ChatGPT
prompt: "verilog fpga random Linear Feedback Shift Register (LFSR)"

edited according to needs by Andrew Bargen <abargen@my.nnu.edu>

*/
/*
module random (
    input  wire clk,
    input  wire rst,
    output wire [2:0] out
);

    reg [7:0] intermediate;

    wire feedback = intermediate[7] ^ intermediate[5] ^ intermediate[4] ^ intermediate[3];

    always @(posedge clk or posedge rst) begin
        if (rst)
            intermediate <= 8'h1;          // LFSR must not start at zero
        else
            intermediate <= {intermediate[6:0], feedback};
    end

    assign out = intermediate[7:5]; // we need only three bits
*/


module random (
    input clk,
    input Mix_State,
    input ScrambleButton,
    output reg [31:0] RandBits = 'b11111111111111111111111111111111
);

wire [2:0] ThreeBitIncrement;


ThreeBitCounter c1 (.ScrambleButton(ScrammbleButton), .ThreeBitIncrement(ThreeBitIncrement));

always @(*) begin 

    if (Mix_State == 1'b1) begin
        if (ThreeBitIncrement == 'b000)
            RandBits = 'b11010011100110100100000111010101;
        else if (ThreeBitIncrement == 'b001)
            RandBits = 'b00100100111001010010101001001110;
        else if (ThreeBitIncrement == 'b011)
            RandBits = 'b11100011101010100111010110001101;
        else if (ThreeBitIncrement == 'b101)
            RandBits = 'b01010010010100100101001001010010;
        else if (ThreeBitIncrement == 'b100)
            RandBits = 'b10101001010101111111000001101010;
        else if (ThreeBitIncrement == 'b010)
            RandBits = 'b10011111101010100111100101010111;
        else if (ThreeBitIncrement == 'b111)
            RandBits = 'b11111000000111110000011111000010;
     end             
end



endmodule