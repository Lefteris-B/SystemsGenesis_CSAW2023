import random
import cocotb
from cocotb.triggers import FallingEdge,RisingEdge,ClockCycles
import cocotb.log
from interfaces.cpu import RiskV
from interfaces.defsParser import Regs
from cocotb.result import TestSuccess
from tests.common_functions.test_functions import *
from tests.bitbang.bitbang_functions import *
from interfaces.caravel import GPIO_MODE
from cocotb.binary import BinaryValue

reg = Regs()

@cocotb.test()
@repot_test
async def la(dut):
    caravelEnv,clock = await test_configure(dut,timeout_cycles=67415)
    cpu = RiskV(dut)
    cpu.cpu_force_reset()
    cpu.cpu_release_reset()
    pass_list = (0x1B,0x2B,0x3B,0x4B,0x5B,0x6B,0x7B,0x8B,0x9B,0xaB)
    fail_list = (0x1E,0x2E,0x3E,0x4E,0x5E,0x6E,0x7E,0x8E,0x9E,0xaE)
    phases_fails = 10
    phases_passes = 0
    reg1 =0 # buffer
    while True: 
        if cpu.read_debug_reg2() == 0xFF:  # test finish 
            break
        if reg1 != cpu.read_debug_reg1():
            reg1 = cpu.read_debug_reg1()                
            if reg1 in pass_list:  # pass phase
                phases_passes +=1
                phases_fails  -=1
                cocotb.log.info(f"[TEST] test passes phase {hex(reg1)[2]}")   
            elif reg1 in fail_list:  # fail phase
                cocotb.log.error(f"[TEST] test fails phase {hex(reg1)[2]} incorrect value recieved {hex(cpu.read_debug_reg2())}")   
           
        await ClockCycles(caravelEnv.clk,1) 

    if phases_fails != 0:
        cocotb.log.error(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails") 
    else:
        cocotb.log.info(f"[TEST] finish with {phases_passes} phases passes and {phases_fails} phases fails")    

    await ClockCycles(caravelEnv.clk, 10000)

   