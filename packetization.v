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
  integer clkcount;
  // state variable
  integer state;
  
  always @ (posedge clk)
  begin
    // increment clock counter every posedge clk
    clkcount <= clkcount + 1 ;
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
            state <=3;
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
        
  // This is the combinational part
    always @ (negedge clk)
          begin
            case (state)
              0:
                begin
                  valid <=0;
                  flit <=32'dx;
                end
              1:
                begin
                  valid <=1;
                  flit <={2'b01,32'd1};
                end 
              2:
                begin
                  valid <=0;
                  flit <=32'dx;
                end 
              3:
                begin
                  valid <=1;
                  flit <= {2'b10,32'd3};
                end 
            endcase
  end 
  
endmodule
