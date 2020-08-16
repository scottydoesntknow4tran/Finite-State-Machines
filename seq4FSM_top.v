// CPEN 230L lab 11, Sequence of 4 FSM on the DE2-115 board
// Scott Tornquist, 12/3/2019

module seq4FSM_top (
  input        CLOCK_50,  // for debouncer
  input        KEY0,      // Clock (FSM input)
  input  [1:0] SW,        // w, nReset (FSM inputs)
  output       LEDG0,     // z (FSM output)
  output [6:0] HEX1,      // FSM current state (A b C d E F G H I)
  output [6:0] HEX0 );    // FSM next state

  wire KEY0_clean_w;        // debounced KEY0
  wire [3:0] curr_state_w;  // current state
  wire [3:0] next_state_w;  // next state

  // Clean up noisy KEY0 with debounce settling of 1/50e6 s/period *
  // 2^20 periods ~= 21.0 ms.
  debouncer #(.cnt_bits (20)) db1 (
    .clk_i   (CLOCK_50),
    .noisy_i (KEY0),
    .clean_o (KEY0_clean_w) );

  seq4FSM fsm (
    .Clock      (~KEY0_clean_w),  // key press = + edge
    .nReset     (SW[0]),          // active low synchronous reset
    .w          (SW[1]),          // main FSM input
    .z          (LEDG0),
    .curr_state (curr_state_w),
    .next_state (next_state_w) );

  a2i7seg decoder1 (      // current state to A..I on HEX1
    .code_i  (curr_state_w),
    .disp_o  (HEX1) );

  a2i7seg decoder0 (      // next state to A..I on HEX0
    .code_i  (next_state_w),
    .disp_o  (HEX0) );

endmodule
