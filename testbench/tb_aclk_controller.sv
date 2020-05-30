//Testbench

module tb_aclk_controller;
  parameter cycle = 40; //After looking at the waveforms, please leave atleast one time period between intervals.
  
  reg clk,reset,one_second,alarm_button,time_button;
  reg [3:0] key;
  
  wire reset_count,load_new_c,show_new_time,show_a,load_new_a,shift;
  
  aclk_controller controller_instance(.clk(clk),.reset(reset),.one_second(one_second),.alarm_button(alarm_button),.time_button(time_button),.key(key),.reset_count(reset_count),.load_new_c(load_new_c),.show_new_time(show_new_time),.show_a(show_a),.load_new_a(load_new_a),.shift(shift));
  
  always begin
    #(cycle/2);
    clk = ~clk;
  end

  initial $monitor("At state = '%b'",controller_instance.state);
  
  /*WORKED PERFECTLY
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,controller_instance);
    
    //Initialize
    reset = 0;
    one_second = 0;
    alarm_button = 0;
    time_button = 0;
    clk = 0;
    //-----------
    
    //-----------Testing reset
    reset = 1;
    reset = 0;
    //-----------

    //-----------Testing states
    key = 4'b0010;    
    #40
    key = 4'b0011; 
    #40
    key = 4'b0101; 
    #40
    key = 4'b1001;
    #40
    alarm_button = 1;
    #40
    time_button = 1;
    #40
    //alarm_button = 0;
    //time_button = 0;
    //reset = 1;
    #100
    $finish;
    $display("\n---Inside end within initial statement---");      
  end*/
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,controller_instance);
    
    //Initialize
    reset = 0;
    one_second = 0;
    alarm_button = 0;
    time_button = 0;
    clk = 0;
    //-----------
    
    //-----------Testing reset
    reset = 1;
    #10
    reset = 0;
    //-----------

    //-----------Testing states
    key = 4'b0010; //State1
    //-----Testing-10second-rule--------
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1    
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1    
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1
    one_second = 1;
    #1
    one_second = 0;
    #1
    //----------------------------------
    key = 4'b0101; //Should reject this key because it is received after 10 seconds
    #40
    key = 4'b0010;    
    #40
    key = 4'b0011; 
    #40
    key = 4'b0101; 
    #40
    key = 4'b1001;
    #40
    alarm_button = 1;
    #40
    time_button = 1;
    #40
    //alarm_button = 0;
    //time_button = 0;
    //reset = 1;
    #100
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
