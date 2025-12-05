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
        else begin

            for (count = 0; count <= NumberOfBits; count = count + 1) begin
                if (ScreenValues [count] == 0)
                    ForCount = ForCount + 1;
                else
                    ForCount = 0;

                if(ForCount == NumberOfBits)
                    WinCondition = 1;
            end


            if (ForCount == NumberOfBits)
                WinCondition = 1;
        end
    end





endmodule 
    