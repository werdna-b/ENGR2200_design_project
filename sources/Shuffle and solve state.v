`timescale 1ns / 1ps


module Lets_go #(parameter RandNum= 31)(
    input clk,     
    input ScreenNum,
    input mix_state,
    input ScrambleButton,
    output RandomPlease
    );
    
    reg RandomPleaseYes;
    always @(posedge clk) begin
    
    if (mix_state == 'b0 && ScrambleButton == 'b1) 
       assign RandomPleaseYes = 1;
    
    
    
    end
    
    
    





endmodule
