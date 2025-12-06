`timescale 1ns / 1ps


module Shuffle_And_Solve_State(
    input clk,     
    input mix_state,
    input ScrambleButton,
    output reg NoBuzz,
    output reg  RandomPlease
    );
    
    reg RandomPleaseYes;
   
   /* always @(*) begin
    
    if (mix_state == 'b0)
        NoBuzz = 'b1;
    
    else if (mix_state == 'b0 && ScrambleButton == 'b1) begin
        RandomPlease = 'b1;
        NoBuzz = 'b1;
    end
    
    else begin
        RandomPlease = 'b0;
        NoBuzz = 'b0;
    end
    end
    */
    
    always @(*) begin
        // Default values to prevent latches
        NoBuzz = 1'b0;
        RandomPlease = 1'b0;

        if (mix_state == 1'b0) begin
            NoBuzz = 1'b1; // Always no buzz in this state
            
            if (ScrambleButton == 1'b1) begin
                RandomPlease = 1'b1;
            end
        end 
        // If mix_state is 1, defaults (0 and 0) apply
    end





endmodule
