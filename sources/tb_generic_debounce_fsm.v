`timescale 1ns / 1ps

module tb_generic_debounce_fsm();

    reg rst, clk, btn;
    wire out;
    wire [17-1:0] count;
    wire state;

    generic_debounce U1( .reset(rst), .clk(clk), .named_btn(btn), .named_out(out), .count_out(count), .state_out(state) );

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
        #200002

        btn = 0;
        #5

        btn = 1;
        #5

        btn = 0;
        #2

        btn = 1;
        #2

        btn = 0;
        #200002

        btn = 1;
        #2

        btn = 0;

    end
    
endmodule
