`timescale 1ps/1ps

// output HIGH for the period after the button is pressed until the next clock posedge, unless the button is released.
// by Andrew Bargen, <abargen@my.nnu.edu>

module generic_input (
    input named_input, clk,
    output named_output
);
    reg last_input;

    always @(negedge clk) begin
        last_input <= named_input;
    end

    assign named_output = named_input * ~last_input;

    // to detect any edge, not just popsedge:
    //     assign named_output = named_input ^ last_input;

endmodule