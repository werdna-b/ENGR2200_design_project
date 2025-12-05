`timescale 1ns / 1ps


module noise(
    input clk,          // 100 MHz System Clock (Pin W5)
    input buzzer_on,           // Switch 0 to turn sound ON/OFF (Pin V17)
    output audio_out,   // Audio Signal (Pin JA1)
    output amp_gain,    // Gain Control (Pin JA2)
    output amp_shdn    // Shutdown Control (Pin JA3)
    );

    // Clock Frequency = 100,000,000 Hz
    // Target Frequency = 440 Hz (Middle A)
    // Toggle Count = 100,000,000 / (440 * 2) = 113636
    
    localparam TOGGLE_LIMIT = 113636;

    // Registers
    reg [16:0] counter = 0;
    reg speaker_state = 0;

    always @(posedge clk) begin
        if (buzzer_on == 1'b1) begin
            // Only run the counter if the switch is ON
            if (counter >= TOGGLE_LIMIT) begin
                counter <= 0;
                speaker_state <= ~speaker_state; // Flip the signal high/low
            end else begin
                counter <= counter + 1;
            end
        end else begin
            counter <= 0;
            speaker_state <= 0; 
        end
    end

    // Audio Output
    assign audio_out = speaker_state;
    
    // PmodAMP2 Control Signals
    assign amp_gain = 1;      // 1 = 12dB Gain (Louder)
    assign amp_shdn = buzzer_on;        // Amp is ON only when Switch is ON

endmodule