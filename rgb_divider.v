// DIVIDER MODULE
// Inputs:
// 	[R,G,B] = [0..255] in 8 bits
// Outputs:
//    [r,g,b] = [0..1] in 2.16 fixed point

module rgb_divider (
input  wire [7:0]  R,
input  wire [7:0]  G,
input  wire [7:0]  B,
input  wire        CLK,

output reg  [7:0]  RO,
output reg  [7:0]  GO,
output reg  [7:0]  BO,
output reg  [17:0] ro,
output reg  [17:0] go,
output reg  [17:0] bo
);

wire [17:0] r, g, b;
// Look up the red value
dividerLUT R_ (
.in  (R),
.out (r)
);

// Look up the green value
dividerLUT G_ (
.in  (G),
.out (g)
);

// Look up the blue value
dividerLUT B_ (
.in  (B),
.out (b)
);

always@( posedge CLK )
begin
 RO <= R;
 GO <= G;
 BO <= B;
 
 ro <= r;
 go <= g;
 bo <= b;

end

endmodule
