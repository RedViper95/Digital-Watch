// Design

`timescale 1us/1us

`include "time_generator.sv"
`include "aclk_controller.sv"
`include "aclk_keyreg.sv"
`include "aclk_counter.sv"
`include "aclk_areg.sv"
`include "aclk_lcd_display.sv"

module alarm_clk_rtl(clk,reset,stopwatch,alarm_button,time_button,key,sound_alarm,display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min);
  
  input clk,reset,stopwatch,alarm_button,time_button;
  input [3:0] key;
  output [7:0] display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min;
  output sound_alarm;
  
  wire one_minute,one_second,reset_count,load_new_c,show_current_time,show_a,load_new_a,shift; //show_new_time is actually show_current_time, as keys are entered the display will not change. show_new_time will be set to 1 whenever alarm_button is not pressed. This is what takes care of displaying current time.
  wire [3:0] key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min;
  wire [3:0] current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min;
  wire [3:0] alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min;
  
  time_generator time_generator_instance(.clk(clk),.reset(reset),.reset_count(reset_count),.fast_watch(stopwatch),.one_minute(one_minute),.one_second(one_second));
  
  aclk_controller aclk_controller_instance(.clk(clk),.reset(reset),.one_second(one_second),.alarm_button(alarm_button),.time_button(time_button),.key(key),.reset_count(reset_count),.load_new_c(load_new_c),.show_current_time(show_current_time),.show_a(show_a),.load_new_a(load_new_a),.shift(shift));
  
  key_register key_register_instance(.clk(clk),.reset(reset),.key(key),.shift(shift),.key_buffer_ms_hr(key_buffer_ms_hr),.key_buffer_ls_hr(key_buffer_ls_hr),.key_buffer_ms_min(key_buffer_ms_min),.key_buffer_ls_min(key_buffer_ls_min));
  
  aclk_counter aclk_counter_instance(.clk(clk),.reset(reset),.one_minute(one_minute),.load_new_c(load_new_c),.new_current_time_ms_hr(key_buffer_ms_hr),.new_current_time_ls_hr(key_buffer_ls_hr),.new_current_time_ms_min(key_buffer_ms_min),.new_current_time_ls_min(key_buffer_ls_min),.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min));
  
  aclk_areg aclk_areg_instance(.clk(clk),.reset(reset),.load_new_a(load_new_a),.new_alarm_ms_hr(key_buffer_ms_hr),.new_alarm_ls_hr(key_buffer_ls_hr),.new_alarm_ms_min(key_buffer_ms_min),.new_alarm_ls_min(key_buffer_ls_min),.alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min));
  
  aclk_lcd_display aclk_lcd_display(.show_a(show_a),.show_current_time(show_current_time),.alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min),.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min),.key_ms_hr(key_buffer_ms_hr),.key_ls_hr(key_buffer_ls_hr),.key_ms_min(key_buffer_ms_min),.key_ls_min(key_buffer_ls_min),.sound_alarm(sound_alarm),.display_time_ms_hr(display_time_ms_hr),.display_time_ls_hr(display_time_ls_hr),.display_time_ms_min(display_time_ms_min),.display_time_ls_min(display_time_ls_min));
  
endmodule
