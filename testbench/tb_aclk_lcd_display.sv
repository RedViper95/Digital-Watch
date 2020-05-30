module tb_aclk_lcd_display;
  reg show_a,show_current_time;
  reg [3:0] alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min,current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min,key_ms_hr,key_ls_hr,key_ms_min,key_ls_min;
 
  wire sound_alarm;
  wire [7:0] display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min;

  aclk_lcd_display lcd_display(.show_a(show_a),.show_current_time(show_current_time),.alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min),.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min),.key_ms_hr(key_ms_hr),.key_ls_hr(key_ls_hr),.key_ms_min(key_ms_min),.key_ls_min(key_ls_min),.sound_alarm(sound_alarm),.display_time_ms_hr(display_time_ms_hr),.display_time_ls_hr(display_time_ls_hr),.display_time_ms_min(display_time_ms_min),.display_time_ls_min(display_time_ls_min));
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    //-----------
    {alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min} = 16'b1001100110011001;
    {current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min} = 16'b1000100010001000;
    {key_ms_hr,key_ls_hr,key_ms_min,key_ls_min} = 16'b0111011101110111;
    show_current_time = 0;
    show_a = 1;
    #10
    //-----------

    //-----------
    {alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min} = 16'b1001100110011001;
    {current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min} = 16'b1000100010001000;
    {key_ms_hr,key_ls_hr,key_ms_min,key_ls_min} = 16'b0111011101110111;
    show_current_time = 1;
    show_a = 0;
    #10
    //-----------
    
    //-----------
    {alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min} = 16'b1001100110011001;
    {current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min} = 16'b1000100010001000;
    {key_ms_hr,key_ls_hr,key_ms_min,key_ls_min} = 16'b0111011101110111;
    show_current_time = 0;
    show_a = 0;
    #10
    //-----------
    
    #10
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule

module tb_aclk_lcd_driver;
  reg show_a,show_current_time;
  reg [3:0] alarm_time,current_time,key;
 
  wire sound_alarm;
  wire [7:0] display_time;

  aclk_lcd_driver lcd_driver(.show_a(show_a),.show_current_time(show_current_time),.alarm_time(alarm_time),.current_time(current_time),.key(key),.sound_alarm(sound_alarm),.display_time(display_time));
    
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    //-----------
    alarm_time = 4'b1001;
    current_time = 4'b1000;
    key = 4'b0111;
    show_current_time = 0;
    show_a = 1;
    #10
    //-----------

    //-----------
    alarm_time = 4'b1001;
    current_time = 4'b1000;
    key = 4'b0111;
    show_current_time = 1;
    show_a = 0;
    #10
    //-----------
    
    //-----------
    alarm_time = 4'b1001;
    current_time = 4'b1000;
    key = 4'b0111;
    show_current_time = 0;
    show_a = 0;
    #10
    //-----------
    
    #10
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule  
