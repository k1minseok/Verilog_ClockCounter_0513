`timescale 1ns / 1ps

module mux21 (
    input sel,
    input [7:0] x0,
    input [7:0] x1,

    output reg [7:0] y
);
    always @(*) begin  // * : 모든 변수 감시
        case (sel)
            1'b0:   y = x0;
            1'b1:   y = x1;
            default: y = x0;
        endcase
    end

endmodule