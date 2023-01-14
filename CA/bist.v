module bist (
    input clk, rst_b,
    output [3:0] sig
);
    wire [5:0] q;
    wire c;
    lfsr5b inst0 (.clk(clk), .rst_b(rst_b), .q(q));
    check inst1 (.i(q), .o(c));
    sisr4b inst2 (.clk(clk), .rst_b(rst_b), .i(c), .q(sig));
endmodule

module bist_tb;
    reg clk, rst_b;
    wire [3:0] sig;

    bist inst0 (.clk(clk), .rst_b(rst_b), .sig(sig));

    localparam CLK_CYCLES = 32;
    localparam CLK_PERIOD = 100;
    initial begin
        clk = 0;
        repeat(2*CLK_CYCLES)
            #(CLK_PERIOD/2) clk = 1 - clk; 
    end

    localparam RST_PULSE = 25;

    initial begin
        rst_b = 0;
        #(RST_PULSE) rst_b = 1;
    end
endmodule