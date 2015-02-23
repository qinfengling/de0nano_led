/*
 * A basic module / template for the DE0-Nano board
 */

`define COUNTER_SIZE 32 // 32 bits
`define CONST_50M    50000000 // 50M

module basics(
  //////////// CLOCK //////////
  input 		          		CLOCK_50,
  //////////// LED //////////
  output		     [7:0]		LED,
  //////////// KEY //////////
  input                                   	KEY
);

  /*
  Register instantiation
  */
  reg  [`COUNTER_SIZE-7:00] count;
  reg  [7:0] disp;

  assign reset = ~KEY;
  assign LED[7:0] = {disp[7:0]};

  // simple counter to divide up the clock in order
  // to create a slower frequency clock
  always @(posedge CLOCK_50) begin
    if (reset == 1'b1) begin
      count <= 0;
    end
    else begin
      count <= count + 1;
      if (count == `CONST_50M) begin
        if (disp == 0) begin
          disp <= 1'b1;
        end
        else begin
          disp <= (disp << 1) % 8'hFF;
          count <= 0;
        end
      end
    end
  end
endmodule
