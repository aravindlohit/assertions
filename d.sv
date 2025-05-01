module cdc (
  input logic din ,
  input clk1,clk2 , reset,
  output logic dout);
  
 logic  dout1;
  always @(posedge clk1)
    begin
    if(reset)
      begin
    
      
      dout1<=0;
      dout<=0;
      end
      else begin
    dout1<=din;
      end
    end
  always @(posedge clk2)
    begin
      if (reset)
        dout<=0;
      else
        dout<=dout1;
    end
  
  
  
  
endmodule
        
      
