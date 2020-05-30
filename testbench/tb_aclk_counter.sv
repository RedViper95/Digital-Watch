//Testbench
`timescale 1us/1us

module tb_aclk_counter;
  reg clk,reset,one_minute,load_new_c;
  reg [3:0] new_current_time_ms_hr,new_current_time_ls_hr,new_current_time_ms_min,new_current_time_ls_min;
  
  wire [3:0] current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min;
  
  aclk_counter counter_instance(.clk(clk),.reset(reset),.one_minute(one_minute),.load_new_c(load_new_c),.new_current_time_ms_hr(new_current_time_ms_hr),.new_current_time_ls_hr(new_current_time_ls_hr),.new_current_time_ms_min(new_current_time_ms_min),.new_current_time_ls_min(new_current_time_ls_min),.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min));
  
  always
    #5 clk = ~clk;
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    //-----------
    reset = 1;
    one_minute = 0;
    load_new_c = 0;
    new_current_time_ms_hr = 4'b0010; //2
    new_current_time_ls_hr = 4'b0011; //23
    new_current_time_ms_min = 4'b0101; //23:5
    new_current_time_ls_min = 4'b1000; //23.58
    #10
    //-----------

    //-----------
    reset = 0;
    one_minute = 0;
    load_new_c = 1;
    new_current_time_ms_hr = 4'b0010; //2
    new_current_time_ls_hr = 4'b0011; //23
    new_current_time_ms_min = 4'b0101; //23:5
    new_current_time_ls_min = 4'b1000; //23.58
    #10
    //-----------
    
    //-----------
    reset = 0;
    one_minute = 1;
    load_new_c = 0;
    new_current_time_ms_hr = 4'b0010; //2
    new_current_time_ls_hr = 4'b0011; //23
    new_current_time_ms_min = 4'b0101; //23:5
    new_current_time_ls_min = 4'b1000; //23.58
    #10
    one_minute = 0;
    #10
    //-----------

    //-----------
    reset = 0;
    one_minute = 1;
    load_new_c = 0;
    new_current_time_ms_hr = 4'b0010; //2
    new_current_time_ls_hr = 4'b0011; //23
    new_current_time_ms_min = 4'b0101; //23:5
    new_current_time_ls_min = 4'b1000; //23.58
    #10
    //-----------

    #10
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
