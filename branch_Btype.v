
module branch_Btype(
	input [2:0] sel,
//	input [31:0] pctarget,
	input [31:0] rs1, rs2,
	input branch,
	output reg [31:0] select
);

reg flag;

always @(*) begin
if(branch) begin
	case(sel) 
		3'b000: flag<= rs1==rs2 ? 1 : 0;
		3'b001: flag<= rs1!=rs2 ? 1 : 0;
		3'b100: flag<= rs1<rs2 ? 1 : 0;
		3'b101: flag<= rs1>=rs2 ? 1 : 0;
		3'b110: begin
			if (rs1[31] != rs2[31]) flag <= rs1[31] ? 0 : 1;
         else flag <= rs1 < rs2 ? 1 : 0;
			end
		3'b111: begin
			if (rs1[31] != rs2[31]) flag <= rs1[31] ? 1 : 0;
         else flag <= rs1 >= rs2 ? 1 : 0;
			end
		default: flag<=0;
	endcase
	if(flag) select <= 1;
end
end
endmodule 
