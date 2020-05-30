//Testbench

//Issues to be fixed:key inputs not shown.

//
/*Tested:
--> setting current_time and alarm_time.
--> showing current_time after alarm_button is released.
--> stopwatch/fastcount is working.
--> corner case transitions from 23:59 to 00:00 etc work perfectly.
--> sound alarm is working when current time is same as alarm time.
--> keys not continously loaded into key register like before.
*/

`timescale 1us/1us

module tb_alarm_clk_rtl;  
  reg clk,reset,stopwatch,one_second,alarm_button,time_button;
  reg [3:0] key;
  
  wire [7:0] display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min;
  wire sound_alarm;
  
  alarm_clk_rtl alarm_clk_rtl_instance(.clk(clk),.reset(reset),.stopwatch(stopwatch),.alarm_button(alarm_button),.time_button(time_button),.key(key),.sound_alarm(sound_alarm),.display_time_ms_hr(display_time_ms_hr),.display_time_ls_hr(display_time_ls_hr),.display_time_ms_min(display_time_ms_min),.display_time_ls_min(display_time_ls_min));
  
  always
    #1950 clk = ~clk; //998400 is one second and 59904000 is one minute
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1,alarm_clk_rtl_instance,alarm_clk_rtl_instance.aclk_controller_instance,alarm_clk_rtl_instance.time_generator_instance,alarm_clk_rtl_instance.aclk_lcd_display);
    
    //start clk
    clk = 1'b0;
    //---------
    
    //Initialize
    reset = 0;
    stopwatch = 0;
    alarm_button = 0;
    time_button = 0;
    reset = 1;
    reset = 0;
    key = 4'b0000;
    //---------
   
    //-set-time
    #3900
    time_button = 1;
    #1
    time_button = 0;
    #3900
    key = 4'b0010;
    #3900
    key = 4'b0011;
    #3900
    key = 4'b0101;
    #3900
    key = 4'b0101;
    #3900
    time_button = 1;
    #1
    time_button = 0;
    //---------
    //---------
    #3900
    time_button = 1;
    #1
    time_button = 0;
    #3900
    key = 4'b0010;
    #3900
    key = 4'b0010;
    #3900
    key = 4'b0100;
    #3900
    key = 4'b1001;
    #3900
    time_button = 1;
    #1
    time_button = 0;
    //---------
    //alarm-time
    #3900
    alarm_button = 1;
    #1
    alarm_button = 0;
    #3900
    key = 4'b0001;
    #3900
    key = 4'b0000;
    #3900
    key = 4'b0100;
    #3900
    key = 4'b0000;
    #3900
    alarm_button = 1;
    #1
    alarm_button = 0;
    //----------
    //sound-alarm
    #3900
    time_button = 1;
    #1
    time_button = 0;
    #3900
    key = 4'b0001;
    #3900
    key = 4'b0000;
    #3900
    key = 4'b0100;
    #3900
    key = 4'b0000;
    #3900
    time_button = 1;
    #1
    time_button = 0;
    #3900
    stopwatch = 1;
    #998400
    stopwatch = 0;
    //---------
    
    
    /*//-set-time
    #3900
    key = 4'b0010;
    #3900
    key = 4'b0011;
    #3900
    key = 4'b0101;
    #3900
    key = 4'b1001;
    #3900
    time_button = 1;
    #3900
    time_button = 0;
    //---------*/
    
    #59904000
    #3900    
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
