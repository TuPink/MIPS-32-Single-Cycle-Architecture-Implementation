module MUX21 #(parameter DATA_WIDTH = 5)
  (input C,
   input [DATA_WIDTH-1:0] S0,S1,
   output [DATA_WIDTH-1:0] Y
  );
  assign Y =  C==1 ?  S1 : S0;
endmodule
