module pktmux(
    input [63:0] msg_len, pkt,
    input pad_pkt, zero_pkt, mgln_pkt,
    output reg [63:0] o
);
    //write your code here
    always @ (*)
        if(pad_pkt)         o = {1'b1, 63'b0};
        else if(zero_pkt)   o = 64'b0;
        else if(mgln_pkt)   o = msg_len;
        else                o = pkt;
endmodule

module pktmux_tb;
    task urand64(output reg [63:0] o);
        begin
            o[63:32] = $urandom();
            o[31:0]  = $urandom();
        end
    endtask

    reg [63:0] msg_len, pkt;
    reg pad_pkt, zero_pkt, mgln_pkt;
    wire [63:0] o;

    pktmux inst0 (
        .msg_len(msg_len), .pkt(pkt), .pad_pkt(pad_pkt),
        .zero_pkt(zero_pkt), .mgln_pkt(mgln_pkt), .o(o)
    );

    initial begin
        {pad_pkt, zero_pkt, mgln_pkt} = 3'b000;
        #100 {pad_pkt, zero_pkt, mgln_pkt} = 3'b100;
        #100 {pad_pkt, zero_pkt, mgln_pkt} = 3'b010;
        #100 {pad_pkt, zero_pkt, mgln_pkt} = 3'b001;
        #100 {pad_pkt, zero_pkt, mgln_pkt} = 3'b000;
    end

    initial 
        repeat (5) begin
            urand64(pkt);
            urand64(msg_len);
            #100;
        end
endmodule