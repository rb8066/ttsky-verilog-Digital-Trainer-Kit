`default_nettype none
`timescale 1ns / 1ps

module tb;

    reg a, b;
    reg [2:0] sel;
    wire y;

    // Instantiate design
    tt_um_remya_digital_trainer user_project (
        .a(a), .b(b), .sel(sel), .y(y)
    );

    initial begin
        $display("A B SEL | OUT (Selected Gate)");
        $display("--------------------------------");

        // Loop through inputs and gates
        for (integer i = 0; i < 4; i = i + 1) begin
            {a, b} = i;
            for (integer s = 0; s < 7; s = s + 1) begin
                sel = s;
                #5;
                $display("%b %b  %03b | %b", a, b, sel, y);
            end
        end

        $finish;
    end

endmodule
