module ALU (
    input [31:0] A, B,
    input [2:0] ALUCONTROL, 
    output reg [31:0] RESULT
);
    always @(*) begin
        case(ALUCONTROL)
            3'b000: RESULT = A + B;      
            3'b001: RESULT = A - B;       
            3'b010: RESULT = A & B;       
            3'b011: RESULT = A | B;       
            3'b100: RESULT = A ^ B;       
          3'b101: RESULT = (A < B) ? 1 : 0; 
            default: RESULT = 32'b0;
        endcase
    end
endmodule
