`timescale 1ps/1ps

// Debounce the input
// takes the BASYS 3 (6MHz?) clock signal
// by Andrew Bargen <abargen@my.nnu.edu>

// this is almost identical to the diagram in debounce_state_machine.jpg (Lambert) 
// except it only transitions back to A (equal) when the counter increments. This
// might be faster (less delay).

module generic_debounce (
    input reset,
    input clk,
    input named_btn,
    output reg named_out
);

    parameter count = 3000000 // half a second at 6MHz
    parameter count_wires = 22 // = ceiling(log2(count))
    parameter equal = 1'b0, changed = 1'b1;
    reg state;
    reg [count_wires-1:0] counter;


    always @(posedge clk) begin
        if (reset) begin
            state <= equal;
            named_out <= named_btn; // optional, can comment this line for different behavior
        end
        //else if (named_btn == named_out) state <= equal; 
        // don't to this ^^ because
        // we only enter this state (equal) after the counter successfully increments to count
        // what if it goes equal again?
        else if (named_btn != named_out) state <= changed;
    end

    always @(posedge clk) begin
        if (state == changed) begin
            counter <= counter + 1;
            if (counter == count) begin
                state <= equal; // reset everything
                counter <= 0;
                if (named_btn != named_out) named_out <= named_btn; // if they're not equal, make them equal
            end
        end
    end

    
endmodule