###############################################################################
## RISC-V rv64 architecture configuration
###############################################################################

include $(CWORTHYDIR)/targets/riscv.mk

TARGET_ARCH += -march=rv64imacfd -mabi=lp64d
TARGET_MACH += -march=rv64imacfd -mabi=lp64d

