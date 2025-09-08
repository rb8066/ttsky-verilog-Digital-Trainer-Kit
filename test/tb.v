`default_nettype none
`timescale 1ns / 1ps



module tb ();

    // Testbench signals
    reg  [7:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg        clk;
    reg        rst_n;

    // DUT instance
    tt_um_remya_digital_trainer user_project (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock not used, but define it to avoid X states
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset not used, hold high
    initial rst_n = 1;

    // Drive inputs and monitor outputs
    initial begin
        $display("Starting testbench...");
        uio_in = 8'b0;
        ui_in  = 8'b0;

        // Iterate over all select values
        for (integer s = 0; s < 7; s = s + 1) begin
            for (integer aa = 0; aa < 2; aa = aa + 1) begin
                for (integer bb = 0; bb < 2; bb = bb + 1) begin
                    ui_in[0] = aa;        // a
                    ui_in[1] = bb;        // b
                    ui_in[4:2] = s[2:0];  // sel
                    #10;
                    $display("sel=%03b a=%b b=%b => y=%b", ui_in[4:2], ui_in[0], ui_in[1], uo_out[0]);
                end
            end
        end

        $display("Testbench finished.");
        $finish;
    end

endmodule
