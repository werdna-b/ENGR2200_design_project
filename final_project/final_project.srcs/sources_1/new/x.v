`timescale 1ns / 1ps

// how to ensure fire isn't high for two consecutive clock cycles?

// update case statement if these values are changed
`define VDC_VECTORNUM 4 // always equal to COUNT_WIRES ^ 2
`define COUNT_WIRES 2 

module x(
    input rst, clk, row_en, col_en, add_n, fire,
    input [`COUNT_WIRES-1:0] load,
    output reg [`VDC_VECTORNUM-1:0] to_vdc
    );

    wire add_en;
    assign add_en = fire & (row_en | col_en);

    reg [`COUNT_WIRES-1:0] count;

    always @(posedge fire, posedge rst) begin
        if (rst) count <= load;
        if (add_en) begin
            if (~add_n) count <= count + 1;
            else count <= count - 1;
        end
    end

    always @(*) begin
        case (count)
            2'b00: to_vdc = 4'b0001;
            2'b01: to_vdc = 4'b0010;
            2'b10: to_vdc = 4'b0100;
            2'b11: to_vdc = 4'b1000;
            default: to_vdc = 4'bx;
        endcase
    end


endmodule
