###############################################################################
## M68K architecture configuration
###############################################################################
TARGET = m68k-linux-gnu

CXX = $(TARGET)-g++
CC = $(TARGET)-gcc
AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_ARCH += -march=68020 -mcpu=68020
TARGET_MACH += -march=68020 -mcpu=68020

