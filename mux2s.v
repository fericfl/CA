module mux2s #(
    parameter w = 4
)(
    input [1:0] s,
    input [w-1:0] d0, d1, d2, d3,
    output reg [w-1:0] o
);
    always @ (*) begin
        if(s == 0)
            assign o = d0;
        else if(s == 1)
            assign o = d1;
        else if (s == 2)
            assign o = d2;
        else assign o = d3;
    end
    
endmodule

// w = 8; 10 distinct input configurations

module mux2s_tb(
    output reg [1:0] s,
    output reg [7:0] d0, d1, d2, d3,
    output wire [7:0] o
);

    //instance code...
    mux2s # (.w(8)) inst0 (
        .s(s), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .o(o)
    );

    integer k;
    initial begin
        for (k = 0; k < 10; k = k + 1) begin
            s = k;
            {d0, d1, d2, d3} = $urandom();
            #10;
        end
    end
endmodule