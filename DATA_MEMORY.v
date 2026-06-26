module DATA_MEMORY (
  input wire [31:0] ADDR,
  input rst_n,
  input clk,
  input wire [31:0] WRITEDATA,
  input wire MEMWRITE, MEMREAD,
  output reg [31:0] READDATA
);

  
  reg [31:0] ram [63:0]; 
  integer i;

  always @ (posedge clk) begin
    if (!rst_n) begin
 
      for (i=0; i < 64; i+=1) begin 
        ram[i] <= 32'b0; 
      end
    end 
    else if (MEMWRITE == 1'b1) begin
      ram[ADDR[31:2]] <= WRITEDATA;
    end
  end

  always @ (*) begin
    if (MEMREAD == 1'b1) begin
      READDATA = ram[ADDR[31:2]];
    end
    else begin
      READDATA = 32'b0;
    end
  end
  
endmodule
      
