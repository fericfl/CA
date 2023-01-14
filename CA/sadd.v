module sadd (
    input clk, rst_b, x, y,
    output reg z
);

    localparam S0_ST = 0;
    localparam S1_ST = 1;

    reg st;
    reg st_nxt;

    always @ (*)
        case(st)
            S0_ST: if(x & y) st_nxt = S1_ST;
                   else      st_nxt = S0_ST;
            S1_ST: if(~x&~y) st_nxt = S0_ST;
                   else      st_nxt = S1_ST;
            default:         st_nxt = S0_ST;
        endcase

    always @ (*) begin
        z = 0; //set default value for all outputs
        case(st)
            S0_ST:  if(x^y)     z = 1;
            S1_ST:  if(x~^y)    z = 1;
            default:            z = 0;    
        endcase        
    end

    always @ (posedge clk, negedge rst_b)
        if(! rst_b)     st <= S0_ST;
        else            st <= st_nxt;

endmodule

module sadd_tb;
    reg clk, rst_b, x, y;
    wire z;

    sadd inst0 (
        .clk(clk), .rst_b(rst_b), .x(x), .y(y), .z(z)
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
        {x, y} = 'b11;
        #(CLK_PERIOD) {x,y} = 'b10;
        #(CLK_PERIOD) {x,y} = 'b11;
        #(CLK_PERIOD) {x,y} = 'b00;
    end
endmodule