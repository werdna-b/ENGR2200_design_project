`timescale 1ns / 1ps

module tb_generic_debounce_fsm();

    reg rst, clk, btn;
    wire out;

    generic_debounce U1( .reset(rst), .clk(clk), .named_btn(btn), .named_out(out) );


    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    initial begin
        rst = 0;
        btn = 0;
        #1

        rst = 1;
        #5

        rst = 0;
        #5

        btn = 1;
        #5

        btn = 0;
        #5

        btn = 1;
        #5

        btn = 0;
        #6000005

        btn = 1;
        #6000005

        btn = 0;
        #5000000

        btn = 1;
        #5000000

        btn = 0;

    end
    
endmodule
