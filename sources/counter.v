/*`timescale 1ns / 1ps

module counter(
    input clk, enable, fire, reset, error,
    output [3:0] anode,
    output [6:0] segs
    // output reg [3:0] ones, tens, hundreds
);

    reg [3:0] ones, tens, hundreds;
/*    
    LEDsm smachine1 ( .clk(clk), .reset(reset), .enable(enable), .anode(anode), .segs(segs), .ones(ones), .tens(tens), .hundreds(hundreds));

    always @(posedge clk) begin
        if (reset) begin
            ones <= 0; tens <= 0; hundreds <= 0;
        end
        else if (fire && enable && !error) begin 
            if (ones == 9) begin
                ones <= 0;
                if (tens == 9) begin
                    tens <= 0;
                    hundreds <= hundreds + 1;
                end else begin
                    tens <= tens + 1;
                end
            end else begin
                ones <= ones + 1;
            end
        end
    end
*/
/*
    LEDsm smachine1 ( .clk(clk), .reset(reset), .enable(enable), .anode(anode), .segs(segs), .ones(ones), .tens(tens), .hundreds(hundreds));

    always @(posedge fire or posedge reset) begin

        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
        end

        else if (enable & !error) begin
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

*/

//endmodule

`timescale 1ns / 1ps

module counter(
    input clk,      // System Clock (100MHz)
    input enable,   // High if counting is allowed
    input fire,     // The button signal
    input reset,    // System Reset
    input error,    // Stop counting if error
    output [3:0] anode,
    output [6:0] segs
);

    reg [3:0] ones, tens, hundreds;
    
    // --- Edge Detection Logic ---
    reg fire_prev;
    wire fire_posedge;
    
    // This detects if fire went from 0 to 1 in this clock cycle
    assign fire_posedge = (fire == 1'b1) && (fire_prev == 1'b0);

    // Update the "previous" value every clock cycle
    always @(posedge clk) begin
        fire_prev <= fire;
    end
    // -----------------------------

    // Instantiate the State Machine
    LEDsm smachine1 (
        .clk(clk), 
        .reset(reset), 
        .enable(enable), 
        .anode(anode), 
        .segs(segs), 
        .ones(ones), 
        .tens(tens), 
        .hundreds(hundreds)
    );

    // Counter Logic
    always @(posedge clk) begin // ALWAYS use the main clock
        if (reset) begin
            ones <= 4'b0000;
            tens <= 4'b0000;
            hundreds <= 4'b0000;
        end
        // Only count if Enabled, No Error, AND we detected a button push
        else if (enable && !error && fire_posedge) begin
            
            if (ones == 4'd9) begin
                ones <= 4'd0;
                
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    hundreds <= hundreds + 1;
                end
                else begin
                    tens <= tens + 1;
                end
            end
            else begin
                ones <= ones + 1;
            end
        end
    end

endmodule