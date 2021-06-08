module  hsv2rgb(	
input wire [24:0]         H,   // [24:0] [0..360] in 8.16 fixed point
input wire [17:0]         S,   // [17:0] [0..1] in 2.16 fixed point
input wire [17:0]         V,   // [17:0] [0..1] in 2.16 fixed point
input wire                CLK,	
	
output reg [9:0] 			  R, 
output reg [9:0] 			  G,
output reg [9:0] 			  B
);
	
wire [17:0] saturation, value, rw, gw, bw, fract;	
wire [2:0]  h_del; 
wire [24:0] hinw;

reg  [34:0] hdiv_60;
reg  [34:0] hue_1;
reg  [26:0] hue_2;
reg  [17:0] p, q, t, v, s; 
reg  [17:0] r_tmp, g_tmp, b_tmp;
reg  [24:0] hin, hue;
reg  [63:0] p_tmp, q_tmp, t_tmp;

reg  [63:0] smultf, 
            smultominf;

reg  [17:0] omins,
            ominf,
		   	ominsmultf, 
			   ominsmultominf;

wire [17:0] omins_del, ominsmultf_del;
					
Del #( .delay ( 4 ), .d_width ( 3 ) )
H_DEL_(
.in     ( hdiv_60[34:32]),
.en     ( 1'b1 ),
.out    ( h_del ), 
.clk    ( CLK )
);

Del #( .delay ( 4 ), .d_width ( 18 ) )
S_DEL_(
.in     ( S ),
.en     ( 1'b1 ),
.out    ( saturation ), 
.clk    ( CLK )
);

Del #( .delay ( 7 ), .d_width ( 18 ) )
V_DEL_(
.in     ( V ),
.en     ( 1'b1 ),
.out    ( value ), 
.clk    ( CLK )
);

Del #( .delay ( 2 ), .d_width ( 18 ) )
omins_DEL_(
.in     ( omins ),
.en     ( 1'b1 ),
.out    ( omins_del ), 
.clk    ( CLK )
);

Del #( .delay ( 1 ), .d_width ( 18 ) )
ominsmultf_DEL_(
.in     ( ominsmultf ),
.en     ( 1'b1 ),
.out    ( ominsmultf_del ), 
.clk    ( CLK )
);

assign hinw  = hin >= 25'h1680000 ? 25'h0 : hin ;
assign fract = { 2'h0, hdiv_60[31:16] };

always@( posedge CLK )
begin

 hin <= H;
 hue  <= hinw;
  
 hue_1 <= {hue,10'h0} + {hue,6'h0};// hue * 1024 + hue*64 + hue*4 = hue*1092 ~ hue/60
 hue_2 <= {hue,2'h0};
 
 hdiv_60 <= hue_1 + hue_2;
 
 omins     <= 18'h10000 - saturation;
 ominf     <= 18'h10000 - fract;
 smultf    <= {14'h0,saturation} * {14'h0,fract};
 s         <= saturation;
 
 ominsmultf  <= 18'h10000 - smultf[33:16];
 smultominf  <= {14'h0,s} * {14'h0,ominf};
 
 ominsmultominf <= 18'h10000 - smultominf[33:16];
 
 p_tmp            <= {14'h0,value} * {14'h0,omins_del};
 q_tmp            <= {14'h0,value} * {14'h0,ominsmultf_del};
 t_tmp            <= {14'h0,value} * {14'h0,ominsmultominf};
 v                <= value;
  
end

assign rw = r_tmp[16] == 1'h1 ? r_tmp[17:0] - 18'h1 : r_tmp[17:0];
assign gw = g_tmp[16] == 1'h1 ? g_tmp[17:0] - 18'h1 : g_tmp[17:0];
assign bw = b_tmp[16] == 1'h1 ? b_tmp[17:0] - 18'h1 : b_tmp[17:0];

always@(posedge CLK)
begin
  
  if( h_del == 3'h0 )
   begin
	 r_tmp <= v;
	 g_tmp <= t_tmp[33:16];
	 b_tmp <= p_tmp[33:16];
	end
	 else
	 if( h_del == 3'h1 )
	  begin
	   r_tmp <= q_tmp[33:16];
	   g_tmp <= v;
	   b_tmp <= p_tmp[33:16];
	  end
	   else
		 if( h_del == 3'h2 )
	     begin
	      r_tmp <= p_tmp[33:16];
	      g_tmp <= v;
	      b_tmp <= t_tmp[33:16];
	     end
		   else
			 if( h_del == 3'h3 )
	         begin
	          r_tmp <= p_tmp[33:16];
	          g_tmp <= q_tmp[33:16];
	          b_tmp <= v;
	         end
				 else
				  if( h_del == 3'h4 )
	             begin
	              r_tmp <= t_tmp[33:16];
	              g_tmp <= p_tmp[33:16];
	              b_tmp <= v;
	             end
					  else
						if( h_del == 3'h5 )
	                 begin
	                  r_tmp <= v;
	                  g_tmp <= p_tmp[33:16];
	                  b_tmp <= q_tmp[33:16]; 
	                 end

   R <= {rw[15:8],2'h0};
	G <= {gw[15:8],2'h0};
	B <= {bw[15:8],2'h0};
end	
	

endmodule