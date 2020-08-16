// CPEN 230L lab 11, seq4FSM test bench
// John Tadrous, 11/20/2016. Rick Nungester, 3/30/16

`timescale 1s / 100ms

module seq4FSM_tb;
                            // DUT I/O
  reg        Clock_r;       // posedge triggered
  reg        nReset_r;      // active low synchronous reset
  reg        w_r;           // main FSM input
  wire       z_w;           // sequence of 4 0s or 1s
  wire [3:0] curr_state_w;  // current state
  wire [3:0] next_state_w;  // current state

  always                    // clock period = 1 second
    #0.5 Clock_r = ~Clock_r;

  initial begin                // simulation output definition
    $dumpfile("a.vcd");        // for GTKWave, else comment out
    $dumpvars(0, seq4FSM_tb);  // for GTKWave, else comment out
    $display("time  nReset  w  c_state  n_state  z");
    $monitor("%4d  %6b  %1b  %7d  %7d  %1b",
      $time, nReset_r, w_r, curr_state_w, next_state_w, z_w);

                           // Test Procedure
         Clock_r  = 1'b1;  // @t=0: Clock = 1 so +edges @t = 1, 2, 3...
         nReset_r = 1'b0;  //       reset
         w_r      = 1'b0;  //       main FSM input low
    #0.5 nReset_r = 1'b1;  // @t=0.5 release reset

    #3   w_r      = 1'b1;  // @t=3.5 w goes high, avoid z going high @t=4
    #1   w_r      = 1'b0;  // @t=4.5 w goes low to start a seq of 4 0s
                           // @t=8 z should go high, after seq of 4 0s
    #4   w_r      = 1'b1;  // @t=8.5 w high (start long pulse)
                           // @t=9 z should go low
                           // @t=12 z should go high, after seq of 4 1s
    #5   w_r      = 1'b0;  // @t=13.5 w low (end long pulse)
                           // @t=14 z should go low
                           // Next demonstrate the reset.
    #5   nReset_r = 1'b0;  // @t=18.5 z has gone high, reset on clock -edge
                           // @t=19 (next clock +edge) z should go low
    #1.5 $finish;          // @t=20, finish
  end

  seq4FSM fsm (            // instantiate the DUT
    .Clock      (Clock_r),
    .nReset     (nReset_r),
    .w          (w_r),
    .z          (z_w),
    .curr_state (curr_state_w),
    .next_state (next_state_w) );

endmodule
