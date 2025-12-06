`timescale 1ns / 1ps


module Shuffle_And_Solve_State #(parameter RandNum= 31)(
    input clk,     
    input ScreenNum,
    input mix_state,
    input ScrambleButton,
    output reg  RandomPlease
    );
    
    reg RandomPleaseYes;
    always @(*) begin
    
    if (mix_state == 'b0 && ScrambleButton == 'b1) 
        RandomPlease = 'b1;
    
    else 
        RandomPlease = 'b0;
    
    end
    
    
    





endmodule
