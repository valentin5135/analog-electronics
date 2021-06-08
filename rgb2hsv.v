module  rgb2hsv(	
	input wire [9:0]          R,
	input wire [9:0]          G,
	input wire [9:0]          B,
	input wire                CLK,
	
	output reg [24:0] 		  H, //  0 - 360
	output reg [17:0] 		  S, //  0 - 1 float 2_16
	output reg [17:0] 		  V  //  0 - 1 float 2_16
);

wire [2:0]  rgb_se;
wire [7:0]  RO, GO, BO, D, MAX, d_del;
wire [24:0] hue;
wire [17:0] ro, go, bo, top, max,min, max_min, saturation, value;
wire [31:0] hdivisor, sdivisor;
reg  [31:0] cutoffhmult;

reg  [63:0] hmult;
reg  [63:0] smult;

reg  [31:0] hr;

wire  [2:0]  rgb_se_del;  //direction

rgb_divider RGB_D_(
.R   ( R[9:2] ),  // [7:0]
.G   ( G[9:2] ),  // [7:0]
.B   ( B[9:2] ),  // [7:0]
.CLK ( CLK ),

.RO  ( RO ),      // [7:0]
.GO  ( GO ),      // [7:0]
.BO  ( BO ),      // [7:0]
.ro  ( ro ),      // [17:0] [0..1] in 2.16 fixed point
.go  ( go ),      // [17:0] [0..1] in 2.16 fixed point
.bo  ( bo )       // [17:0] [0..1] in 2.16 fixed point
);
// 1 CLK

max_min_selector MAX_MIN_SEL_(
.R           ( RO ),      // [7:0]
.G           ( GO ),      // [7:0]
.B           ( BO ),      // [7:0]
.r           ( ro ),      // [17:0] [0..1] in 2.16 fixed point
.g           ( go ),      // [17:0] [0..1] in 2.16 fixed point
.b           ( bo ),      // [17:0] [0..1] in 2.16 fixed point
.CLK         ( CLK ),

.max_min     ( max_min ), // [17:0] [0..1] in 2.16 fixed point
.max         ( max ),     // [17:0] [0..1] in 2.16 fixed point
.min         ( min ),     // [17:0] [0..1] in 2.16 fixed point
.D           ( D ),       // [7:0]
.MAX         ( MAX ),     // [7:0]
.TOP         ( top ),     // [17:0] [0..1] in 2.16 fixed point
.RGB_SE      ( rgb_se )   // [2:0]
);
// 1 CLK

// Instantiate the LUT of (60/D) values, D = max - min 255 .. 0
reciprocalLUT DIV_D_ (
.in  ( D ),      
.out ( hdivisor )
);

// Instantiate the LUT of (1/max) values, max 255 .. 0
divbymaxLUT DIV_MAX_(
.in  ( MAX ),
.out ( sdivisor )
);

reg [17:0] t, r;
reg [31:0] hdiv, sdiv;
	
always@( posedge CLK )
begin
  
  t    <= top;
  r    <= max_min;
  hdiv <= hdivisor;
  sdiv <= sdivisor;
  
  hmult      <= { 14'h0, t } * hdiv;
  smult      <= { 14'h0, r } * sdiv;

end
// 2 CLK

Del #( .delay ( 2 ), .d_width ( 8 ) )  //2
D_DEL_(
.in     ( D ),
.en     ( 1'b1 ),
.out    ( d_del ), 
.clk    ( CLK )
);

Del #( .delay ( 3 ), .d_width ( 3 ) )  //2
SE_DEL_(
.in     ( rgb_se ),
.en     ( 1'b1 ),
.out    ( rgb_se_del ), 
.clk    ( CLK )
);

Del #( .delay ( 2 ), .d_width ( 18 ) )  //1
S_DEL_(
.in     ( smult[33:16] ),
.en     ( 1'b1 ),
.out    ( saturation ), 
.clk    ( CLK )
);

Del #( .delay ( 4 ), .d_width ( 18 ) ) //3
V_DEL_(
.in     ( max ),
.en     ( 1'b1 ),
.out    ( value ), 
.clk    ( CLK )
);

assign hue = hr[24:0];

// + - 120 240 360
always @ (posedge CLK)
begin

cutoffhmult <= ( d_del > 8'h0 ) ? { 9'h0, hmult[38:16] } : 32'hF00000;

case (rgb_se_del)
	
	3'b000:
			//b g r
			hr <= 32'hF00000  - cutoffhmult;//-
			
	3'b001:
			//g b r
			hr <= 32'h780000  + cutoffhmult;//+
			
	3'b011:
			//g r b
			hr <= 32'h780000  - cutoffhmult;//-
			
	3'b100:
			//b r g
			hr <= 32'hF00000  + cutoffhmult;//+
			
	3'b110:
			//r b g
			hr <= 32'h1680000 - cutoffhmult;//-
				
	3'b111:
			//r g b
			hr <= cutoffhmult;//+
			
	default:
			hr <= 32'h0;
	endcase
	
	H <= hue;
	S <= saturation;
	V <= value;
end
// 2 CLK

endmodule
