# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Create a clock on the DUT clock (inside user_project)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset sequence (through user_project.rst_n)
    dut._log.info("Reset")
    dut.user_project.ena.value = 1   # enable the DUT
    dut.user_project.ui_in.value = 0
    dut.user_project.uio_in.value = 0

    dut.user_project.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.user_project.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Try a few logic cases
    # Example: select = AND gate (000), a=1, b=1 → y=1
    dut.user_project.ui_in.value = 0b00000011  # a=1, b=1, sel=000
    await ClockCycles(dut.clk, 1)
    assert dut.user_project.uo_out.value.integer & 1 == 1, "AND gate failed"

    # Example: select = OR gate (001), a=1, b=0 → y=1
    dut.user_project.ui_in.value = 0b00000101  # a=1, b=0, sel=001
    await ClockCycles(dut.clk, 1)
    assert dut.user_project.uo_out.value.integer & 1 == 1, "OR gate failed"

    # Example: select = XOR gate (101), a=1, b=0 → y=1
    dut.user_project.ui_in.value = 0b00010101  # a=1, b=0, sel=101
    await ClockCycles(dut.clk, 1)
    assert dut.user_project.uo_out.value.integer & 1 == 1, "XOR gate failed"

    dut._log.info("All basic tests passed")
