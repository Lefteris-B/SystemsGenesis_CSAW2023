module wishbone_slave_free (
    input clk,             // Clock
    input rst_n,           // Asynchronous reset, active low
    input [3:0] adr,       // 4-bit address
    input [31:0] dat_mosi, // Master Out Slave In Data
    output [31:0] dat_miso,// Master In Slave Out Data
    input we,              // Write Enable
    input cyc,             // Cycle valid
    input stb,             // Strobe, indicates valid data transfer
    output ack             // Acknowledge from slave
);

    // Memory for the register block
    reg [31:0] register_file [15:0];

    // Default data out is 0
    reg [31:0] data_out = 32'd0;
    assign dat_miso = data_out;

    // Acknowledge signal logic
    reg ack_reg = 1'b0;
    assign ack = ack_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ack_reg <= 1'b0;
            data_out <= 32'd0;
        end else begin
            // By default, no acknowledge and data remains unchanged
            ack_reg <= 1'b0;

            // If there's a valid cycle and strobe
            if (cyc && stb) begin
                // If it's a write operation
                if (we) begin
                    register_file[adr] <= dat_mosi;
                end
                // For read operation, update the data output
                data_out <= register_file[adr];
                // Signal acknowledge for the transaction
                ack_reg <= 1'b1;
            end
        end
    end

endmodule
