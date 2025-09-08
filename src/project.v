/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Digital Logic Trainer Kit with Gate Selection
module tt_um_digital_logic_trainer (
    input  wire a, b,            // Two input switches
    input  wire [2:0] sel,       // 3-bit selection for gate choice
    output reg  y                // Selected gate output
);

    always @(*) begin
        case (sel)
            3'b000: y = a & b;        // AND
            3'b001: y = a | b;        // OR
            3'b010: y = ~a;           // NOT (unary, ignores b)
            3'b011: y = ~(a & b);     // NAND
            3'b100: y = ~(a | b);     // NOR
            3'b101: y = a ^ b;        // XOR
            3'b110: y = ~(a ^ b);     // XNOR
            default: y = 1'b0;        // Safe default
        endcase
    end

endmodule
