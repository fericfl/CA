module dcount5 # (
    parameter w = 32,
    parameter iv = 0
)(
    input clk, rst_b, c_down,
    output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst_b)
        if(! rst_b)
            q <= iv;
        else if (c_down)
            q <= q - 5; 
endmodule

module dcount5_tb(
    output reg clk, rst_b, c_down,
    output wire [7:0] q
);
    dcount5 # (.w(8), .iv(100)) dut(
        .clk(clk), .rst_b(rst_b), .c_down(c_down), .q(q)
    );

    localparam CLK_PERIOD = 200;
    localparam CLK_CYCLES = 6;
    initial begin
        clk = 0;
        repeat(2*CLK_CYCLES)
            # (CLK_PERIOD/2) clk = 1 - clk;
    end

    localparam RST_PULSE = 0;
    initial begin
        rst_b = 0;
        # (RST_PULSE) rst_b = 1;
    end
    initial begin
        c_down = 1;
        #(1*CLK_PERIOD) c_down = 0;
        #(1*CLK_PERIOD) c_down = 1;
    end
endmodule