###############################################################################
## C-worthy recipes.
###############################################################################
##
## Program Build Templates
##
## Default Macros
## LINT.c = $(LINT) $(LINTFLAGS) $(CPPFLAGS) $(TARGET_ARCH)
## COMPILE.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
## COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
## COMPILE.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(TARGET_MACH) -c
## COMPILE.s = $(AS) $(ASFLAGS) $(TARGET_MACH)
## LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
## LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
## LINK.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_MACH)
## LINK.s = $(CC) $(ASFLAGS) $(LDFLAGS) $(TARGET_MACH)
## LINK.o = $(CC) $(LDFLAGS) $(TARGET_ARCH)
## 
## CPP = $(CC) -E
## CXX = g++
## CC = cc
## AS = as
## LD = ld
## AR = ar
##
## LINTFLAGS =
## CPPFLAGS =
## CXXFLAGS =
## CFLAGS =
## ASFLAGS =
## LDFLAGS =
## ARFLAGS = rv
##
## TARGET_ARCH =
## TARGET_MACH =
## OUTPUT_OPTION = -o $@
##
## Implicit Rules
## %: %.ext
##	$(LINK.ext) $^ $(LOADLIBES) $(LDLIBS) -o $@
## %.o: %.ext
##	$(COMPILE.ext) $(OUTPUT_OPTION) $<
## %.o: %.[Ss]
##	$(COMPILE.[Ss]) -o $@ $<
##
###############################################################################


###############################################################################
## Define the COMPONENT variable.
###############################################################################
COMPONENT_MAKEFILE = $(abspath $(word $(words $(MAKEFILE_LIST)),dummy $(MAKEFILE_LIST)))

ifdef SRCDIR
COMPONENT = $(patsubst %/,%,$(dir $(subst $(SRCDIR)/,,$(COMPONENT_MAKEFILE))))
else
COMPONENT = $(patsubst %/,%,$(dir $(subst $(PROJECT_ROOT)/,,$(COMPONENT_MAKEFILE))))
endif


###############################################################################
## Redefine the implicit recipes using the desired directory structure.
###############################################################################

ifdef PROGRAM
PROGOBJS := $(OBJECTS) $(PROGRAM_OBJECTS)
PROGOBJS := $(foreach object,$(PROGOBJS),$(OBJDIR)/$(COMPONENT)/$(object))

PROGLIBS := $(foreach library,$(filter -l:%,$(COMPDEPLIBS)),$(LIBDIR)/$(patsubst -l:%,%,$(library)))
PROGLIBS += $(foreach library,$(filter -l%,$(filter-out -l:%,$(COMPDEPLIBS))),$(LIBDIR)/lib$(patsubst -l%,%.a,$(library)))
PROGLIBS += $(foreach library,$(filter -l%,$(filter-out -l:%,$(COMPDEPLIBS))),$(LIBDIR)/lib$(patsubst -l%,%.so,$(library)))

$(BINDIR)/$(PROGRAM): COMPDEPLIBS := $(COMPDEPLIBS)
$(BINDIR)/$(PROGRAM): SYSDEPLIBS := $(SYSDEPLIBS)

$(BINDIR)/$(PROGRAM): $(PROGOBJS) | $(BINDIR) $(PROGLIBS)
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(COMPDEPLIBS) $(SYSDEPLIBS) -o $@

undefine PROGLIBS
undefine PROGOBJS
endif

ifdef LIBRARY
LIBOBJS := $(OBJECTS) $(LIBRARY_OBJECTS)

$(foreach object,$(LIBOBJS),$(LIBDIR)/lib$(LIBRARY).a($(object)): $(OBJDIR)/$(COMPONENT)/$(object) | $(LIBDIR))

$(LIBDIR)/lib$(LIBRARY).a: $(foreach object,$(LIBOBJS),$(LIBDIR)/lib$(LIBRARY).a($(object))) | $(LIBDIR)
	$(RANLIB) $@

$(LIBDIR)/lib$(LIBRARY).so: $(foreach object,$(LIBOBJS),$(OBJDIR)/$(COMPONENT)/$(object)) | $(LIBDIR)
	$(LINK.o) -shared $< -o $@

$(LIBDIR)/lib$(LIBRARY).a(%.o): $(OBJDIR)/$(COMPONENT)/%.o | $(LIBDIR)
	$(AR) $(ARFLAGS) $@ $<

undefine LIBOBJS
endif


$(OBJDIR)/$(COMPONENT): $(OBJDIR)
	mkdir -p $@

$(OBJDIR)/$(COMPONENT)/%.o: $(SRCDIR)/$(COMPONENT)/%.cc | $(OBJDIR)/$(COMPONENT)
	$(COMPILE.cc) $(OUTPUT_OPTION) $<

$(OBJDIR)/$(COMPONENT)/%.o: $(SRCDIR)/$(COMPONENT)/%.c | $(OBJDIR)/$(COMPONENT)
	$(COMPILE.c) $(OUTPUT_OPTION) $<

$(OBJDIR)/$(COMPONENT)/%.o: $(SRCDIR)/$(COMPONENT)/%.S | $(OBJDIR)/$(COMPONENT)
	$(COMPILE.S) -o $@ $<

$(OBJDIR)/$(COMPONENT)/%.o: $(SRCDIR)/$(COMPONENT)/%.s | $(OBJDIR)/$(COMPONENT)
	$(COMPILE.s) -o $@ $<


###############################################################################
## Undefine all component-specific variables to not confuse laters ones.
###############################################################################
undefine COMPONENT_MAKEFILE
undefine COMPONENT
undefine PROGRAM
undefine LIBRARY
undefine OBJECTS
undefine PROGRAM_OBJECTS
undefine LIBRARY_OBJECTS
undefine COMPDEPLIBS
undefine SYSDEPLIBS
