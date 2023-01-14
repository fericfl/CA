module register_8(
  input [7:0]i,
  input load, reverse, nibble, rotate_left, clk,rst,
  output reg [7:0] data
  );
  reg [7:0]a;
  always @(posedge clk, negedge rst) begin
    if(!rst)
      data='0;
    else
      begin
        if(nibble) begin
          data[7]=i[4];
          data[6]=i[5];
          data[5]=i[6];
          data[4]=i[7];
          data[3]=i[0];
          data[2]=i[1];
          data[1]=i[2];
          data[0]=i[3];
        end
        else if(load)
          data=i;
        else if(reverse) begin
        data[7]=i[0];
        data[6]=i[1];
        data[5]=i[2];
        data[4]=i[3];
        data[3]=i[4];
        data[2]=i[5];
        data[1]=i[6];
        data[0]=i[7];
      end
      else if(!rotate_left) begin
        data=i<<1;
      end
    else if(!rotate_left&&load)
      data=i<<1;
    else if(!rotate_left&&reverse) begin
        a[7]=i[0];
        a[6]=i[1];
        a[5]=i[2];
        a[4]=i[3];
        a[3]=i[4];
        a[2]=i[5];
        a[1]=i[6];
        a[0]=i[7];
        data=a<<1;
      end
    else if(!rotate_left&&nibble) begin
      data[7]=i[4];
          a[6]=i[5];
          a[5]=i[6];
          a[4]=i[7];
          a[3]=i[0];
          a[2]=i[1];
          a[1]=i[2];
          a[0]=i[3];
          data=a<<1;
    end
    end
  end
  endmodule
          
