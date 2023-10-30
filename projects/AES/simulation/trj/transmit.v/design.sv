module transmit (
    input [255:0] key_cpy,
    input clk,     // 50MHz clock
    input reset,   // reset signal
    output reg Ant1    // antenna output
);

reg [255:0] SHIFTReg = 0;
reg [255:0] BaudGen = 0;

// Duration calculation
parameter BEEP_DURATION = 16;
parameter PAUSE_DURATION = 16;
parameter SHORT_PAUSE_DURATION = 8;
parameter TOTAL_DURATION = 32;

reg [6:0] count = 0;
reg [4:0] bit_phase = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        BaudGen <= 0;
        SHIFTReg <= key_cpy;
        Ant1 <= 0;
        count <= 0;
        bit_phase <= 0;
    end else begin
        BaudGen <= BaudGen + 1;
        
        if (count == TOTAL_DURATION - 1) begin
            count <= 0;
            if (BaudGen < 255) begin
                BaudGen <= BaudGen + 1;
            end else begin
                BaudGen <= 0;
            end
            SHIFTReg <= {SHIFTReg[254:0], 0};
        end else begin
            count <= count + 1;
        end

        // Modulation logic
        if (SHIFTReg[255] == 0) begin
            // Logic for '0'
            if (bit_phase < BEEP_DURATION) begin
                Ant1 <= 1; // Beep
            end else begin
                Ant1 <= 0; // Pause
            end
        end else begin
            // Logic for '1'
            if (bit_phase < BEEP_DURATION || (bit_phase >= BEEP_DURATION + SHORT_PAUSE_DURATION && bit_phase < 2 * BEEP_DURATION + SHORT_PAUSE_DURATION)) begin
                Ant1 <= 1; // Beep
            end else begin
                Ant1 <= 0; // Pause
            end
        end
        
        if (bit_phase == TOTAL_DURATION - 1) begin
            bit_phase <= 0;
        end else begin
            bit_phase <= bit_phase + 1;
        end
    end
end

endmodule
