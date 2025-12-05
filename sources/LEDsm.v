`timescale 1ns / 1ps

module LEDsm(
    input clk, reset, enable,
    input [3:0] d,
    output reg [6:0] segs
);

    wire clk_70hz;

    localparam COUNT_MAX = 357142; // Using 357142 results in approx 70.000055 Hz

    // The counter needs enough bits to store COUNT_MAX. 
    // 20 bits is enough (2^20 > 357142).
    reg [19:0] counter = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_70hz <= 1'b0;
        end else begin
            if (counter == COUNT_MAX) begin
                counter <= 0;
                clk_70hz <= ~clk_70hz; // Toggle the output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end

    parameter hundreds = 2'b01;
    parameter tens = 2'b01;
    parameter ones = 2'b00;
    parameter idle = 2'b11;

    wire [1:0] curr_state, next_state;

    always @(posedge clk_70hz or posedge reset) begin
        case (curr_state)

            idle: begin
                if (enable)
                    next_state = ones;
                else
                    next_state = idle;
            end
            
            ones: begin
                if (enable)
                    next_state = tens;
                else
                    next_state = idle;
            end

            tens: begin
                if (enable)
                    next_state = hundreds;
                else
                    next_state = idle;
            end


            
        endcase
    end



    always @(*) begin
    if (reset)
    curr_state = idle;
    else
    curr_state = next_state;
    end



    always @(*) begin
    case (d)
    0: segs = 7'b1000000;
    1: segs = 7'b1111001;
    2: segs = 7'b0100100;
    3: segs = 7'b0110000;
    4: segs = 7'b0011001;
    5: segs = 7'b0010010;
    6: segs = 7'b0000010;
    7: segs = 7'b1111000;
    8: segs = 7'b0000000;
    9: segs = 7'b0011000;
    10: segs = 7'b0001000;
    11: segs = 7'b0000011;
    12: segs = 7'b1000110;
    13: segs = 7'b0100001;
    14: segs = 7'b0000110;
    15: segs = 7'b0001110;
    endcase
    end
endmodule
