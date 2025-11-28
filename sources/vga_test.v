`timescale 1ns / 1ps
module vga_test
	(
    input wire clk, reset,
    input wire [15:0] sw,
    output wire hsync, vsync,
    output wire [11:0] rgb
);

    // register for Basys 2 8-bit RGB DAC 
    reg [11:0] rgb_reg;
    wire [9:0] x, y;

    // video status output from vga_sync to tell when to route out rgb signal to DAC
    wire video_on;

    // instantiate vga_sync
    vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
        .video_on(video_on), .p_tick(), .x(x), .y(y));

    // Display unit to print squares
    display D1 (.x(x), .y(y), .clk(clk), .rgb(rgb), .videoOn(video_on), .switches(sw));


    
endmodule
