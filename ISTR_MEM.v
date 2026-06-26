module ISTR_MEM(
  input [31:0] ADDR,
  output reg [31:0] INSTR
);
  reg [31:0] rom [31:0];
  initial begin 
    $readmemb("rectangle.txt", rom); 
  end
  always @(ADDR) begin
    INSTR = rom[ADDR[5:2]];
  end
endmodule
