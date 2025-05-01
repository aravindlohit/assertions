module tb;
  reg clk1 ,clk2,reset,din;
  wire dout;
  initial begin:generate_clock
    clk1=0;
    while(1) #5 clk1= ~clk1;
  end
  
  initial begin:generate_clock2
    clk2=0;
    while(1) #4 clk2= ~clk2;
  end
  
  cdc uut (
        .clk1(clk1),
        .clk2(clk2),
    .din(din),
    .reset(reset),
    .dout(dout)
    );
  
  initial 
    begin
      reset<=0;
      din<=0;
      #10;
      reset<=1;
      #10;
      din<=1;
      $display("%d" , dout);
      
      #10
      din<=0;
       $display("%d" , dout);
      #10
      din<=1;
      
      #100$finish;
      
    end
  
   property p_stability;
    @(posedge clk2)
  ##1 !$stable(din) |=> $stable(din) [*2];
endproperty : p_stability

property p_no_glitch;
  logic data;
  @(din)
  (1, data = !din) |=>
  @(posedge clk1)
  (din == data);
endproperty : p_no_glitch

assert property(p_stability);
assert property(p_no_glitch);
  
  initial
   begin
     $dumpfile("dump.vcd");
     $dumpvars(0, tb.uut);
   end
  
  
endmodule
      
