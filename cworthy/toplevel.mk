###############################################################################
## Top-level Makefile
##
## The Top-level Makefile must be copied as Makefile in the project root.
## The Top-level Makefile should define COMPONENTS as the list of component
## directories relative to the source root. After COMPONENTS is defined, it
## should include cworthy.mk. Ideally, the Top-level Makefile should define
## the target all.
###############################################################################

# Components may have arbitrary nesting. Intermediate directories used for
# grouping do not need a build.mk file.
COMPONENTS := \
    driver \
    component1 \
    component2 \
    subsystem1/subcomponent1 \
    subsystem2/subcomponent1

include cworthy/cworthy.mk

all: $(BINDIR)/driver

