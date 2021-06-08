// MIN-MAX-SELECTOR module
// Inputs:
// 	[R,G,B] = [0..255] in 8 bits
//    [r,g,b] = [0..1] in 2.16 fixed point
// Outputs:
//    D           = [0.255] in 8 bits
//		maxplusmin  = [0..1] in 2.16 fixed point
// 	maxminusmin = [0..1] in 2.16 fixed point
//    TOP         = [0..1] in 2.16 fixed point
//    RGB_SE		= [0,1,2,3] corresponding to [red, green, blue]

module max_min_selector (
input wire  [7:0]  R,
input wire  [7:0]  G,
input wire  [7:0]  B,
input wire  [17:0] r,
input wire  [17:0] g,
input wire  [17:0] b,
input wire         CLK,

output reg  [17:0] max_min,
output reg  [17:0] max,
output reg  [17:0] min,
output reg  [7:0]  D,
output reg  [7:0]  MAX,
output reg  [17:0] TOP,
output reg  [2:0]  RGB_SE
);

wire r_g, r_b, g_b;

assign r_g = ( R > G ) ? 1'b1 : 1'b0; 
assign r_b = ( R > B ) ? 1'b1 : 1'b0; 
assign g_b = ( G > B ) ? 1'b1 : 1'b0;

always@( posedge CLK )
begin

	case ({r_g,r_b,g_b})
	
	3'b000:
			begin//b g r
			max     <= b;
			min     <= r;
			max_min <= b - r;
			MAX     <= B;
			D       <= B - R;
			TOP     <= g - r;//-
			RGB_SE  <= 3'b000;
			end
			
	3'b001:
			begin//g b r
			max     <= g;
			min     <= r;
			max_min <= g - r;
			MAX     <= G;
			D       <= G - R;
			TOP     <= b - r;//+
			RGB_SE  <= 3'b001;
			end
			
	3'b011:
			begin//g r b
			max     <= g;
			min     <= b;
			max_min <= g - b;
			MAX     <= G;
			D       <= G - B;
			TOP     <= r - b;//-
			RGB_SE  <= 3'b011;
			end
			
	3'b100:
			begin//b r g
			max     <= b;
			min     <= g;
			max_min <= b - g;
			MAX     <= B;
			D       <= B - G;
			TOP     <= r - g;//+
			RGB_SE  <= 3'b100;
			end
			
	3'b110:
			begin//r b g
			max     <= r;
			min     <= g;
			max_min <= r - g;
			MAX     <= R;
			D       <= R - G;
			TOP     <= b - g;//+
			RGB_SE  <= 3'b110;
			end
			
	3'b111:
			begin//r g b
			max     <= r;
			min     <= b;
			max_min <= r - b;
			MAX     <= R;
			D       <= R - B;
			TOP     <= g - b;//-
			RGB_SE  <= 3'b111;
			end
			
	default :
	      begin
			max     <= 18'h0;
			min     <= 18'h0;
			max_min <= 18'h0;
			MAX     <= 8'h0;
			D       <= 8'h0;
			TOP     <= 18'h0;
			RGB_SE  <= 3'b010;
			end
			
	endcase
	
end

endmodule