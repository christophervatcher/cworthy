###############################################################################
## RISC-V rv32 architecture configuration
###############################################################################

include $(CWORTHYDIR)/targets/riscv.mk

TARGET_ARCH += -march=rv32imac -mabi=ilp32
TARGET_MACH += -march=rv32imac -mabi=ilp32

