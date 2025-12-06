`timescale 1ps/1ps

// Debounce the input
// takes the BASYS 3 100 MHz clock signal
// by Andrew Bargen <abargen@my.nnu.edu>

// this is almost identical to the diagram in debounce_state_machine.jpg (Lambert) 
// except it only transitions back to A (equal) when the counter increments. This
// might be faster (less delay).

module generic_debounce # ( parameter count = 17'd1000000, parameter count_wires = 17 ) (
    input reset,
    input clk,
    input named_btn,
    output reg named_out
   // output wire [count_wires-1:0] count_out,
   // output wire state_out
);
    wire [count_wires-1:0] count_out;
    wire state_out;
    
    // parameter count = 17'd100000; // half a second at 100MHz
    // parameter count_wires = 17; // = ceiling(log2(count))
    parameter equal = 1'b0, changed = 1'b1;
    reg state, next_state;
    reg [count_wires-1:0] counter;


    always @(*) begin
        if (reset) begin
            next_state = equal;
            named_out <= named_btn; // optional, can comment this line for different behavior
        end
        else if ((named_btn != named_out) | (state == changed)) begin
            if (counter != count) next_state = changed;
            else begin
                next_state = equal;
                if (named_btn != named_out) named_out = named_btn;
            end
        end

        else next_state = equal;

    end


    always @(posedge clk) begin
        state <= next_state;
        if (state == changed) counter <= counter + 1;
        else counter <= 0;

    end

    assign count_out = counter;
    assign state_out = state;

    
endmodule