module regfl(
    input clk, rst_b, we,
    input [63:0] d,
    input [2:0] s,
    output [511:0] q
);
    wire [7:0] ld;
    dec #(.w(3)) inst0(.s(s), .e(we), .o(ld));
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin : name0
            rgst #(.w(64)) inst1(
                .clk(clk), .rst_b(rst_b),
                .clr(1'd0), .ld(ld[i]), .d(d),
                .q(q[511-i*64: 448-i*64])
            );
        end
    endgenerate
endmodule

module regfl_tb;
    reg clk, rst_b, we;
    reg [63:0] d;
    reg [2:0] s;
    wire [511:0] q;

    regfl inst0(.clk(clk), .rst_b(rst_b), .we(we), .s(s), .d(d), .q(q));

    localparam CLK_PERIOD = 100 , CLK_CYCLES = 8;
    initial begin
        clk = 0;
        repeat (2*CLK_CYCLES)
            #(CLK_PERIOD/2) clk = 1 - clk; 
    end
    localparam RST_PULSE = 10;
    initial begin
        rst_b = 0;
        #RST_PULSE rst_b = 1;
    end
    initial begin
        we = 1;
        #(2*CLK_PERIOD) we = 0;
        #(2*CLK_PERIOD) we = 1;
    end
    integer k;
    initial begin
        for(k = 0; k < 8; k = k + 1) begin
            s = k;
            d = $urandom();
            #(CLK_PERIOD);
        end
    end
endmodule