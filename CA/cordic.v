module cordic(
    input clk, rst_b, bgn,
    input [15:0] theta,
    output [15:0] cos,
    output fin
);
    function [15:0] MUX(input s, input [15:0] d1, d0);
        begin
            MUX=(s) ? d1 : d0;
        end
    endfunction

    function [15:0] ArithRShift(input [15:0] i, input [3:0] p);
        reg [31:0] t;
        begin
            t={{16{i[15]}}, i} >> p;
            ArithRShift = t[15:0];
        end
    endfunction

    function [15:0] ADDSUB(input add, input [15:0] a,b);
        begin
            ADDSUB = MUX(add, a + b, a - b);    
        end
    endfunction
    wire [15:0] x, y, z, cnst;
    wire ld, init;
    wire [3:0] itr;
    wire[15:0] t_xrsh, t_yrsh, t_newx, t_newy, t_newz;

    assign t_xrsh = ArithRShift(x, itr);
    assign t_yrsh = ArithRShift(y, itr);
    assign t_newx = ADDSUB(z[15], x, ArithRShift(y,itr));
    assign t_newy = ADDSUB(~z[15], y, ArithRShift(x,itr));
    assign t_newz = ADDSUB(z[15], z, cnst);

    rgst #(.w(16)) inst0 (.clk(clk), .rst_b(rst_b), .ld(ld), .clr(1'd0), .q(x), .d(MUX(init, 16'h26dd, ADDSUB(z[15], x, ArithRShift(y,itr)))));

    rgst #(.w(16)) inst1 (.clk(clk), .rst_b(rst_b), .ld(ld), .clr(1'd0), .q(y), .d(MUX(init, 16'h0, ADDSUB(~z[15], y, ArithRShift(x,itr)))));

    cntr #(.w(4)) inst2 (.clk(clk), .rst_b(rst_b), .c_up(ld & ~(init)), .clr(init), .q(itr));

    cordicctrl inst3 (.clk(clk), .rst_b(rst_b), .bgn(bgn), .itr(itr), .ld(ld), .init(intit), .fin(fin));

    rgst 

    rom #(.aw(4), .dw(16), .file("cordic_atan.txt")) inst5 ()

    assign cos=x;
endmodule