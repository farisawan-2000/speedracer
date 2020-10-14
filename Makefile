AS = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/as
LD = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/ld
ELF2DOL = /opt/devkitpro/tools/bin/elf2dol

BUILD_DIR = build

default: all

all: $(BUILD_DIR)/speedracer.dol

main.s: baserom.dol
	mkdir build

$(BUILD_DIR)/speedracer.o: main.s
	$(AS) -mbroadway -o $@ $<

$(BUILD_DIR)/speedracer.elf: $(BUILD_DIR)/speedracer.o
	$(LD) --no-check-sections -T undefined_syms.txt -T ldscript.ld -o $@ $<

$(BUILD_DIR)/speedracer.dol: $(BUILD_DIR)/speedracer.elf
	$(ELF2DOL) $< $@