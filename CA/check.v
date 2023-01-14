module check (
    input [4:0] i,
    output o
);
        assign o = (i % 8 == 0);
endmodule