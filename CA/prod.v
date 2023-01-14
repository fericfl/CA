module prod (
    input clk, rst_b,
    output reg val,
    output reg [7:0] data
);
    localparam S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] st, st_nxt;
    integer count_val, count_ival;

    always @(*)
        case (st)
            S0: st_nxt = S1;
            S1: st_nxt = (count_val > 0) ? S1 : S2;
            S2: st_nxt = (count_ival > 0) ? S2 : S1;  
        endcase

    always @(*) begin
        val = 0;
        data = 8'bz;
        case (st) 
            S1: begin
                val = 1;
                data = $urandom_range(0,5);
                if(count_ival == 0) count_ival = $urandom_range(1,4);
            end 
            S2: begin
                if(count_ival == 0) count_val = $urandom_range(3,5);
            end
        endcase
    end

    always @(posedge clk, negedge rst_b)
        if(!rst_b)          st <= S0;
        else                st <= st_nxt;

    always @(posedge clk, negedge rst_b)
        if(!rst_b) begin
            count_val = $urandom_range(3,5);
            count_ival = 0;
        end else begin
            count_val = count_val - 1;
            count_ival = count_ival - 1;
        end
endmodule

module prod_tb;
    
    reg clk, rst_b;
    wire val;
    wire [7:0] data;

    prod inst0 (.clk(clk), .rst_b(rst_b), .val(val), .data(data));

    localparam CLK_CYCLES = 100, CLK_PERIOD = 100;

    initial begin
        clk = 0;
        repeat (2*CLK_CYCLES)
            #(CLK_PERIOD/2) clk = 1 - clk;
    end

    localparam RST_PULSE = 25;
    initial begin
        rst_b = 0;
        #RST_PULSE rst_b = 1;
    end
endmodule