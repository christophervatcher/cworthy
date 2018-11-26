###############################################################################
## C-worthy Build Template
##
## Each component directory should include a build.mk file that defines either
## a program or library, the objects required to build, and any dependencies.
###############################################################################

# Programs get placed in <root>/build/<arch>/bin
PROGRAM := progname

# Libraries are compiled as both static and dynamic.
# Libraries are placed in <root>/build/<arch>/lib
LIBRARY := libname

# Objects are compiled into both the program target and library target.
OBJECTS := \
    list.o \
    of.o \
    common.o \
    objects.o

# Program objects are compiled only into the program target.
PROGRAM_OBJECTS := \
    driver.o

# Library objects are compiled only into the library target.
LIBRARY_OBJECTS := \
    library.o \
    only.o \
    objects.o

# Component dependency libraries are user-defined and may be linked statically.
# -l:libname.ext is the preferred form. -lname is also acceptable.
COMPDEPLIBS := \
    -l:libstatic.a \
    -l:libdynamic.so \
    -ldonotcare

# System dependency libraries are included by the toolchain and generally
# linked dynamically.
SYSDEPLIBS := \
    -lpthread

