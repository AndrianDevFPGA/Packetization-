/*
  Author : Rakotojaona Nambinina
  email : Andrianoelisoa.rakotojaona@gmail.com
  Description : Example of packetization in network on Chip
*/

module packetization(
       clk,
       rst,
       ready,
       flit,
       valid
       );
  parameter FLIT_DATA_WIDTH = 32;
  parameter FLIT_TYPE_WIDTH = 2;
  parameter FLIT_WIDTH = FLIT_DATA_WIDTH + FLIT_TYPE_WIDTH;
  
  // input port
  input clk;
  input rst;
  input ready;
  // output port
  output valid;
  output [FLIT_WIDTH-1:0] flit;
  
  // counter
  int clkcount;
  // state variable
  int state;
  
  always @ (posedge clk)
  begin
    // increment clock counter every posedge clk
    if (rst)
    begin
      state <=0;
      clkcount <=0;
    end
    else
    begin
      // state machine
      case (state)
        0:
        begin
          // wait for clock cycle equal 3
          if (clkcount ==5)
          begin
            state <=1;
          end 
        end
        1:
        begin
          if (ready)
          begin
            state <=2;
            clkcount <=0;
          end 
        end
        2:
        begin
          // wait for clock cycle equal 2
          if (clkcount ==2)
          begin
            state <=3
          end 
        end
        3:
        begin
          // send the second flit 
          if (ready)
          begin
            state <=0;
            clkcount <=0;
          end 
        end 
      endcase
    end 
  end 
  
endmodule
