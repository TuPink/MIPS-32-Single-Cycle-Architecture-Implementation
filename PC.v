module PC (
    input wire clk,         
    input wire rst_n,             
  output reg [31:0] Y       
);
    always @(posedge clk) begin
        if (!rst_n) begin
            Y <= 32'b0; 
        end
        else begin
            Y <= Y+32'd4; 
        end
    end
endmodule
