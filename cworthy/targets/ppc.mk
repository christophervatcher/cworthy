###############################################################################
## Motorola PowerPC architecture configuration
###############################################################################
TARGET = powerpc-linux-gnu

CXX = $(TARGET)-g++
CC = $(TARGET)-gcc
AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_ARCH += -mcpu=powerpc -m32
TARGET_MACH += -many -a32

