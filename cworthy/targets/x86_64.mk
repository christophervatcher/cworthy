###############################################################################
## x86-64 Linux architecture configuration
###############################################################################

include $(CWORTHYDIR)/targets/x86.mk

TARGET_ARCH = -m64 -mabi=sysv
TARGET_MACH = --64

