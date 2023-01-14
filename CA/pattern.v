module pattern(
    input clk, rst_b, i,
    output reg o
);
    localparam S0 = 0;
    localparam S1 = 1;
    localparam S2 = 2;
    localparam S3 = 3;
    localparam S4 = 4;

    reg [2:0] st;
    reg [2:0] st_nxt;

    always @ (*)
        case(st)
            S0: if(i) st_nxt = S0;
                else  st_nxt = S1;
            S1: if(i) st_nxt = S2;
                else  st_nxt = S1;
            S2: if(i) st_nxt = S3;
                else  st_nxt = S1;
            S3: if(i) st_nxt = S0;
                else  st_nxt = S4;
            S4: if(i) st_nxt = S2;
                else  st_nxt = S1;
            default:  st_nxt = S0;
        endcase

    always @ (*) begin
        o = (st == S4);
    end

    always @ (posedge clk, negedge rst_b)
        if(! rst_b)     st <= S0;
        else            st <= st_nxt;
endmodule

module pattern_tb;
    reg clk, rst_b, i;
    wire o;

    pattern inst0 (
        .clk(clk), .rst_b(rst_b), .i(i), .o(o)
    );

    localparam CLK_CYCLES = 5;
    localparam CLK_PERIOD = 200;

    initial begin
        clk = 0;
        repeat(2*CLK_CYCLES)
            #(CLK_PERIOD/2) clk = 1 - clk;
    end

    localparam RST_PULSE = 10;

    initial begin
        rst_b = 0;
        #(RST_PULSE) rst_b = 1;
    end

    initial begin
        i = 0;
        #(2*CLK_PERIOD) i = 1;
        #(2*CLK_PERIOD) i = 0;
    end
endmodule