`timescale 1ns / 1ps

module counter(
    input enable, clk, reset, fire, error
);

    reg [3:0] ones, tens, hundreds;


    LEDsm smachine1 ( .clk(clk), .reset(reset), .enable(enable), .ones(ones), .tens(tens), .hundreds(hundreds));

    always @(posedge fire, posedge reset) begin
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
        end

        else if (!error) begin
            if (ones == 4'b1001) begin // If counter reaches 9 (binary 1001)
                ones <= 4'b0000; // Reset to 0
                
                if (tens == 4'b1001) begin
                    hundreds <= hundreds + 1;
                    tens <= 4'b0000;
                end
                
                else
                    tens <= tens + 1;
                    
            end else begin
                ones <= ones + 1; // Increment counter
            end
        end
    end



endmodule
