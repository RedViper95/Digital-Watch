// Design

module aclk_controller(clk,reset,one_second,alarm_button,time_button,key,reset_count,load_new_c,show_current_time,show_a,load_new_a,shift);
  
  input clk,reset,one_second,alarm_button,time_button;
  input [3:0] key;
  
  output reset_count,load_new_c,show_current_time,show_a,load_new_a,shift;
  
  parameter IDLE=3'b000, //Showing current time
  			STATE1=3'b001, //Registered 1st key
  			STATE2=3'b010, //Registered 2nd key
  			STATE3=3'b011, //Registered 3rd key
  			STATE4=3'b100, //Registered 4th key
  			STATE5=3'b101; //Check for alarm_button or time_button
  
  reg [2:0] state,next_state,previous_state;
  reg [31:0] time_button_odd_clicks,alarm_button_odd_clicks = 0;  
  
  //Monitoring seconds------------
  integer second_count = 0;  
  always @(one_second) begin
    second_count = second_count+1;
  end
  //------------------------------

  //Monitoring time_button--------
  integer time_button_clicks = 0;
  always @(posedge time_button) begin
    time_button_clicks = time_button_clicks+1;
    if(time_button_clicks%2==0)
      time_button_odd_clicks = 0;
    else
      time_button_odd_clicks = 1;
  end
  //------------------------------

  //Monitoring alarm_button--------
  integer alarm_button_clicks = 0;
  always @(posedge alarm_button) begin
    alarm_button_clicks = alarm_button_clicks+1;
    if(alarm_button_clicks%2==0)
      alarm_button_odd_clicks = 0;
    else
      alarm_button_odd_clicks = 1;
  end
  //------------------------------
  
  //Assigning next_state to curent state
  always@(posedge clk or posedge reset) begin
    if(reset)
      state = IDLE;
    else
      state = next_state;
  end
  //------------------------------------
  
  //Computing next state based on inputs
  always@(state or key or alarm_button or time_button) begin
    case(state)      
      IDLE: begin
        if(time_button_odd_clicks||alarm_button_odd_clicks)
          next_state = STATE1; //reflects intent to set time or alarm
        else begin
          next_state = IDLE;
          second_count = 0; //Reset seconds counter
        end
      end
      STATE1: begin
        if((second_count<=10)&&(key<=4'b1001)&&(time_button_odd_clicks||alarm_button_odd_clicks))
          next_state = STATE2;//reflects that 1st key entered is valid and then move on to next key
        else begin
          next_state = IDLE;
          second_count = 0; //Reset seconds counter
        end
      end
      STATE2: begin
        if((second_count<=10)&&(key<=4'b1001)&&(time_button_odd_clicks||alarm_button_odd_clicks))
          next_state = STATE3;//reflects that 2nd key entered is valid and then move on to next key
        else begin
          next_state = IDLE;
          second_count = 0; //Reset seconds counter
        end
      end
      STATE3: begin
        if((second_count<=10)&&(key<=4'b1001)&&(time_button_odd_clicks||alarm_button_odd_clicks))
          next_state = STATE4;//reflects that 3rd key entered is valid and then move on to next key
        else begin
          next_state = IDLE;
          second_count = 0; //Reset seconds counter
        end          
      end
      STATE4: begin
        if((second_count<=10)&&(key<=4'b1001)&&(time_button_odd_clicks||alarm_button_odd_clicks))
          next_state = STATE5;//reflects that 4th key entered is valid and then move on to next key
        else begin
          next_state = IDLE;
          second_count = 0; //Reset seconds counter
        end
      end
      STATE5: begin
        next_state = IDLE;
        second_count = 0; //Reset seconds counter
      end
      default: next_state = IDLE;
    endcase
  end
  //------------------------------------
  
  assign reset_count = 0;
  assign load_new_c = (time_button == 1)&&(!time_button_odd_clicks); //Loads only when button is pressed
  assign load_new_a = (alarm_button == 1)&&(!alarm_button_odd_clicks); //Loads only when button is pressed
  assign show_current_time = (!alarm_button);//&&(state == STATE5));By default show time(this is connected to show_current_time) so it must be on and switch off only when alarm_button is pressed.
  assign show_a = (alarm_button == 1);//&&(state == STATE5));
  assign shift = (state == STATE1)||(state == STATE2)||(state == STATE3)||(state == STATE4)||(state == STATE5)&&(time_button_odd_clicks||alarm_button_odd_clicks); //The states that show validity of the key entered
  
  //time_button used to load_new_c.
  //alarm_button used to load_new_a.
  //show_a used to show alarm time for the period when it is on.
  //show_new_time used to show current time for the period when it is on.show_new_time is actually show_current_time
  
endmodule
