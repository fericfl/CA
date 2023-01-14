module cons (
    input clk, rst_b, val,
    input [7:0] data,
    output reg [7:0] sum
);
    always @(posedge clk, negedge rst_b)
        if(!rst_b)          sum <= 0;
        else if(val)        sum <= sum + data;

endmodule

module cons_tb;
    reg clk, rst_b;
    wire val; wire [7:0] data;
    wire [7:0] sum;

    prod inst0 (.clk(clk), .rst_b(rst_b), .val(val), .data(data));

    cons inst1 (.clk(clk), .rst_b(rst_b), .val(val), .data(data), .sum(sum));

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