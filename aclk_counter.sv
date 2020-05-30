// Design

module aclk_counter(clk,reset,one_minute,load_new_c,new_current_time_ms_hr,new_current_time_ls_hr,new_current_time_ms_min,new_current_time_ls_min,current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min);
  
  input clk,reset,one_minute,load_new_c;
  input [3:0] new_current_time_ms_hr,new_current_time_ls_hr,new_current_time_ms_min,new_current_time_ls_min;
  output reg [3:0] current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min;
  integer anomaly;
  
  always @(reset,one_minute,load_new_c) begin
    anomaly = 0;
    if(reset) begin
	    current_time_ms_hr = 0;
        current_time_ls_hr = 0;
        current_time_ms_min = 0;
        current_time_ls_min = 0;
    end else begin    
      if(load_new_c) begin
	      current_time_ms_hr = new_current_time_ms_hr;
          current_time_ls_hr = new_current_time_ls_hr;
          current_time_ms_min = new_current_time_ms_min;
          current_time_ls_min = new_current_time_ls_min;
      end else begin
        if(one_minute) begin
        
          //Taking care of min/hour transitions. The below if's are in a particular order to detect transitions because of if else priority.
          if((current_time_ms_hr == 4'b0010) && (current_time_ls_hr == 4'b0011) && (current_time_ms_min == 4'b0101) && (current_time_ls_min == 4'b1001)) begin
            current_time_ms_hr = 0;
            current_time_ls_hr = 0;
            current_time_ms_min = 0;
            current_time_ls_min = 0;
            anomaly = 1;
          end
          if((current_time_ls_hr == 4'b1001) && (current_time_ms_min == 4'b0101) && (current_time_ls_min == 4'b1001)) begin
            current_time_ms_hr = current_time_ms_hr+1;
            current_time_ls_hr = 0;
            current_time_ms_min = 0;
            current_time_ls_min = 0;
            anomaly = 1;
          end
          if((current_time_ms_min == 4'b0101) && (current_time_ls_min == 4'b1001)) begin
            current_time_ls_hr = current_time_ls_hr+1;
            current_time_ms_min = 0;
            current_time_ls_min = 0;
            anomaly = 1;
          end
          if(current_time_ls_min == 4'b1001) begin
            current_time_ms_min = current_time_ms_min+1;
            current_time_ls_min = 0;
            anomaly = 1;
          end
          //--------------------------------------
          
          //Minute increments
          if(!anomaly)
            current_time_ls_min = current_time_ls_min+1;
          //-----------------
            
        end //one_minute if
      end //load_new_c if
    end //reset if
  end //always
  
endmodule
