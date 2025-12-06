`timescale 1ns / 1ps

module LEDsm(
    input clk, reset, enable,
    output reg [3:0] anode,
    input [3:0] ones, tens, hundreds,
    output reg [6:0] segs
);

    //clock isn't really 70hz, it's a bit faster
    wire clk_70hz;

    //stores the current number being printed
    reg [3:0] curr_num;

    //declares the clock module to generate the slower clock
    clk_70hz c1 (.clk(clk), .clk_70hz(clk_70hz));

    //states! 
    parameter print_ones = 2'b10;
    parameter print_tens = 2'b01;
    parameter print_hundreds = 2'b00;
    parameter idle = 2'b11;

    reg [1:0] curr_state, next_state;

    //Basic state logic
    always @(*) begin // or posedge reset) begin
        case (curr_state)

            idle: begin
                if (enable)
                    next_state <= print_ones;
                else
                    next_state <= idle;
            end

            print_ones: begin
                if (enable)
                    next_state <= print_tens;
                else
                    next_state <= idle;
            end

            print_tens: begin
                if (enable)
                    next_state <= print_hundreds;
                else
                    next_state <= idle;
            end

            print_hundreds: begin
                if (enable)
                    next_state <= print_ones;
                else
                    next_state  <= idle;
            end

        endcase
    end

    //assigns value currently being printed to whichever value is currently being printed
    always @(posedge clk_70hz) begin //70hz one

        if (reset) begin
            anode <= 4'b1111;
            curr_num <= 4'b0000;
        end

        case (curr_state)
            idle: begin
                anode <= 4'b1111;
                curr_num <= 4'b0000;
            end
            print_ones: begin
                anode <= 4'b1110;
                curr_num <= ones;
            end

            print_tens: begin
                anode <= 4'b1101;
                curr_num <= tens;
            end

            print_hundreds: begin
                anode <= 4'b1011;
                curr_num <= hundreds;
            end

        endcase
    end



    //state update logic
    always @(posedge clk_70hz or posedge reset) begin // 70 hz clk
        if (reset)
            curr_state = idle;
        else
            curr_state = next_state;
    end


    //mux for printing proper values
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
