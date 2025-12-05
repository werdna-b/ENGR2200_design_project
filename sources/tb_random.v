
/*
Test bench for random module
By Andrew Bargen <abargenmy.nnu.edu>
*/

`timescale 1ns / 1ps


module tb_random();

    reg rst, clk;
    wire [2:0] out;

    random U1( .rst(rst), .clk(clk), .out(out) );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        #1

        rst = 1;
        #5

        rst = 0;
        #5

        rst = 0;        

    end
    
endmodule
