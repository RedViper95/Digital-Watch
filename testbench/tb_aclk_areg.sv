module tb_aclk_areg;
  reg clk,reset,load_new_a;
  reg [3:0] new_alarm_ms_hr,new_alarm_ls_hr,new_alarm_ms_min,new_alarm_ls_min;
  
  wire [3:0] alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min;
  
  aclk_areg alarm_reg(.clk(clk),.reset(reset),.load_new_a(load_new_a),.new_alarm_ms_hr(new_alarm_ms_hr),.new_alarm_ls_hr(new_alarm_ls_hr),.new_alarm_ms_min(new_alarm_ms_min),.new_alarm_ls_min(new_alarm_ls_min),.alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min));
 
  always
    #5 clk = ~clk;
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    //-----------
	new_alarm_ms_hr = 4'b1000;
    new_alarm_ls_hr = 4'b0001;
    new_alarm_ms_min = 4'b0010;
    new_alarm_ls_min = 4'b0100;
    reset = 1;
    load_new_a = 0;
    #10
    //-----------

    //-----------
	new_alarm_ms_hr = 4'b0001;
    new_alarm_ls_hr = 4'b0010;
    new_alarm_ms_min = 4'b0100;
    new_alarm_ls_min = 4'b1000;
    reset = 0;
    load_new_a = 1;
    #10
    //-----------
    
    //-----------
	new_alarm_ms_hr = 4'b1000;
    new_alarm_ls_hr = 4'b0001;
    new_alarm_ms_min = 4'b0010;
    new_alarm_ls_min = 4'b0100;
    reset = 0;
    load_new_a = 0;
    #10
    //-----------
    
    #10
    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
