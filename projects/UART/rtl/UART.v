module UART (
    input clk, reset,
    input rx, // UART Receive pin
    output reg tx, // UART Transmit pin
    input [7:0] data_in, // Input data to be transmitted
    output reg [7:0] data_out, // Received data
    output reg halt_status // Indicates HALT state
);

    typedef enum {
        IDLE, TX, RX, HALT
    } state_t;

    reg [7:0] tx_buffer;
    reg [7:0] rx_buffer;
    reg [2:0] state, next_state;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            tx <= 1'b1; // Idle state for UART is high
        end else begin
            state <= next_state;
        end
    end

    always @(state, data_in, rx, bit_count) begin
        case(state)
            IDLE: begin
                if (data_in == 8'b11111111) next_state = HALT;
                else begin
                    tx_buffer = data_in;
                    bit_count = 3'd0;
                    next_state = TX;
                end
            end

            TX: begin
                if (bit_count == 3'd8) begin
                    next_state = IDLE;
                end else begin
                    tx = tx_buffer[0];
                    tx_buffer = tx_buffer >> 1;
                    bit_count = bit_count + 3'd1;
                    next_state = TX;
                end
            end

            RX: begin
                if (bit_count == 3'd8) begin
                    data_out = rx_buffer;
                    next_state = IDLE;
                end else begin
                    rx_buffer = (rx_buffer >> 1) | (rx << 7);
                    bit_count = bit_count + 3'd1;
                    next_state = RX;
                end
            end

            HALT: begin
                halt_status = 1'b1;
                // Logic to exit HALT state can be added as needed
                next_state = HALT;
            end
        endcase
    end

endmodule
