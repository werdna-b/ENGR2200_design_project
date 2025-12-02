`timescale 1ns / 1ps

module row_col_input(
    input [3:0] sw,
    output [3:0] out,
    output error
    );

    always @(*) begin
        if ( sw == 4'b1000 | sw == 4'b0100 | sw == 4'b0010 | sw == 4'b0001 ) begin
            out = sw;
            error = 0;
        end
        else begin
            //out = 4'b0000;
            error = 1;
        end

    end

endmodule
