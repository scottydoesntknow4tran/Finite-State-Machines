// CPEN 230L lab 11, Sequence of 4 0s or 1s Finite State Machine
// Scott Tornquist 12/3/2019

module seq4FSM (
  input        Clock,  // posedge triggered
  input        nReset, // active low synchronous reset
  input        w,      // main FSM input
  output       z,      // main output, 1 indicates a w seq of 4
  output [3:0] curr_state,    // for demo/diagnostics
  output [3:0] next_state );  // for demo/diagnostics

  parameter  // state assignment (minimum flip-flops, not one-hot)
    A = 4'd0, B = 4'd1, C = 4'd2, D = 4'd3, E = 4'd4,
    F = 4'd5, G = 4'd6, H = 4'd7, I = 4'd8;

  // registers for use in "always" block procedural assignments
  reg [3:0] curr_state_r;
  reg [3:0] next_state_r;

  // See textbook Figure 6.29 on p356. Define the *combinational*
  // circuit that defines next state, using *blocking* assignment "=".
  always @(curr_state_r, w)
    case (curr_state_r)
      A: if (!w) next_state_r = B; else next_state_r = F;
		B: if (!w) next_state_r = C; else next_state_r = F;
		C: if (!w) next_state_r = D; else next_state_r = F;
		D: if (!w) next_state_r = E; else next_state_r = F;
		E: if (!w) next_state_r = E; else next_state_r = F;
		F: if (!w) next_state_r = B; else next_state_r = G;
		G: if (!w) next_state_r = B; else next_state_r = H;
		H: if (!w) next_state_r = B; else next_state_r = I;
		I: if (!w) next_state_r = B; else next_state_r = I;
      // Write this part to complete the state diagram. 
      default:   next_state_r = 4'bxxxx;  // required, not all 16 used
    endcase

  // Define the *sequential* circuit implemented with flip-flops, using
  // *non-blocking* assignment "<=".  The reset signal doesn't appear in
  // the sensitivity list because we want a *synchronous* reset.
  always @(posedge Clock)
	// complete the always block
	begin
		if (!nReset)
			curr_state_r <= A;
		else
			curr_state_r <= next_state_r;
	end

  // Define the *combinational* circuit that sets outputs based on the
  // current state of the FSM.
  assign z = ((curr_state_r == E) || (curr_state_r == I));
  assign curr_state = curr_state_r;
  assign next_state = next_state_r;

endmodule
