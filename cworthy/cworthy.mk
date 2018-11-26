###############################################################################
## C-worthy: If it compiles, ship it.
##
## C-worthy is a build system just worthy enough to build software in C.
###############################################################################

# Ensure the Make target all the first target.
all:

# C-worthy includes directory.
CWORTHYDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

PROJECT_ROOT = $(abspath $(dir $(CWORTHYDIR)))
BUILD_ROOT = $(PROJECT_ROOT)/build
BTARGET_ROOT = $(BUILD_ROOT)/$(arch)
BINDIR = $(BTARGET_ROOT)/bin
LIBDIR = $(BTARGET_ROOT)/lib
INCDIR = $(BTARGET_ROOT)/include
OBJDIR = $(BTARGET_ROOT)/obj
DATADIR = $(BTARGET_ROOT)/share
DOCDIR = $(DATADIR)/doc
MANDIR = $(DATADIR)/man
SRCDIR = $(PROJECT_ROOT)/src

# Assert that the project root is a good directory.
PROJECT_ROOT_RESOLVED := $(realpath $(realpath $(CWORTHYDIR))/..)
ifneq ($(PROJECT_ROOT_RESOLVED),$(realpath $(PROJECT_ROOT)))
    $(error C-worthy is not seaworthy. PROJECT_ROOT resolves to empty string.)
endif


###############################################################################
## Architecture configuration
###############################################################################

# Undefine all default programs.
CXX =
CC =
AS =
LD =
AR =

# Configure C-worthy for the target architecture.
arch ?= $(shell arch)
ifneq (,$(wildcard $(CWORTHYDIR)/targets/$(arch).mk))
    include $(CWORTHYDIR)/targets/$(arch).mk
else
    $(error arch is invalid.)
endif


###############################################################################
## Recipes
###############################################################################
$(BTARGET_ROOT):
	mkdir -p $(BTARGET_ROOT)

$(BINDIR): $(BTARGET_ROOT)
	mkdir -p $(BINDIR)

$(LIBDIR): $(BTARGET_ROOT)
	mkdir -p $(LIBDIR)

$(INCDIR): $(BTARGET_ROOT)
	mkdir -p $(INCDIR)

$(OBJDIR): $(BTARGET_ROOT)
	mkdir -p $(OBJDIR)

$(DATADIR): $(BTARGET_ROOT)
	mkdir -p $(DATADIR)

$(DOCDIR): $(BTARGET_ROOT)
	mkdir -p $(DOCDIR)

$(MANDIR): $(BTARGET_ROOT)
	mkdir -p $(MANDIR)

.PHONY: clean
clean:
	rm -rf $(BTARGET_ROOT)

.PHONY: cleanall
cleanall:
	rm -rf $(BUILD_ROOT)

CPPFLAGS += -I$(INCDIR)
LDFLAGS += -L$(LIBDIR)
ARFLAGS = rU


###############################################################################
## build-components: Iterates over all components and includes their build.mk.
## build-component: Invoked by build.mk to process all the variables.
## ???
## component makefile: Linked to TLD makefile.
###############################################################################

define build-component =
    include $(SRCDIR)/$(1)/build.mk
    include $(CWORTHYDIR)/rules.mk
endef

define build-components =
    $$(foreach component,$(COMPONENTS),$$(eval $$(call build-component,$$(component))))
endef

$(eval $(build-components))

