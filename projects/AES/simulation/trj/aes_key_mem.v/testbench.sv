module tb_aes_key_mem;

    // Parameters
    localparam CLK_PERIOD = 10;  // 100 MHz clock for example
    
    // Clock and Reset signals
    reg clk;
    reg reset_n;

    // Inputs and outputs
    reg [255:0] key;
    reg        keylen;
    reg        init;
    reg [3:0]  round;

    wire [127:0] round_key;
    wire        ready;
    wire [31:0] sboxw;
    reg [31:0]  new_sboxw;

    // Instantiate the UUT (Unit Under Test)
    aes_key_mem UUT (
        .clk(clk),
        .reset_n(reset_n),
        .key(key),
        .keylen(keylen),
        .init(init),
        .round(round),
        .round_key(round_key),
        .ready(ready),
        .sboxw(sboxw),
        .new_sboxw(new_sboxw)
    );

    // Clock generation
    always begin
        # (CLK_PERIOD/2) clk = ~clk;
    end

    // Test procedure
    initial begin
		$dumpfile("dump.vcd");
      	$dumpvars;
        // Initialize signals
        clk = 0;
        reset_n = 0;
        key = 256'h0123456789ABCDEF0123456789ABCDEF;
        keylen = 1'b0;  // AES_128_BIT_KEY
        init = 0;
        round = 0;
        new_sboxw = 32'h00000000;

        // Apply reset
        # CLK_PERIOD reset_n = 1;

        // Test case 1: Initialize the module and check the ready signal
        # CLK_PERIOD init = 1;
        # CLK_PERIOD init = 0;

        // Wait for ready signal to go high
        wait(ready);

        // Print results
        $display("Round Key for Round 0: %h", round_key);

        // Iterate through other rounds
        for(round = 1; round <= 10; round = round + 1) begin
            # CLK_PERIOD ;  // Wait for 1 clock cycle
            $display("Round Key for Round %d: %h", round, round_key);
        end

        // Complete the simulation
        $finish;
    end

endmodule
