module DATAPATH(
  input rst_n, clk, 
  input REGDST, REGWRITE, ALUSRC, MEMWRITE, MEMREAD, MEMTOREG,
  input [2:0] ALUCONTROL,
  output [5:0] OP
);
  
  wire [31:0] ADDR, INSTR, SIGN_EXTEND, WD, A, B, RD2, RESULT, READDATA;
  wire [4:0] WR;
  
  assign OP = INSTR[31:26];

  PC                       dut0 (.Y(ADDR), .rst_n(rst_n),.clk(clk));
  ISTR_MEM                 dut1 (.ADDR(ADDR),.INSTR(INSTR));
  MUX21 #(.DATA_WIDTH(5))  dut2 (.S0(INSTR[20:16]),.S1(INSTR[15:11]),.C(REGDST),.Y(WR));
  SIGN_EXTEND              dut3 (.INSTR(INSTR[15:0]),.SIGN_EXTENDED(SIGN_EXTEND));
  REG_FILE                 dut4 (.RR1(INSTR[25:21]),.RR2(INSTR[20:16]),.WR(WR),.WD(WD),.rst_n(rst_n),.RD1(A),.RD2(RD2),.clk(clk),.REGWRITE(REGWRITE));
  MUX21 #(.DATA_WIDTH(32)) dut5 (.S0(RD2),.S1(SIGN_EXTEND),.C(ALUSRC),.Y(B));
  ALU                      dut6 (.A(A),.B(B),.ALUCONTROL(ALUCONTROL),.RESULT(RESULT));
  DATA_MEMORY              dut7 (.ADDR(RESULT),.clk(clk),.rst_n(rst_n),.WRITEDATA(RD2),.READDATA(READDATA),.MEMWRITE(MEMWRITE),.MEMREAD(MEMREAD));
  MUX21 #(.DATA_WIDTH(32)) dut8 (.S1(READDATA),.S0(RESULT),.Y(WD),.C(MEMTOREG));

endmodule
