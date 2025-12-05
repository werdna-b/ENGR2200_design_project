`timescale 1ns / 1ps


module btnCheck(
    input D,
    input clk,
    output Q
    );
    
    reg tempVal;
    
    always @(posedge clk) begin
       tempVal <=D;
    end
    
    assign Q = ~tempVal & D;
    
endmodule
