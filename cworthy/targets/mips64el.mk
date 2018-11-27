###############################################################################
## MIPS 64 Little Endian architecture configuration
###############################################################################
TARGET = mips64el-linux-gnu

CXX = $(TARGET)-g++
CC = $(TARGET)-gcc
AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_ARCH += -march=mips64r6 -mabi=64
TARGET_MACH += -march=mips64r6 -mabi=64

