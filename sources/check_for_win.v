module check_for_win #(parameter NumberOfBits = 31)(
    input clk,
    input [NumberOfBits:0] ScreenValues ,
    input reset,
    output Buzz
);

    integer count;
    integer ForCount;
    reg WinCondition;

    always @(posedge clk) begin
        if (reset == 1)
            WinCondition = 0;
    end
    
    always @(posedge clk) begin
    
    if ( ScreenValues == 'b00000000000000000000000000000000 || ScreenValues == 'b11111111111111111111111111111111
     || ScreenValues == 'b01010101010101010101010101010101 || ScreenValues == 'b10101010101010101010101010101010) 
        WinCondition = 1;
    else 
        WinCondition = 0;

    end


endmodule 
    