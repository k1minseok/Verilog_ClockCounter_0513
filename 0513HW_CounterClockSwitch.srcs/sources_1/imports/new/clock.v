`timescale 1ns / 1ps

module clock (
    input clk,
    input reset,

    output [7:0] fndFont,
    output [3:0] fndCom

    // For simulation
    // output wire [3:0] w_digit_1,
    // output wire [3:0] w_digit_10,
    // output wire [3:0] w_digit_100,
    // output wire [3:0] w_digit_1000,

    // output wire [5:0] w_count_sec,
    // output wire [5:0] w_count_min,
    // output wire w_sec_tick,
    // output wire w_min_tick
);
    wire w_sec_tick, w_min_tick;
    wire [5:0] w_count_sec;
    wire [5:0] w_count_min;

    clkDiv #(
        .MAX_COUNT(100_000_000)
    ) U_ClkDiv_sec (
        .reset(reset),
        .clk  (clk),

        .o_clk(w_sec_tick)
    );

    clkDiv #(
        .MAX_COUNT(60)
    ) U_ClkDiv_min (
        .reset(reset),
        .clk  (w_sec_tick),

        .o_clk(w_min_tick)
    );

    counter #(
        .MAX_COUNT(60)
    ) U_Counter_sec (
        .clk  (w_sec_tick),
        .reset(reset),
        .count (w_count_sec)
    );

    counter #(
        .MAX_COUNT(60)
    ) U_Counter_min (
        .clk  (w_min_tick),
        .reset(reset),
        .count (w_count_min)
    );


    fndContorller_clock U_FNDController (
        .reset(reset),
        .clk(clk),
        .digit({1'b0, w_count_min, 1'b0, w_count_sec}),
        .fndFont(fndFont),
        .fndCom(fndCom)

        // For simulation
        // .w_digit_1(w_digit_1),
        // .w_digit_10(w_digit_10),
        // .w_digit_100(w_digit_100),
        // .w_digit_1000(w_digit_1000)
    );

endmodule
