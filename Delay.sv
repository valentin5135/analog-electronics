module Del #(parameter delay = 2, d_width = 1 )
(
    input   [d_width-1:0] in,
	 input                 en,
    output  [d_width-1:0] out,
    
    input clk
);
         
reg [delay:0][d_width-1:0] d_reg;

assign d_reg[0] = in;
assign out = d_reg[delay];
 
genvar i ;

generate
   for (i=0; i< delay; i=i+1) begin: DELAY_
     	always @(posedge clk) 
        begin
		   if( en == 1 )
			  begin
            d_reg[i+1] <= d_reg[i];
			  end
      end
   end
endgenerate

endmodule