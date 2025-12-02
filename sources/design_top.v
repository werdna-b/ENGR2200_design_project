`timescale 1ns / 1ps
module design_top(
   input btnU, //Rename accordingly
   input clk,
   output [11:0] rgb,
   output vsync, hsync
    );

    // TODO: wire up the switches to debounce and input (edge-detect)
    
    //Used by Video circuit
    wire [9:0] x, y;
    wire videoOn;
    wire [47:0] row1, row2, row3, row4;
    
    //For row/column select
    wire [3:0] row, column;
    
    row_col_input T1 (
    

    reg [31:0] display_state;

    x X1 ( .rst(rst), clk(clk), row_en(sw[0]), col_en(sw[0]), add_n(1), fire(btnC), load(2'b00), to_vdc(display_state[1:0]) );
    
    //Color decoders turn x signal into full color signal to display module
    color_decoder D1 ( .colorVec(display_state [7:0]), .fullColor(row1));    
    color_decoder D2 ( .colorVec(display_state [15:8]), .fullColor(row1));    
    color_decoder D3 ( .colorVec(display_state [23:16]), .fullColor(row1));    
    color_decoder D4 ( .colorVec(display_state [31:24]), .fullColor(row1));
    
    //Sync unit for timing stuff
    vga_sync S1 (.reset(btnU), .clk(clk), .x(x), .y(y), .video_on(videoOn), .hsync(hsync), .vsync(vsync)); 
    
    //display unit that actually prints the squares
    display U1 (.clk(clk), .x(x), .y(y), .video_on(videoOn), .x1(row1), .x2(row2), .x3(row3), .x4(row4), .rgb(rgb));

endmodule
