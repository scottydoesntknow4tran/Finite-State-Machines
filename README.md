# Finite-State-Machines
This program creates a Finite State machine which is machine with many states that it can be in. 
The machine responds to an input to determine the next state and eventually an output. This is a way of creating simple machine with functioning memory, like a key pad.
This particular machine takes a switch as a binay input and indicates with a light when 4 zeros have been iput in a row
This works by having states of the machine that each have two paths which is decide by the binary input
If the switch is 0 the state move to state closer to the output state
If the the switch is 1 the state moves back to the beginning and so must have 4 zeros in a row to display the light
This essential give the machine memory and alows it to make decision base on past and current input
