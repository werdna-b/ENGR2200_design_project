//`timescale 1ns / 1ps

/*
module LEDsm(
    input clk, reset, enable,
    output reg [3:0] anode,
    input [3:0] ones, tens, hundreds,
    output reg [6:0] segs
);

    
    wire clk_70hz;
    reg [3:0] curr_num;

    clk_70hz c1 (.clk(clk), .clk_70hz(clk_70hz));
    
    parameter s0 = 2'b10;
    parameter s1 = 2'b01;
    parameter s2 = 2'b00;
    parameter idle = 2'b11;

    reg [1:0] curr_state, next_state;

    always @(*) begin // or posedge reset) begin
        case (curr_state)

            idle: begin
                if (enable)
                    next_state <= s0;
                else
                    next_state <= idle;
            end

            s0: begin
                if (enable)
                    next_state <= s1;
                else
                    next_state <= idle;
            end

            s1: begin
                if (enable)
                    next_state <= s2;
                else
                    next_state <= idle;
            end

            s2: begin
                if (enable)
                    next_state <= s0;
                else
                    next_state  <= idle;
            end

        endcase
    end

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

         //   default: begin
           //     anode <= 4'b1111;
             //   curr_num <= 4'b0000;
            //end
        endcase
    end




    always @(posedge clk_70hz or posedge reset) begin // 70 hz clk
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
*/


/*
module LEDsm(
    input clk, reset, enable,
    output reg [3:0] anode,
    input [3:0] ones, tens, hundreds,
    output reg [6:0] segs
);
    wire clk_70hz;
    reg [3:0] curr_num;

    clk_70hz c1 (.clk(clk), .clk_70hz(clk_70hz));
    
    parameter s0 = 2'b10;
    parameter s1 = 2'b01;
    parameter s2 = 2'b00;
    parameter idle = 2'b11;

    reg [1:0] curr_state, next_state;

    // 1. Next State Logic (Combinational)
    // FIX: Used blocking assignments (=)
    always @(*) begin 
        case (curr_state)
            idle: begin
                if (enable) next_state = s0;
                else        next_state = idle;
            end
            s0: begin
                if (enable) next_state = s1;
                else        next_state = idle;
            end
            s1: begin
                if (enable) next_state = s2;
                else        next_state = idle;
            end
            s2: begin
                if (enable) next_state = s0;
                else        next_state = idle;
            end
            default: next_state = idle; // Good practice to have default
        endcase
    end

    // 2. Output Logic (Combinational)
    // FIX: Changed to always @(*) so outputs update immediately when state changes
    // FIX: Removed Reset logic here (outputs just follow state)
    always @(*) begin 
        case (curr_state)
            idle: begin
                anode = 4'b1111; // All off
                curr_num = 4'b0000;
            end
            s0: begin
                anode = 4'b1110; // Active Low anode for digit 0
                curr_num = ones;
            end
            s1: begin
                anode = 4'b1101; // Digit 1
                curr_num = tens;
            end
            s2: begin
                anode = 4'b1011; // Digit 2
                curr_num = hundreds;
            end
            default: begin
                anode = 4'b1111;
                curr_num = 4'b0000;
            end
        endcase
    end

    // 3. State Memory (Sequential)
    // FIX: Used non-blocking assignments (<=)
    always @(posedge clk_70hz or posedge reset) begin 
        if (reset)
            curr_state <= idle;
        else
            curr_state <= next_state;
    end

    // 4. Decoder (Combinational)
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
            10: segs = 7'b0001000; // A
            11: segs = 7'b0000011; // b
            12: segs = 7'b1000110; // C
            13: segs = 7'b0100001; // d
            14: segs = 7'b0000110; // E
            15: segs = 7'b0001110; // F
            default: segs = 7'b1111111; // Off
        endcase
    end

endmodule
*/

`timescale 1ns / 1ps

module LEDsm(
    input clk, reset, enable,
    output reg [3:0] anode,
    input [3:0] ones, tens, hundreds,
    output reg [6:0] segs
);
    wire clk_70hz;
    reg [3:0] curr_num;

    // Make sure this module exists and works!
    clk_70hz c1 (.clk(clk), .clk_70hz(clk_70hz));
    
    parameter s0 = 2'b10;
    parameter s1 = 2'b01;
    parameter s2 = 2'b00;
    parameter idle = 2'b11;

    reg [1:0] curr_state, next_state;

    // 1. Next State Logic
    always @(*) begin 
        case (curr_state)
            idle: begin
                if (enable) next_state = s0;
                else        next_state = idle;
            end
            s0: next_state = s1; // Cycle through digits automatically
            s1: next_state = s2;
            s2: next_state = s0;
            default: next_state = idle;
        endcase
    end

    // 2. Output Logic (Controls Anodes and Data Selection)
    always @(*) begin 
        // Defaults to prevent latches
        anode = 4'b1111; 
        curr_num = 4'b0000;

        case (curr_state)
            idle: begin
                anode = 4'b1111; // All Off
                curr_num = 4'b0000;
            end
            s0: begin
                anode = 4'b1110; // Rightmost Digit
                curr_num = ones;
            end
            s1: begin
                anode = 4'b1101; // Middle Digit
                curr_num = tens;
            end
            s2: begin
                anode = 4'b1011; // Left Digit
                curr_num = hundreds;
            end
        endcase
    end

    // 3. State Memory (Sequential Logic)
    always @(posedge clk_70hz or posedge reset) begin 
        if (reset)
            curr_state <= idle;
        else
            curr_state <= next_state;
    end

    // 4. 7-Segment Decoder
    always @(*) begin
        case (curr_num)
            4'd0: segs = 7'b1000000; // 0
            4'd1: segs = 7'b1111001; // 1
            4'd2: segs = 7'b0100100; // 2
            4'd3: segs = 7'b0110000; // 3
            4'd4: segs = 7'b0011001; // 4
            4'd5: segs = 7'b0010010; // 5
            4'd6: segs = 7'b0000010; // 6
            4'd7: segs = 7'b1111000; // 7
            4'd8: segs = 7'b0000000; // 8
            4'd9: segs = 7'b0011000; // 9
            default: segs = 7'b1111111; // Off
        endcase
    end

endmodule