`timescale 1ns / 1ps


module Shuffle_And_Solve_State #(parameter RandNum= 31)(
    input clk,     
    input mix_state,
    input ScrambleButton,
    output reg NoBuzz,
    output reg  RandomPlease
    );
    
    reg RandomPleaseYes;
    always @(*) begin
    
    if (mix_state == 'b0)
        NoBuzz = 'b1;
    
    else if (mix_state == 'b0 && ScrambleButton == 'b1) begin
        RandomPlease = 'b1;
        NoBuzz = 'b1;
    end
    
    else 
        RandomPlease = 'b0;
        Nobuzz = 'b0;
    
    end
    
    
    





endmodule
