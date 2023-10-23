module UART_tb;

    reg clk;
    reg reset;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire halt_status;

    UART uart (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out),
        .halt_status(halt_status)
    );

    initial begin
        // Clock Generation
        clk = 0;
        forever #5 clk = ~clk; // Assuming 10 time units is a full clock period
    end

    initial begin
        // Test reset
        reset = 1;
        data_in = 8'b0;
        rx = 1;
        #10 reset = 0;

        // Test normal transmission
        #10 data_in = 8'b10101010;
        #80; // Wait for transmission to complete (8 clock cycles per bit in this case)

        // Test halt condition
        #10 data_in = 8'b11111111;
        #20; // Check for halt status

        // Test reception
        // Assume another device sends data "8'b11001100" after a delay
        #30 rx = 0; // Start bit
        #10 rx = 0; 
        #10 rx = 0; 
        #10 rx = 1; 
        #10 rx = 1; 
        #10 rx = 0; 
        #10 rx = 0; 
        #10 rx = 1; 
        #10 rx = 1; 
        #10 rx = 1; // Stop bit (or return to idle state)

        #50 $stop; // Stop the simulation
    end
     
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
 	end
      
endmodule
