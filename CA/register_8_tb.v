module register_8_tb;
  reg [7:0]i;
  reg load, reverse, nibble, rotate_left, clk,rst;
  wire [7:0] data;
register_8 bonds(
  .i(i),
  .load(load),
  .reverse(reverse),
  .nibble(nibble),
  .rotate_left,
  .clk(clk),
  .rst(rst),
  .data(data)
);

initial begin
    clk = 0;
    repeat(14) #10 clk = ~clk;
end
initial begin
rst=0;
i=8'b10101010;
#30;
rst=1;
nibble=1;
#20;
load=1;
nibble=0;
#20;
load=0;
reverse=1;
#20;
reverse=0;
rotate_left=0;
#20;
reverse=1;
#20;
reverse=0;
nibble=1;
#20;
end
endmodule
