// MAXPLUSMIN LUT
// This module takes in the sum of MAX and MIN (both in [0..255]), thus
// MAXPLUSMIN = [0..510], and converts it to a multiplier value equivalent
// to 1/(max+min) (max, min = [0..1]). For saturation, depending on luminance, 
// the divisor will either be (max + min) or (2-(max+min)), so for the second
// case, we simply look up the value in reverse order.
module divbymaxLUT (
	input  [7:0] in,
(* ramstyle = "logic" *)	output reg [31:0] out
);
	
	always @(*) begin
     case (in)
			8'd0: out = 32'h00000000;
			8'd1: out = 32'h00ff0000;
			8'd2: out = 32'h007f8000;
			8'd3: out = 32'h00550000;
			8'd4: out = 32'h003fc000;
			8'd5: out = 32'h00330000;
			8'd6: out = 32'h002a8000;
			8'd7: out = 32'h00246db6;
			8'd8: out = 32'h001fe000;
			8'd9: out = 32'h001c5555;
			8'd10: out = 32'h00198000;
			8'd11: out = 32'h00172e8b;
			8'd12: out = 32'h00154000;
			8'd13: out = 32'h00139d89;
			8'd14: out = 32'h001236db;
			8'd15: out = 32'h00110000;
			8'd16: out = 32'h000ff000;
			8'd17: out = 32'h000f0000;
			8'd18: out = 32'h000e2aaa;
			8'd19: out = 32'h000d6bca;
			8'd20: out = 32'h000cc000;
			8'd21: out = 32'h000c2492;
			8'd22: out = 32'h000b9745;
			8'd23: out = 32'h000b1642;
			8'd24: out = 32'h000aa000;
			8'd25: out = 32'h000a3333;
			8'd26: out = 32'h0009cec4;
			8'd27: out = 32'h000971c7;
			8'd28: out = 32'h00091b6d;
			8'd29: out = 32'h0008cb08;
			8'd30: out = 32'h00088000;
			8'd31: out = 32'h000839ce;
			8'd32: out = 32'h0007f800;
			8'd33: out = 32'h0007ba2e;
			8'd34: out = 32'h00078000;
			8'd35: out = 32'h00074924;
			8'd36: out = 32'h00071555;
			8'd37: out = 32'h0006e453;
			8'd38: out = 32'h0006b5e5;
			8'd39: out = 32'h000689d8;
			8'd40: out = 32'h00066000;
			8'd41: out = 32'h00063831;
			8'd42: out = 32'h00061249;
			8'd43: out = 32'h0005ee23;
			8'd44: out = 32'h0005cba2;
			8'd45: out = 32'h0005aaaa;
			8'd46: out = 32'h00058b21;
			8'd47: out = 32'h00056cef;
			8'd48: out = 32'h00055000;
			8'd49: out = 32'h0005343e;
			8'd50: out = 32'h00051999;
			8'd51: out = 32'h00050000;
			8'd52: out = 32'h0004e762;
			8'd53: out = 32'h0004cfb2;
			8'd54: out = 32'h0004b8e3;
			8'd55: out = 32'h0004a2e8;
			8'd56: out = 32'h00048db6;
			8'd57: out = 32'h00047943;
			8'd58: out = 32'h00046584;
			8'd59: out = 32'h00045270;
			8'd60: out = 32'h00044000;
			8'd61: out = 32'h00042e29;
			8'd62: out = 32'h00041ce7;
			8'd63: out = 32'h00040c30;
			8'd64: out = 32'h0003fc00;
			8'd65: out = 32'h0003ec4e;
			8'd66: out = 32'h0003dd17;
			8'd67: out = 32'h0003ce54;
			8'd68: out = 32'h0003c000;
			8'd69: out = 32'h0003b216;
			8'd70: out = 32'h0003a492;
			8'd71: out = 32'h0003976f;
			8'd72: out = 32'h00038aaa;
			8'd73: out = 32'h00037e3f;
			8'd74: out = 32'h00037229;
			8'd75: out = 32'h00036666;
			8'd76: out = 32'h00035af2;
			8'd77: out = 32'h00034fca;
			8'd78: out = 32'h000344ec;
			8'd79: out = 32'h00033a54;
			8'd80: out = 32'h00033000;
			8'd81: out = 32'h000325ed;
			8'd82: out = 32'h00031c18;
			8'd83: out = 32'h00031281;
			8'd84: out = 32'h00030924;
			8'd85: out = 32'h00030000;
			8'd86: out = 32'h0002f711;
			8'd87: out = 32'h0002ee58;
			8'd88: out = 32'h0002e5d1;
			8'd89: out = 32'h0002dd7b;
			8'd90: out = 32'h0002d555;
			8'd91: out = 32'h0002cd5c;
			8'd92: out = 32'h0002c590;
			8'd93: out = 32'h0002bdef;
			8'd94: out = 32'h0002b677;
			8'd95: out = 32'h0002af28;
			8'd96: out = 32'h0002a800;
			8'd97: out = 32'h0002a0fd;
			8'd98: out = 32'h00029a1f;
			8'd99: out = 32'h00029364;
			8'd100: out = 32'h00028ccc;
			8'd101: out = 32'h00028656;
			8'd102: out = 32'h00028000;
			8'd103: out = 32'h000279c9;
			8'd104: out = 32'h000273b1;
			8'd105: out = 32'h00026db6;
			8'd106: out = 32'h000267d9;
			8'd107: out = 32'h00026217;
			8'd108: out = 32'h00025c71;
			8'd109: out = 32'h000256e6;
			8'd110: out = 32'h00025174;
			8'd111: out = 32'h00024c1b;
			8'd112: out = 32'h000246db;
			8'd113: out = 32'h000241b2;
			8'd114: out = 32'h00023ca1;
			8'd115: out = 32'h000237a6;
			8'd116: out = 32'h000232c2;
			8'd117: out = 32'h00022df2;
			8'd118: out = 32'h00022938;
			8'd119: out = 32'h00022492;
			8'd120: out = 32'h00022000;
			8'd121: out = 32'h00021b81;
			8'd122: out = 32'h00021714;
			8'd123: out = 32'h000212bb;
			8'd124: out = 32'h00020e73;
			8'd125: out = 32'h00020a3d;
			8'd126: out = 32'h00020618;
			8'd127: out = 32'h00020204;
			8'd128: out = 32'h0001fe00;
			8'd129: out = 32'h0001fa0b;
			8'd130: out = 32'h0001f627;
			8'd131: out = 32'h0001f252;
			8'd132: out = 32'h0001ee8b;
			8'd133: out = 32'h0001ead3;
			8'd134: out = 32'h0001e72a;
			8'd135: out = 32'h0001e38e;
			8'd136: out = 32'h0001e000;
			8'd137: out = 32'h0001dc7f;
			8'd138: out = 32'h0001d90b;
			8'd139: out = 32'h0001d5a3;
			8'd140: out = 32'h0001d249;
			8'd141: out = 32'h0001cefa;
			8'd142: out = 32'h0001cbb7;
			8'd143: out = 32'h0001c880;
			8'd144: out = 32'h0001c555;
			8'd145: out = 32'h0001c234;
			8'd146: out = 32'h0001bf1f;
			8'd147: out = 32'h0001bc14;
			8'd148: out = 32'h0001b914;
			8'd149: out = 32'h0001b61e;
			8'd150: out = 32'h0001b333;
			8'd151: out = 32'h0001b051;
			8'd152: out = 32'h0001ad79;
			8'd153: out = 32'h0001aaaa;
			8'd154: out = 32'h0001a7e5;
			8'd155: out = 32'h0001a529;
			8'd156: out = 32'h0001a276;
			8'd157: out = 32'h00019fcb;
			8'd158: out = 32'h00019d2a;
			8'd159: out = 32'h00019a90;
			8'd160: out = 32'h00019800;
			8'd161: out = 32'h00019577;
			8'd162: out = 32'h000192f6;
			8'd163: out = 32'h0001907d;
			8'd164: out = 32'h00018e0c;
			8'd165: out = 32'h00018ba2;
			8'd166: out = 32'h00018940;
			8'd167: out = 32'h000186e5;
			8'd168: out = 32'h00018492;
			8'd169: out = 32'h00018245;
			8'd170: out = 32'h00018000;
			8'd171: out = 32'h00017dc1;
			8'd172: out = 32'h00017b88;
			8'd173: out = 32'h00017957;
			8'd174: out = 32'h0001772c;
			8'd175: out = 32'h00017507;
			8'd176: out = 32'h000172e8;
			8'd177: out = 32'h000170d0;
			8'd178: out = 32'h00016ebd;
			8'd179: out = 32'h00016cb1;
			8'd180: out = 32'h00016aaa;
			8'd181: out = 32'h000168a9;
			8'd182: out = 32'h000166ae;
			8'd183: out = 32'h000164b8;
			8'd184: out = 32'h000162c8;
			8'd185: out = 32'h000160dd;
			8'd186: out = 32'h00015ef7;
			8'd187: out = 32'h00015d17;
			8'd188: out = 32'h00015b3b;
			8'd189: out = 32'h00015965;
			8'd190: out = 32'h00015794;
			8'd191: out = 32'h000155c7;
			8'd192: out = 32'h00015400;
			8'd193: out = 32'h0001523d;
			8'd194: out = 32'h0001507e;
			8'd195: out = 32'h00014ec4;
			8'd196: out = 32'h00014d0f;
			8'd197: out = 32'h00014b5e;
			8'd198: out = 32'h000149b2;
			8'd199: out = 32'h0001480a;
			8'd200: out = 32'h00014666;
			8'd201: out = 32'h000144c6;
			8'd202: out = 32'h0001432b;
			8'd203: out = 32'h00014193;
			8'd204: out = 32'h00014000;
			8'd205: out = 32'h00013e70;
			8'd206: out = 32'h00013ce4;
			8'd207: out = 32'h00013b5c;
			8'd208: out = 32'h000139d8;
			8'd209: out = 32'h00013858;
			8'd210: out = 32'h000136db;
			8'd211: out = 32'h00013562;
			8'd212: out = 32'h000133ec;
			8'd213: out = 32'h0001327a;
			8'd214: out = 32'h0001310b;
			8'd215: out = 32'h00012fa0;
			8'd216: out = 32'h00012e38;
			8'd217: out = 32'h00012cd4;
			8'd218: out = 32'h00012b73;
			8'd219: out = 32'h00012a15;
			8'd220: out = 32'h000128ba;
			8'd221: out = 32'h00012762;
			8'd222: out = 32'h0001260d;
			8'd223: out = 32'h000124bc;
			8'd224: out = 32'h0001236d;
			8'd225: out = 32'h00012222;
			8'd226: out = 32'h000120d9;
			8'd227: out = 32'h00011f93;
			8'd228: out = 32'h00011e50;
			8'd229: out = 32'h00011d10;
			8'd230: out = 32'h00011bd3;
			8'd231: out = 32'h00011a98;
			8'd232: out = 32'h00011961;
			8'd233: out = 32'h0001182b;
			8'd234: out = 32'h000116f9;
			8'd235: out = 32'h000115c9;
			8'd236: out = 32'h0001149c;
			8'd237: out = 32'h00011371;
			8'd238: out = 32'h00011249;
			8'd239: out = 32'h00011123;
			8'd240: out = 32'h00011000;
			8'd241: out = 32'h00010edf;
			8'd242: out = 32'h00010dc0;
			8'd243: out = 32'h00010ca4;
			8'd244: out = 32'h00010b8a;
			8'd245: out = 32'h00010a72;
			8'd246: out = 32'h0001095d;
			8'd247: out = 32'h0001084a;
			8'd248: out = 32'h00010739;
			8'd249: out = 32'h0001062b;
			8'd250: out = 32'h0001051e;
			8'd251: out = 32'h00010414;
			8'd252: out = 32'h0001030c;
			8'd253: out = 32'h00010206;
			8'd254: out = 32'h00010102;
			8'd255: out = 32'h00010000;
			default: out = out;
		endcase
	end
endmodule