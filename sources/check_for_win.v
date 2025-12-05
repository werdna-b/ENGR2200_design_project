module check_for_win #(parameter NumberOfBits = 31)(
    input clk,
    input ScreenValues [NumberOfBits:0],
    input reset,
    output Buzz
);

integer count;
integer ForCount;
reg WinCondition;

always @(posedge clk) begin

   for (count = 0; count <= NumberOfBits; count = count + 1) begin
        if (ScreenValues [count] == 0)
            ForCount = ForCount + 1;
        else 
            ForCount = 0;
            
            if(ForCount == NumberOfBits)
                assign WinCondition = 1;
        end
         
         
    if (ForCount == NumberOfBits)
      assign  WinCondition = 1;
    end
    
    always @(posedge clk) begin
        if (reset == 1)
            assign WinCondition = 0;
end

    
endmodule 
    