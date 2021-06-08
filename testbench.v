module testbench;
    
    reg CLK;
    reg [9:0] R_i;
    reg [9:0] G_i;
    reg [9:0] B_i;
    reg [63:0] HSV;

    wire [9:0] R_o;
    wire [9:0] G_o;
    wire [9:0] B_o;
    wire [24:0] H_o;
    wire [17:0] S_o;
    wire [17:0] V_o;

    hsv_adjust tb(.CLK(CLK),
                 .R(R_i),
                 .G(G_i),
                 .B(B_i),
                 .HSV(HSV),

                 .RO(R_o),
                 .GO(G_o),
                 .BO(B_o),
                 .H(H_o),
                 .S(S_o),
                 .V(V_o)
                 );
    initial begin
                CLK = 0;
                R_i = 0;
		G_i = 0;
		B_i = 0;
                HSV = 0;
                #10 	R_i = 180;
			G_i = 36;
			B_i = 120;
                        HSV = 0;
                #80 	
                        HSV = 64'b000010000000000000100000000000000010000000000000000001100;
                #10 	
                        HSV = 64'b001010011100010000100000001110000010010100011100001101101;
                #10 	
                        HSV = 0;
    end
    always #5 CLK=~CLK;
endmodule