`timescale 1ns / 1ps
module design_top(
    input clk, reset, fireBtn, //Buttons need to be debounced --reset is btnC, fire is btnU
    input [3:0] row_column_raw_nodebounce, //Need this to be debounced --Switches 1-4
    input nRow, //low if row is selected //Needs to be debounced to nRow_debounced --Switch 6
    output [11:0] rgb,
    output vsync, hsync, error
    // output [47:0] r1, r2, r3, r4,
    // output [31:0] d_out,
    // output reg [3:0] row_out, col_out
);

    // TODO: wire up the switches to debounce and input (edge-detect)


    //X module wires
    wire [31:0] display_state;
    wire fire_debounced, addn_debounced, nRow_debounced;



    // assign row_column_raw = row_column_raw_nodebounce;


    //Used by Video circuit
    wire [9:0] x, y;
    wire videoOn;
    wire [47:0] row1, row2, row3, row4;

    //For row/column select
    reg [3:0] row, col;
    wire [3:0] row_column;


    assign nRow_debounced = nRow;
    generic_debounce( .clk(clk), .reset(reset), .named_btn(fireBtn), .named_out(fire_debounced) );
    //Error checking to make sure only one flip is switched
    row_col_input R1 ( .sw(row_column_raw_nodebounce), .error(error), .out(row_column), .clk(clk));

    //Row or column select
    always @(*) begin
        if (error) begin
            col = 4'b000;
            row = 4'b000;
        end
        else begin
            if (!nRow_debounced) begin
                row = row_column;
                col = 4'b0000;
            end
            else begin
                col = row_column;
                row = 4'b0000;
            end
        end
    end



    //First row of cells
    x X1 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[1:0]) );
    x X2 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[3:2]) );
    x X3 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[5:4]) );
    x X4 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[7:6]) );

    //second row
    x X5 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[9:8]) );
    x X6 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[11:10]) );
    x X7 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[13:12]) );
    x X8 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[15:14]) );

    //third row
    x X9 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[17:16]) );
    x X10 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[19:18]) );
    x X11 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[21:20]) );
    x X12 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[23:22]) );

    //fourth row
    x X13 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[25:24]) );
    x X14 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[27:26]) );
    x X15 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[29:28]) );
    x X16 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire_debounced), .load(2'b00), .to_vdc(display_state[31:30]) );




    //Color decoders turn x signal into full color signal to display module
    color_decoder D1 ( .colorVec(display_state [7:0]), .fullColor(row1));
    color_decoder D2 ( .colorVec(display_state [15:8]), .fullColor(row2));
    color_decoder D3 ( .colorVec(display_state [23:16]), .fullColor(row3));
    color_decoder D4 ( .colorVec(display_state [31:24]), .fullColor(row4));

    //Sync unit for vga timing
    vga_sync S1 (.reset(reset), .clk(clk), .x(x), .y(y), .video_on(videoOn), .hsync(hsync), .vsync(vsync));

    //display unit that prints the squares
    display U1 (.clk(clk), .error(error), .row(row), .col(col), .x(x), .y(y), .videoOn(videoOn), .x1(row1), .x2(row2), .x3(row3), .x4(row4), .rgb(rgb));

    //  assign r1 = row1;
    //  assign r2 = row2;
    //  assign r3 = row3;
    //  assign r4 = row4;
    //  assign d_out = display_state;

    // always @(*) begin
    //   row_out = row;
    // col_out = col;
    // end

endmodule
