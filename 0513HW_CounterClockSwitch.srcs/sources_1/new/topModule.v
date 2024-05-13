`timescale 1ns / 1ps


module topModule (
    input clk,
    input reset,
    input mode_sel,

    output [3:0] fndCom,
    output [7:0] fndFont

);

    wire [3:0] fndCom_Upcounter, fndCom_Clock;
    wire [7:0] fndFont_Upcounter, fndFont_Clock;

    UpCounter_10k #(
        .MAX_COUNT(9999)
    ) U_UpCounter10k (
        .clk  (clk),
        .reset(reset),

        .fndCom (fndCom_Upcounter),
        .fndFont(fndFont_Upcounter)
    );

    clock U_Clock (
        .clk  (clk),
        .reset(reset),

        .fndFont(fndFont_Clock),
        .fndCom (fndCom)
    );

    mux21 MUX_2x1 (
        .sel(mode_sel),
        .x0 (fndFont_Clock),
        .x1 (fndFont_Upcounter),

        .y(fndFont)
    );



endmodule
