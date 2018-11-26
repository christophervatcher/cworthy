###############################################################################
## RISC-V rv64 architecture configuration
###############################################################################

include $(CWORTHYDIR)/targets/riscv.mk

TARGET_ARCH += -march=rv64imafdc -mabi=lp64d
TARGET_MACH += -march=rv64imafdc -mabi=lp64d

