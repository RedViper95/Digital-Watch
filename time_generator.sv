// Design
// 
//`timescale 1us/1us

module time_generator(clk,reset,reset_count,fast_watch,one_minute,one_second);
  
  input clk,reset,reset_count,fast_watch;
  output reg one_minute,one_second;
  
  integer clock_cycles = 0;
  integer minute_threshold = 15360; //Use 512 for quick testing.
  
  always @(fast_watch)
    if(fast_watch)
      minute_threshold = 256;
    else
      minute_threshold = 15360;
  
  always @(reset_count,reset)
    if((reset_count == 1) || (reset == 1)) begin
      one_second = 0;
      one_minute = 0;
      clock_cycles = 0;
    end
  
  always @(negedge clk) begin
    one_second = 0;
    one_minute = 0;
    if(clock_cycles && (clock_cycles%256 == 0))
      one_second = 1;
    if(clock_cycles && (clock_cycles%minute_threshold == 0))
      one_minute = 1;
    clock_cycles = clock_cycles+1;
  end
  
endmodule
