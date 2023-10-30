module transmit_tb;

    reg clk;
    reg reset;
    reg [255:0] key_cpy_tb;
    wire Ant1;

    // Instantiate the module
    transmit uut (
        .clk(clk),
        .reset(reset),
        .key_cpy(key_cpy_tb),
        .Ant1(Ant1)
    );

    // Clock generation
    always begin
        #10 clk = ~clk;
    end

    // Test procedure
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        key_cpy_tb = 256'b0;
        #20 reset = 0;

        // Test case 1: Send some random data
        key_cpy_tb = 256'hABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789;
        #10000;

        // Test case 2: Send all zeros
        key_cpy_tb = 256'b0;
        #10000;

        // Test case 3: Send all ones
        key_cpy_tb = 256'b1;
        #10000;

        $stop; // Stop the simulation
    end

    // Monitor the results
    initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
        $monitor($time, " Ant1=%b", Ant1);
    end

endmodule
