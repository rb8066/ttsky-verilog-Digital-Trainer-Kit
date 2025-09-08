/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_remya_digital_trainer (
    input  wire [7:0] ui_in,    // inputs
    output wire [7:0] uo_out,   // outputs
    input  wire [7:0] uio_in,   // bidirectional (unused here)
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       clk,      // unused
    input  wire       rst_n     // unused
);

    // Map TinyTapeout IOs to your signals
    wire a     = ui_in[0];
    wire b     = ui_in[1];
    wire [2:0] sel = ui_in[4:2];
    reg  y;

    assign uo_out[0] = y;   // only use uo_out[0]
    assign uo_out[7:1] = 7'b0; // unused outputs must be tied low

    // Unused bidirectional pins must be disabled
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(*) begin
        case (sel)
            3'b000: y = a & b;        // AND
            3'b001: y = a | b;        // OR
            3'b010: y = ~a;           // NOT
            3'b011: y = ~(a & b);     // NAND
            3'b100: y = ~(a | b);     // NOR
            3'b101: y = a ^ b;        // XOR
            3'b110: y = ~(a ^ b);     // XNOR
            default: y = 1'b0;
        endcase
    end
endmodule
