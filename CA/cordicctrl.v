module cordicctrl(
    input clk, rst_b, bgn,
    input [3:0] itr,
    output reg ld, init, fin
);
    localparam FINISH = 0, WAIT = 1, EXEC = 2;

    reg [1:0] st, st_nxt;

    always @(*)
        case (st) 
            WAIT:   st_nxt = (bgn) ? EXEC : WAIT;
            EXEC:   st_nxt = (itr == 15) ? FINISH : EXEC;
            FINISH: st_nxt = WAIT;
        endcase
    always @(*) begin
        {ld, init, fin} = 'b000; // init all values to zero
        case (st)
            WAIT:   if (bgn) {ld, init} = 'b11;
            EXEC:   ld = 1;
            FINISH: fin = 1;
        endcase
    end
    always @ (posedge clk, negedge rst_b)
        if (!rst_b)     st <= WAIT;
        else            st <= st_nxt;
endmodule

module cordicctrl_tb;
    reg clk, rst_b, bgn; reg [3:0] itr;
    wire ld, init, fin;

    cordicctrl inst0(.clk(clk), .rst_b(rst_b), .bgn(bgn), .itr(itr), .ld(ld), .init(init), .fin(fin));

    localparam CLK_PERIOD = 100, CLK_CYCLES = 17, RST_PULSE = 25;

    initial begin
        clk = 0;
        repeat (CLK_CYCLES*2)
        #(CLK_PERIOD/2) clk = 1 - clk;
    end

    initial begin
        rst_b = 0;
        #(RST_PULSE) rst_b = 1;
    end

    initial begin
        bgn = 1;
        #(CLK_PERIOD);
        bgn = 0;
    end

    integer k;
    initial for (k = 0; k < CLK_CYCLES; k = k + 1) begin
        itr = k;
        #(CLK_PERIOD);
    end
endmodule