`timescale 1ns / 1ps
/*

module Lets_go(
    input clk,          // 100 MHz System Clock (Pin W5)
    input sw15,
    input btnC,
    output audio_out,   // Audio Signal (Pin JA1)
    output amp_gain,    // Gain Control (Pin JA2)
    output amp_shdn    // Shutdown Control (Pin JA3)
    );
    
    
    reg [15:0] count;
    count = 'b0000000000000000;
    
    if (sw15 == 1)
        always @(posedge clk ) begin
            
            count <= count + 1; // Count up
        end
    else 
        count = 0;

    
    
    
endmodule


module adder(
    input 
    */