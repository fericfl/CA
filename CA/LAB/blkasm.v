module blkasm (
    input [32:0] data,
    input avl,
    output [463:0] blk;
);
    reg [28:0] field;
    reg [3:0] position;
    reg [3:0] packet_count;

    reg block_complete;
    
    initial begin
        blk = 464'bz;
        block_complete = 0;
    end

    always @(avl or data) begin
        field = data[28:0];
        position = data[32:29];
        packet_count = packet_count + 1;
    end
    
    
endmodule