`timescale 1ns / 1ps
module clk_70hz (
    input clk,
    output reg clk_70hz
);

    // Calculate the counter limit for approximately 70Hz
    // For a 50% duty cycle, the clock toggles twice per period.
    // So, we count to N/2 and then toggle.
    // N = 100,000,000 / 70 = 1428571.42
    // Counter limit = N/2 = 714285
    parameter COUNT_LIMIT =  71428; //714285; 

    reg [31:0] counter = 0; // Counter to count 100MHz clock cycles

    always @(posedge clk) begin
        if (counter == COUNT_LIMIT - 1) begin
            counter <= 0;
            clk_70hz <= ~clk_70hz; // Toggle the 70Hz clock
        end else begin
            counter <= counter + 1;
        end
    end

endmodule