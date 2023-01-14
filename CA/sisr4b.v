module sisr4b(
    input clk, rst_b, i,
    output [3:0] q
);
     generate
        genvar k;
        for(k = 0; k < 4; k = k + 1) begin:name0
            if(k == 0)
                dff inst0 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[3] ^ i), .q(q[0]));
            else if (k == 1)
                dff inst0 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[3] ^ q[0]), .q(q[1]));
            else 
                dff inst0 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[k-1]), .q(q[k]));
        end
     endgenerate
endmodule