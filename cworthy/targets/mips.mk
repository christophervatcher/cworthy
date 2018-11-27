###############################################################################
## MIPS architecture configuration
###############################################################################
TARGET = mips-linux-gnu

CXX = $(TARGET)-g++
CC = $(TARGET)-gcc
AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_ARCH += -march=mips32r6 -mabi=32
TARGET_MACH += -march=mips32r6 -mabi=32

