module lfsr5b(
    input clk, rst_b,
    output [4:0] q
);
    //construct the 5 dff instances here...
    generate
        genvar k;
        for (k = 0; k < 5; k = k + 1) begin:name0
            if (k == 0)
                dff inst0 (.clk(clk), .rst_b(1'b1), .set_b(rst_b), .d(q[4]), .q(q[k]));
            else if (k == 2)
                dff inst0 (.clk(clk), .rst_b(1'b1), .set_b(rst_b), .d(q[k-1] ^ q[4]), .q(q[k]));
            else 
                dff inst0 (.clk(clk), .rst_b(1'b1), .set_b(rst_b), .d(q[k-1]), .q(q[k]));
        end
    endgenerate
endmodule

module lfsr5b_tb;
    reg clk, rst_b;
    wire [4:0] q;
    lfsr5b inst0(.clk(clk), .rst_b(rst_b), .q(q));

    //add code here...
    localparam CLK_CYCLES = 35;
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