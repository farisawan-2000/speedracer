CC := gcc
CFLAGS := -I . -Wall -Wextra -Wno-unused-parameter -pedantic -O3 -s
PROGRAMS := elf2dol

elf2dol_SOURCES := elf2dol.c
elf2dol_CFLAGS := -O2 # faster compile time

default: all

all: $(PROGRAMS) $(CXX_PROGRAMS)

clean:
	$(RM) $(PROGRAMS) $(CXXPROGRAMS)

define COMPILE
$(1): $($1_SOURCES)
	$(CC) $(CFLAGS) $$^ -lm -o $$@ $($1_CFLAGS)
endef

$(foreach p,$(PROGRAMS),$(eval $(call COMPILE,$(p))))

# n64crc: n64crc.c
# 	$(CC) -o $< $@
