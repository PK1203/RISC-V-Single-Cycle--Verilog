
// alu_decoder.v - logic for ALU decoder

module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] a	
);

always @(*) begin
    case (ALUOp)
        2'b00: 	a = 4'b0000;             // addition
        2'b01: 	 a= 4'b0001;             // subtraction
        default:
            case (funct3) // R-type or I-type ALU
                3'b000: begin
                    // True for R-type subtract
                    if   (funct7b5 & opb5) 	 a= 4'b0001; //sub
                    else 	a = 4'b0000; // add, addi
                end
                3'b001:  	a = 4'b0100; //sll, slli
                3'b010:  	a = 4'b0101; // slt, slti
                3'b011:  	 a= 4'b0101; // sltu, sltiu (doubtful)
                3'b100:  	 a= 4'b0110; // xor, xori
                3'b101: begin
                    if (funct7b5) 	a = 4'b0111; // srl, srli
                    else 	a = 4'b1000;          // sra, srai
                end
                3'b110:  a	 = 4'b0011; // or, ori
                3'b111:  	a = 4'b0010; // and, andi
                default: 	a = 4'bxxxx; // ???
            endcase
    endcase
end

endmodule
