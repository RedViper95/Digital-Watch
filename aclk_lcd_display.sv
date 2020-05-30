// Design
// 

module aclk_lcd_display(show_a,show_current_time,alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min,current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min,key_ms_hr,key_ls_hr,key_ms_min,key_ls_min,sound_alarm,display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min);
  
  input show_a,show_current_time;
  input [3:0] alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min,current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min,key_ms_hr,key_ls_hr,key_ms_min,key_ls_min;
  
  output sound_alarm;
  output [7:0] display_time_ms_hr,display_time_ls_hr,display_time_ms_min,display_time_ls_min;
  
  reg [31:0] current_time,alarm_time = 32'haaaaaaaa;//Assigning a value just so that we can use this to operate alarm only when both current_time and alarm_time are set. Otherwise alarm will be triggered from start when both are not set.
  
  always @(current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min,alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min) begin
    current_time = {current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min};
    alarm_time = {alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min};
  end
  
  assign sound_alarm = (current_time!=32'haaaaaaaa)&&(alarm_time!=32'haaaaaaaa)&&(current_time === alarm_time);//Good place to use === so that the sound_alarm is not set to 'x' when '==' is used to evaluate third expression.
  
  aclk_lcd_driver digit_ms_hr(.show_a(show_a),.show_current_time(show_current_time),.alarm_time(alarm_time_ms_hr),.current_time(current_time_ms_hr),.key(key_ms_hr),.display_time(display_time_ms_hr));
  
  aclk_lcd_driver digit_ls_hr(.show_a(show_a),.show_current_time(show_current_time),.alarm_time(alarm_time_ls_hr),.current_time(current_time_ls_hr),.key(key_ls_hr),.display_time(display_time_ls_hr));
  
  aclk_lcd_driver digit_ms_min(.show_a(show_a),.show_current_time(show_current_time),.alarm_time(alarm_time_ms_min),.current_time(current_time_ms_min),.key(key_ms_min),.display_time(display_time_ms_min));
  
  aclk_lcd_driver digit_ls_min(.show_a(show_a),.show_current_time(show_current_time),.alarm_time(alarm_time_ls_min),.current_time(current_time_ls_min),.key(key_ls_min),.display_time(display_time_ls_min));
  
endmodule

module aclk_lcd_driver(show_a,show_current_time,alarm_time,current_time,key,display_time);
  input show_a,show_current_time;
  input [3:0] alarm_time,current_time,key;
  
  output reg [7:0] display_time;
  
  task BCD_LCD;
    //input four_bit_digit; Doing this scewed up the result, it takes only LSB and makes other 3 bits as 0 and uses this inside case. We need to declare as vector for it to consider all 4 bits given as input within the procedural statement.
    input [3:0] four_bit_digit;
    case(four_bit_digit)
      4'b0000: display_time = 8'h30;
      4'b0001: display_time = 8'h31;
      4'b0010: display_time = 8'h32;
      4'b0011: display_time = 8'h33;
      4'b0100: display_time = 8'h34;
      4'b0101: display_time = 8'h35;
      4'b0110: display_time = 8'h36;
      4'b0111: display_time = 8'h37;
      4'b1000: display_time = 8'h38;
      4'b1001: display_time = 8'h39;
      default: display_time = 8'h30;
    endcase
  endtask
  
  always @(show_a,show_current_time,alarm_time,current_time) begin
    if(show_a)
      if(!show_current_time) begin //Need begin and end if statements under if are more than 1.
        BCD_LCD(alarm_time);      
      end else begin
        BCD_LCD(0); //Error as we can't have both =1
      end
    else
      if(show_current_time) begin
        BCD_LCD(current_time);
      end else begin
        BCD_LCD(key);
      end
  end
  
endmodule
