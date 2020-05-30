`timescale 1us/1us

module tb_time_generator;
  reg clk,reset,reset_count,fast_watch;
  wire one_minute,one_second;
  
  time_generator tg_instance(.clk(clk),.reset(reset),.reset_count(reset_count),.fast_watch(fast_watch),.one_minute(one_minute),.one_second(one_second));
  
  always
    #1950 clk = ~clk; //998400 is one second and 59904000 is one minute
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 0;
    #998400
    //-----------

    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 0;    
    #59904000
    //-----------
    
    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 0;    
    #998400
    //-----------

    //-----------
    reset = 1;
    reset_count = 0;
    fast_watch = 0;    
    #998400
    //-----------

    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 0;    
    #998400
    //-----------

    //-----------
    reset = 0;
    reset_count = 1;
    fast_watch = 0;    
    #998400
    //-----------

    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 0;    
    #998400
    //-----------

    //-----------
    reset = 0;
    reset_count = 0;
    fast_watch = 1;
    #998400
    //-----------
    
    #998400
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
