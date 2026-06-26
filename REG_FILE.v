module REG_FILE (
  input clk,
  input [4:0] RR1,RR2,WR,
  input [31:0] WD,
  input rst_n,
  input REGWRITE,
  output reg[31:0] RD1,RD2
);
  reg [31:0] ram [31:0];
  integer i;
  always@ (posedge clk) begin
    if(!rst_n) begin
      for (i=0; i<32;i+=1) begin
        ram[i] <= 32'b0;
    end
    end
      else if ( REGWRITE==1'b1 ) begin
      ram[WR] <= WD;
    end
  end
  always@(*) begin
    RD1 = ram [RR1];
    RD2= ram [RR2];
  end
endmodule
  
  
