// Design
//`timescale 1us/1us

module key_register(clk,reset,key,shift,key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min);
  input clk,reset,shift;
  input [3:0] key;
  
  output reg [3:0] key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min;
  
  reg [3:0] intermediate_register;
  
  task swap; //Definition for a task is different compared to modules, in tasks input, output are just defined inside
    input [3:0] source;
    output [3:0] destination;
    
    destination = source;
    /*@(clk) begin //Within a task if you're assigning a value to a reg then use this @ and get on with it. reg need to be assigned only within procedural statements like always,initial etc or at declaration;
      destination = source;
    end*/
    
  endtask
  
  always @(posedge clk) begin //new key must be available 
    if(shift) begin
      swap(key_buffer_ls_hr,key_buffer_ms_hr);
      swap(key_buffer_ms_min,key_buffer_ls_hr);
      swap(key_buffer_ls_min,key_buffer_ms_min);
      swap(key,key_buffer_ls_min);
    end
    
    if(reset) begin
      key_buffer_ms_hr = 0;
      key_buffer_ls_hr = 0;
      key_buffer_ms_min = 0;
      key_buffer_ls_min = 0;
    end  
  end
endmodule
