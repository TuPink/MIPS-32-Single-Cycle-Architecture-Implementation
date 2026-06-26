module CU (
    input [5:0] OP,
    output reg REGDST, REGWRITE, ALUSRC, MEMWRITE, MEMREAD, MEMTOREG,
    output reg [2:0] ALUCONTROL 
);
    always @ (*) begin
       
        {REGDST, REGWRITE, ALUSRC, MEMWRITE, MEMREAD, MEMTOREG, ALUCONTROL} = 0;
        
        case(OP)
            6'b000001: begin 
                REGWRITE = 1; REGDST = 1; ALUCONTROL = 3'b000;
            end
            
            6'b000010: begin 
                MEMWRITE = 1; ALUSRC = 1; ALUCONTROL = 3'b000;
            end
            
            6'b000100: begin 
                REGWRITE = 1; MEMREAD = 1; MEMTOREG = 1; ALUSRC = 1; ALUCONTROL = 3'b000;
            end
            
            6'b001000: begin 
                REGWRITE = 1; ALUSRC = 1; ALUCONTROL = 3'b000;
            end
            
            6'b010000: begin 
                REGWRITE = 1; REGDST = 1; ALUCONTROL = 3'b101;
            end
            
            6'b001110: begin 
                REGWRITE = 1; ALUSRC = 1; ALUCONTROL = 3'b100;
            end
        endcase
    end
endmodule
