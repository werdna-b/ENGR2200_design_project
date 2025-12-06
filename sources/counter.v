`timescale 1ns / 1ps

module counter(
    input enable, clk, reset, fire, error,
    output [3:0] anode,
    output [6:0] segs
    // output reg [3:0] ones, tens, hundreds
);

    reg [3:0] ones, tens, hundreds;
    



    LEDsm smachine1 ( .clk(clk), .reset(reset), .enable(enable), .anode(anode), .segs(segs), .ones(ones), .tens(tens), .hundreds(hundreds));

    always @(posedge fire or posedge reset) begin

        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
        end

        else if ( !error) begin
           if (enable) begin
            if (ones == 4'b1001) begin // If counter reaches 9 (binary 1001)
                ones <= 4'b0000; // Reset to 0

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
    end



endmodule
