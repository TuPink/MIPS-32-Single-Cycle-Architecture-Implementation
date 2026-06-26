
`include "MUX21.sv"
  `include "ALU.sv"
  `include "REG_FILE.sv"
  `include "ISTR_MEM.sv"
  `include "PC.sv"
  `include "DATA_MEMORY.sv"
  `include "SIGN_EXTEND.sv"
  `include "DATAPATH.sv"
  `include "CU.sv"

module TOPMODULE(
  input rst_n,
  input clk,
  output REGDST
); 
  
  wire  REGWRITE, ALUSRC, MEMWRITE,MEMREAD, MEMTOREG;
  wire [2:0]ALUCONTROL;
  wire [5:0]OP;
  DATAPATH dut0 (
  .rst_n(rst_n),.clk(clk), 
  .REGDST(REGDST), .REGWRITE(REGWRITE), .ALUSRC(ALUSRC), .MEMWRITE(MEMWRITE),.MEMREAD(MEMREAD),.MEMTOREG(MEMTOREG),
  .ALUCONTROL(ALUCONTROL),
  .OP(OP)
);
  CU dut1(
    .REGDST(REGDST), .REGWRITE(REGWRITE), .ALUSRC(ALUSRC), .MEMWRITE(MEMWRITE),.MEMREAD(MEMREAD),.MEMTOREG(MEMTOREG),
  .ALUCONTROL(ALUCONTROL),
  .OP(OP)
  );
endmodule
  
  
