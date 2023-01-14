module dff(
    input clk, rst_b, set_b, d, output reg q
);
    //add code here...
    always @(posedge clk, negedge rst_b, negedge set_b)
        if(! set_b)         q <= 1;
        else if(! rst_b)    q <= 0;
        else                q <= d;
endmodule
