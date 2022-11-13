module cmp2b(
    input [1:0] x, y,
    output eq, lt, gt
);
    assign eq = x == y;
    assign lt = x < y;
    assign gt = x > y;
endmodule

module cmp2b_tb;
    reg [1:0] x, y;
    wire eq, lt, gt;
    
    cmp2b cut (
        .x(x), .y(y), .eq(eq), .lt(lt), .gt(gt)
    );

    integer k;
    initial begin
        $display("Time\tx\ty\teq\tlt\tgt");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, x, y, eq, lt, gt);
        for(k = 0; k < 16; k = k + 1) begin
            {x, y} = k;
            #10;
        end
    end
endmodule