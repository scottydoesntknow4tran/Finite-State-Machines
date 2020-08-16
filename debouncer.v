// CPEN 230L lab 10 switch debouncer
// Rick Nungester 3/19/16

module debouncer (
  input      clk_i,         // 50 MHz clock
  input      noisy_i,       // noisy switch signal to debounce
  output reg clean_o );     // clean delayed switch state (Why reg?)

  // Procedural assignment statements, like those in an "always" block,
  // must assign to a variable (type reg or integer).  By making output
  // clean_o type reg, it can be assigned to in an always block.  This
  // could also be accomplished by declaring a separate reg
  // (e.g. clean_r), using it in the always block, and adding "assign
  // clean_o = clean_r" outside the always block.

  // 1/50e6 s/period * 2^19 periods ~= 10.5 ms default debounce time.
  // This is a parameter so it can be overridden in simulation
  // code, or in situations where 10.5 ms is too long or short.
  parameter cnt_bits = 19;

  reg [cnt_bits-1:0] sw_cnt = 1'b0;  // debounce delay counter
  reg sw_now;               // switch state at each posedge clk_i

  always @(posedge clk_i) begin
    sw_now <= noisy_i;      // sample current noisy switch state
    if (sw_now == clean_o)  // usual case, switch is stable
      sw_cnt <= 0;
    else begin              // debounce case, a switch toggle
      sw_cnt <= sw_cnt + 1'b1;
      if(sw_cnt == {cnt_bits{1'b1}})  // 2^cnt_bits - 1
        clean_o <= sw_now;  // if stable, change output
    end
  end
endmodule
