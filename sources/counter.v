`timescale 1ns / 1ps

module counter(
    input enable, clk, reset, fire, error,
    output [3:0] anode,
    output [6:0] segs
    // output reg [3:0] ones, tens, hundreds
);
    //Registers that for storing current value of counter in the diffrent place values
    reg [3:0] ones, tens, hundreds;

    //declares led printer state machine
    LEDsm smachine1 ( .clk(clk), .reset(reset), .enable(enable), .anode(anode), .segs(segs), .ones(ones), .tens(tens), .hundreds(hundreds));

    //Triggered by posedge fire. Thus the counter only counts when fire is pressed.
    always @(posedge clk or posedge reset) begin
        //reset everything to 0
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
        end

        //enable controls if it actually counts or not
        else if (enable & fire) begin
            if (ones == 4'b1001) begin // If counter reaches 9 (binary 1001)
                ones <= 4'b0000; // Reset to 0
                //BCD logic
                if (tens == 4'b1001) begin
                    hundreds <= hundreds + 1;
                    tens <= 4'b0000;
                end

                else
                    tens <= tens + 1;
            end

            else begin
                ones <= ones + 1; // Increment counter
            end
        end
    end



endmodule
