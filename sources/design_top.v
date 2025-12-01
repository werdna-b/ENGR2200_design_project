`timescale 1ns / 1ps
module design_top(
    );

    // TODO: wire up the switches to debounce and input (edge-detect)

    reg [0:31] display_state;

    x( .rst(rst), clk(clk), row_en(sw[0]), col_en(sw[0]), add_n(1), fire(btnC), load(2'b00), to_vdc(display_state[0:1]) );

endmodule
