`timescale 1ps/1ps

// output HIGH for the period after the button is pressed until the next clock posedge
// by Andrew Bargen, <abargen@my.nnu.edu>

module generic_input (
    input named_input, clk,
    output named_output
);
    reg last_input;

    always @(posedge clk) begin
        last_input <= named_input;
    end

    assign named_output = named_input * ~last_input;

endmodule