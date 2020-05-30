//Testbench
`timescale 1us/1us

module tb_aclk_counter;
  reg clk,reset,shift;
  reg [3:0] key;
  
  wire [3:0] key_buffer_ms_hr,key_buffer_ls_hr,key_buffer_ms_min,key_buffer_ls_min;
  
  key_register kr_instance(.clk(clk),.reset(reset),.key(key),.shift(shift),.key_buffer_ms_hr(key_buffer_ms_hr),.key_buffer_ls_hr(key_buffer_ls_hr),.key_buffer_ms_min(key_buffer_ms_min),.key_buffer_ls_min(key_buffer_ls_min));
  
  always
    #5 clk = ~clk;
  
  initial begin
    $display("\n---Inside begin within initial statement---");
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    //-----------
    reset=0;
    key=4'b0000;
    shift=0;
    reset=1;
    #10
    reset=0;
    //-----------

    //-----------
    shift=1;
    key=4'b0001;
    #10
    shift=1;
    key=4'b0010;
    #10
    shift=1;
    key=4'b0101;
    #10
    shift=1;
    key=4'b1001;
    #10
    //-----------

    $finish;
    $display("\n---Inside end within initial statement---");      
  end
  
endmodule
