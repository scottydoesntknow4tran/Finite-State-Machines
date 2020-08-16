// CPEN230L lab 11, convert binary 1..9 to A..I on a 7-segment display
// Scott Tornquist, 12/3/2019

module a2i7seg (
  input  [3:0] code_i,
  output [6:0] disp_o );

  assign disp_o = (code_i == 4'd0) ? 7'b0001000 : // A
                  (code_i == 4'd1) ? 7'b0000011 : // b
                  (code_i == 4'd2) ? 7'b1000110 : // C
                  (code_i == 4'd3) ? 7'b0100001 : // d
                  (code_i == 4'd4) ? 7'b0000110 : // E
                  (code_i == 4'd5) ? 7'b0001110 : // F
                  (code_i == 4'd6) ? 7'b0010000 : // G 
                  (code_i == 4'd7) ? 7'b0001001 : // H
                  (code_i == 4'd8) ? 7'b1111001 : // I (1)
                                     7'bxxxxxxx;
endmodule
						