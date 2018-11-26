###############################################################################
## Z-80 Linux architecture configuration
###############################################################################

TARGET := z80-unknown-coff

AS = $(TARGET)-as
LD = $(TARGET)-ld
AR = $(TARGET)-ar
RANLIB = $(TARGET)-ranlib

TARGET_MACH = -z80

