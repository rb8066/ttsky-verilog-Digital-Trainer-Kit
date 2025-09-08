# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    if hasattr(dut, "clk"):
        clock = Clock(dut.clk, 10, units="us")
        cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    if hasattr(dut, "ena"):
        dut.ena.value = 1  # only if ena exists
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    if hasattr(dut, "rst_n"):
        dut.rst_n.value = 0
        await ClockCycles(dut.clk, 10)
        dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Example test values
    dut.ui_in.value = 20
    dut.uio_in.value = 30

    await ClockCycles(dut.clk, 1)

    # Example assertion (adjust for your logic!)
    # assert dut.uo_out.value == expected_value
