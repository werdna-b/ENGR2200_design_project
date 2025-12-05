/*
random number generator
module taken from ChatGPT
prompt: "verilog fpga random Linear Feedback Shift Register (LFSR)"

edited according to needs by Andrew Bargen <abargen@my.nnu.edu>

*/

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

endmodule