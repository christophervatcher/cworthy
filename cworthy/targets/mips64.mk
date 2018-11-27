###############################################################################
## MIPS 64 architecture configuration
###############################################################################
TARGET = mips64-linux-gnu

CXX = $(TARGET)-g++
CC = $(TARGET)-gcc
AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_ARCH += -march=mips64r6 -mabi=64
TARGET_MACH += -march=mips64r6 -mabi=64

