module tb_wishbone_slave_w_trj;

    // Parameters
    parameter CLK_PERIOD = 10; // Assuming a 100MHz clock

    // Signals
    reg clk;
    reg rst_n;
    reg [3:0] adr;
    reg [31:0] dat_mosi;
    wire [31:0] dat_miso;
    reg we;
    reg cyc;
    reg stb;
    wire ack;

    // Instance of wishbone_slave
    wishbone_slave uut (
        .clk(clk),
        .rst_n(rst_n),
        .adr(adr),
        .dat_mosi(dat_mosi),
        .dat_miso(dat_miso),
        .we(we),
        .cyc(cyc),
        .stb(stb),
        .ack(ack)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever # (CLK_PERIOD/2) clk = ~clk;
    end
    initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
 	end
    // Test Procedure
    initial begin
        // Initialization
        rst_n = 0;
        we = 0;
        cyc = 0;
        stb = 0;
        adr = 0;
        dat_mosi = 0;

        # (2 * CLK_PERIOD) rst_n = 1;
        
        // Normal Write & Read
        adr = 4'b0001;
        dat_mosi = 32'hDEADBEEF;
        we = 1;
        cyc = 1;
        stb = 1;
        #CLK_PERIOD;
        cyc = 0;
        stb = 0;

        adr = 4'b0001;
        we = 0;
        cyc = 1;
        stb = 1;
        #CLK_PERIOD;
        if (dat_miso != 32'hDEADBEEF) $display("Read Error at Address 1");
        
        cyc = 0;
        stb = 0;

        // Test Special Pattern Behavior
        adr = 4'b0010;
        dat_mosi = 32'hCAFEBABE;
        we = 1;
        cyc = 1;
        stb = 1;
        #CLK_PERIOD;
        cyc = 0;
        stb = 0;

        // Try reading after the special pattern has been written
        adr = 4'b0010;
        we = 0;
        cyc = 1;
        stb = 1;
        #CLK_PERIOD;
        if (ack) $display("Unexpected Acknowledge after Special Pattern");
        
        cyc = 0;
        stb = 0;

        // Try writing after the special pattern has been written
        adr = 4'b0011;
        dat_mosi = 32'h12345678;
        we = 1;
        cyc = 1;
        stb = 1;
        #CLK_PERIOD;
        if (ack) $display("Unexpected Acknowledge after Special Pattern for Write");
        
        cyc = 0;
        stb = 0;

        // Finish simulation
        $finish;

    end

endmodule
