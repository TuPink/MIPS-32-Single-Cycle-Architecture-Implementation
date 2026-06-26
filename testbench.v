`timescale 1ns/1ps

module CPU_TOP_tb();
  reg clk;
  reg rst_n;
  wire REGDST;
  TOPMODULE dut (
    .clk(clk),
    .rst_n(rst_n),
    .REGDST(REGDST)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    rst_n = 0;
    #7;          
    rst_n = 1;    
    #20000;
    $display("Mo phong hoan tat.");
    $stop;
  end

  initial begin
    $monitor("Time: %0t | Reset: %b | REGDST: %h", $time, rst_n, REGDST);
  end

  initial begin
  $dumpfile("dump.vcd"); 
    $dumpvars();      
end

endmodule
