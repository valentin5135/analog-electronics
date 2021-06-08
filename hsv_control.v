module  hsv_control(	 
input  wire [24:0]    H,
input  wire [17:0]    S,
input  wire [17:0]    V,
input  wire [63:0]    CNTL,
input  wire           CLK,

(* ramstyle = "logic" *) output reg  [24:0] 	 HO,
(* ramstyle = "logic" *) output reg  [17:0] 	 SO,
(* ramstyle = "logic" *) output reg  [17:0] 	 VO
);

wire signed [26:0]  hcor;
wire signed [31:0]  scor, vcor, sin, vin;

reg  signed [18:0]  sres, vres;
wire        [17:0]  sdel, vdel;

reg signed  [26:0]  hue; 
reg signed  [26:0]  h;   
reg signed  [63:0]  s, v;

reg         [17:0]  saturation, value;

assign hcor = {CNTL[25],CNTL[25:0]};
assign scor = {{14{CNTL[43]}},CNTL[43:26]};
assign vcor = {{14{CNTL[61]}},CNTL[61:44]};
assign sin  = {14'h0,S};
assign vin  = {14'h0,V};

Del #( .delay ( 1 ), .d_width ( 18 ) )  //1
V_DEL_(
.in     ( V ),
.en     ( 1'b1 ),
.out    ( vdel ), 
.clk    ( CLK )
);

Del #( .delay ( 1 ), .d_width ( 18 ) )  //1
S_DEL_(
.in     ( S ),
.en     ( 1'b1 ),
.out    ( sdel ), 
.clk    ( CLK )
);

always@( posedge CLK )
begin
 
 h <= $signed($signed({2'h0,H}) + $signed(hcor));
 
 s <= sin*scor;
 v <= vin*vcor;
 
 sres <= $signed($signed({sdel[17],sdel}) + $signed({s[63],s[33:16]}));
 vres <= $signed($signed({vdel[17],vdel}) + $signed({v[63],v[33:16]}));
 
 if( h[26] == 1 ) 
	begin
	 hue <= $signed($signed(27'h1680000) + $signed(h)); // 360
	end
	 else
	  if( h >= 27'h1680000 )
       begin
	     hue <= $signed($signed(h) - $signed(27'h1680000));
	    end
	     else
		   begin
			  hue <= h;
			end
 
 if( sres[18] == 1 )
   begin
	 SO <= 18'h00000;
	end
	 else
	  if( sres[17:0] >= 18'h10000 )
	    begin
		  SO <= 18'h10000;
		 end
		  else
		   begin
			 SO <= sres[17:0];
			end

 if( vres[18] == 1 )
   begin
	 VO <= 18'h00000;
	end
	 else
	  if( vres[17:0] >= 18'h10000 )
	    begin
		  VO <= 18'h10000;
		 end
		  else
		   begin
			 VO <= vres[17:0];
			end	
			
	HO <= hue[24:0];	
	
end

endmodule