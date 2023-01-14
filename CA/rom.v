module rom #(parameter aw=10, dw=32, file="rom_file.txt")(
  input clk,rst_b,
  input [aw-1:0] addr,
  output reg [dw-1:0] data
);
  reg [dw-1:0] mem[0:2**aw-1];
  initial
    $readmemh(file,mem,0,2**aw-1);
  always @ (posedge clk, negedge rst_b)
    if (rst_b == 0)   data<=0;
    else              data<=mem[addr];
endmodule

module rom_tb;
  reg clk, rst_b; reg [3:0] addr;
  wire [15:0] data;

  rom #(.aw(4), .dw(16), .file("cordic_consts.txt")) inst0 (.clk(clk), .rst_b(rst_b), .addr(addr), .data(data));

  localparam CLK_PERIOD = 100, CLK_CYCLES = 17, RST_PULSE = 25;

  initial begin
    clk = 0;
    repeat(CLK_CYCLES*2)
    #(CLK_PERIOD/2) clk = 1 - clk;
  end

  initial begin
    rst_b = 0;
    #(RST_PULSE) rst_b = 1;
  end

  integer k;
  initial for (k = 0; k < CLK_CYCLES; k = k + 1) begin
    addr = k;
    #(CLK_PERIOD);
  end  
endmodule