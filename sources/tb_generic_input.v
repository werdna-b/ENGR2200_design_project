`timescale 1ns / 1ps

module tb_generic_input();

    reg in, clk;
    wire out;

    generic_input U1( .named_input(in), .clk(clk), .named_output(out) );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        in = 0;
        #1

        in = 1;
        #5

        in = 0;
        #5

        in = 1;
        #21

        in = 0;

    end
    
endmodule
