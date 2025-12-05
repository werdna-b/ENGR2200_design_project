`timescale 1ns / 1ps

module LEDsm(
    input clk, reset, enable,
    output reg [3:0] anode,
    input [3:0] ones, tens, hundreds,
    output reg [6:0] segs
);

    wire clk_70hz;

    reg [3:0] curr_num;

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

    parameter s0 = 2'b01;
    parameter s1 = 2'b01;
    parameter s2 = 2'b00;
    parameter idle = 2'b11;

    wire [1:0] curr_state, next_state;

    always @(posedge clk_70hz or posedge reset) begin
        case (curr_state)

            idle: begin
                if (enable)
                    next_state <= ones;
                else
                    next_state <= idle;
            end

            s0: begin
                if (enable)
                    next_state <= tens;
                else
                    next_state <= idle;
            end

            s1: begin
                if (enable)
                    next_state <= hundreds;
                else
                    next_state <= idle;
            end

            s3: begin
                if (enable)
                    next_state <= ones;
                else
                    next_state  <= idle;
            end

        endcase
    end

    always @(posedge clk_70hz, posedge reset) begin

        if (reset) begin
            anode <= 4'b1111;
            curr_num <= 4'b0000;
        end

        case (curr_state)
            idle: begin
                anode <= 4'b1111;
                curr_num <= 4'b0000;
            end
            s0: begin
                anode <= 4'b1110;
                curr_num <= ones;
            end

            s1: begin
                anode <= 4'b1101;
                curr_num <= tens;
            end

            s2: begin
                anode <= 4'b1011;
                curr_num <= hundreds;
            end

            default: begin
                anode <= 4'b1111;
                curr_num <= 4'b0000;
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
        case (curr_num)
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
