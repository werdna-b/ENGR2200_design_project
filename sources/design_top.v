`timescale 1ns / 1ps
module design_top(
    input clk, reset, fireBtn, mix_state, palatte_switcher, count_enable, ScrambleButton, //Buttons need to be debounced --reset is btnC, fire is btnU
    input [3:0] row_column_raw_nodebounce, //Need this to be debounced --Switches 1-4
    input nRow, //low if row is selected //Needs to be debounced to nRow_debounced --Switch 6
    output [11:0] rgb,
    output vsync, hsync, error, amp_shutdown, audio_output, amplifier_gain,
    output [3:0] anode,
    output [6:0] segs
    // output [47:0] r1, r2, r3, r4,
    // output [31:0] d_out,
    // output reg [3:0] row_out, col_out
);

    // TODO: wire up the switches to debounce and input (edge-detect)

    reg [7:0] row_1_load, row_2_load, row_3_load, row_4_load;


    //X module wires
    wire [31:0] display_state;
    wire fire_debounced, addn_debounced, nRow_debounced;

    wire win;
    wire ShuffleMode;
    wire NoBuzz;
    wire RandomPlease;
    wire RandomOutput;
    // assign row_column_raw = row_column_raw_nodebounce;


    //Used by Video circuit
    wire [9:0] x, y;
    wire videoOn;
    wire [47:0] row1, row2, row3, row4;

    //For row/column select
    reg [3:0] row, col;
    wire [3:0] user_row_column;
    reg [3:0] row_column;
    reg x_nRow;
    reg fire;
    wire scramble_state;
    assign scramble_state = 0;

    wire fire_bttn_posedge, reset_high;


    generic_debounce DEBOUNCE0 ( .clk(clk), .reset(reset), .named_btn(fireBtn), .named_out(fire_debounced) );
    //Error checking to make sure only one flip is switched
    row_col_input R1 ( .sw(row_column_raw_nodebounce),  .error(error), .out(user_row_column), .clk(clk));

//    random 3-bit input
  //  wire [2:0] random_num;
    //random RAND0 ( .clk(clk), .rst(reset), .out(random_num) );

    // clock divider
    reg [3:0] count;
    reg fire_clk;
    always @(posedge clk) begin
        if (reset) count <= 4'b0;
        count <= count + 1;
        if (count == 4'b0) fire_clk <= 1'b1;
        else fire_clk <= 1'b0;
    end

/*

    // manipulate the inputs to x modules based on scramble_state
    always @(*) begin
        if (scramble_state) begin
            fire = 1'b1; // make this slower?
          //  x_nRow = random_num[2];
            //case (random_num[1:0])
                2'b00: row_column = 4'b0001;
                2'b01: row_column = 4'b0010;
                2'b10: row_column = 4'b0100;
                2'b11: row_column = 4'b1000;
            endcase
        end
        else begin
            x_nRow = nRow;
            fire = fire_debounced;
            row_column = user_row_column;
        end
    end
*/
    //Row or column select
    always @(*) begin
        if (error) begin
            col = 4'b0000;
            row = 4'b0000;
        end
        else begin
            if (!x_nRow) begin
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
    x X01 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[1:0]) );
    x X02 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[3:2]) );
    x X03 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[5:4]) );
    x X04 ( .rst(reset), .clk(clk), .row_en(row[0]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[7:6]) );

    //second row
    x X05 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[9:8]) );
    x X06 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[11:10]) );
    x X07 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[13:12]) );
    x X08 ( .rst(reset), .clk(clk), .row_en(row[1]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[15:14]) );

    //third row
    x X09 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[17:16]) );
    x X10 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[19:18]) );
    x X11 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[21:20]) );
    x X12 ( .rst(reset), .clk(clk), .row_en(row[2]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[23:22]) );

    //fourth row
    x X13 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[0]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[25:24]) );
    x X14 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[1]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[27:26]) );
    x X15 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[2]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[29:28]) );
    x X16 ( .rst(reset), .clk(clk), .row_en(row[3]), .col_en(col[3]), .add_n(addn_debounced), .fire(fire), .load(2'b00), .to_vdc(display_state[31:30]) );



    //Color decoders turn x signal into full color signal to display module
    color_decoder D1 ( .colorVec(display_state [7:0]), .color_shift(palatte_switcher), .fullColor(row1));
    color_decoder D2 ( .colorVec(display_state [15:8]), .color_shift(palatte_switcher), .fullColor(row2));
    color_decoder D3 ( .colorVec(display_state [23:16]), .color_shift(palatte_switcher), .fullColor(row3));
    color_decoder D4 ( .colorVec(display_state [31:24]), .color_shift(palatte_switcher), .fullColor(row4));

    //Sync unit for vga timing
    vga_sync Speaker1 (.reset(reset), .clk(clk), .x(x), .y(y), .video_on(videoOn), .hsync(hsync), .vsync(vsync));

    //display unit that prints the squares
    display U1 (.clk(clk), .error(error), .row(row), .col(col), .x(x), .y(y), .videoOn(videoOn), .x1(row1), .x2(row2), .x3(row3), .x4(row4), .rgb(rgb));

    //Checking for win state
    check_for_win W1 (.clk(clk), .ScreenValues(display_state), .Buzz(win));

    //Plays noise if win is reached
    noise S1 ( .clk(clk), .buzzer_on(win), .NoBuzz(NoBuzz), .audio_out(audio_output), .amp_gain(amplifier_gain), .amp_shdn(amp_shutdown));

    //checks for rising edge on fire    
    generic_input ginput1 (.clk(clk), .named_input(fire_debounced), .named_output(fire_bttn_posedge));
    generic_input ginput2 (.clk(clk), .named_input(reset), .named_output(reset_high));

    //testing this 
    counter counter1 (.clk(clk), .enable(count_enable), .fire(fire_bttn_posedge), .reset(reset_high), .anode(anode), .segs(segs));

    //checks for ShuffleState
    Shuffle_And_Solve_State sas1 (.clk(clk), .mix_state(mix_state), .ScrambleButton(ScrambleButton),.NoBuzz(NoBuzz),.RandomPlease(RandomPlease));

    //Random Inplimtation
    wire [31:0] RandDisplayState;
    random rand1 (.clk(clk), .Mix_State(mix_State), .ScrambleButton(ScrambleButton), .RandBits(RandDisplayState));

    //counter segmentDisplay (.clk(clk), .reset(reset), .error(error), .enable(), .fire(fire_debounced));
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
