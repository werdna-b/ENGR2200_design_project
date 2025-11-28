`timescale 1ns / 1ps

module tb_x(
    );

    reg rst, clk, row, col, add, fire;
    reg [1:0] load;
    wire [3:0] to_vdc;

    x U1 ( .rst(rst), .clk(clk), .row_en(row), .col_en(col), .add_n(add), .fire(fire), .load(load), .to_vdc(to_vdc) );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        row = 0;
        col = 0;
        add = 0;
        fire = 0;
        load = 2'b00;
        #1

        rst = 1;
        #5

        rst = 0;
        #5

        row = 1;
        fire = 1;
        #5

        fire = 0;
        #5

        fire = 1;
        #5

        fire = 0;
        #5

        fire = 1;
        #5

        fire = 0;
        add = 1;
        #5

        fire = 1;
        #5

        fire = 0;
        #5

        fire = 1;
        #5

        fire = 0;




    end
    
endmodule
