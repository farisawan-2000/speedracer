ifeq ($(WINDOWS),1)
  WINE :=
else
  WINE := wine
endif

AS = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/as
# AS      := $(WINE) tools/GC_WII_COMPILERS/Wii/1.0/mwasmeppc.exe
# LD = powerpc-linux-gnu-ld
LD = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/ld
# LD      := $(WINE) tools/GC_WII_COMPILERS/Wii/1.0/mwldeppc.exe
ELF2DOL = /opt/devkitpro/tools/bin/elf2dol
OBJCOPY = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/objcopy
MD5SUM = md5sum
CPP     := cpp -P -Wno-trigraphs

LD_SCRIPT = ldscript.ld
# LD_SCRIPT = ldscript.lcf
MD5_FILE = speedracer.md5

BUILD_DIR = build

ASM_DIRS := .
S_FILES := $(foreach dir,$(ASM_DIRS),$(wildcard $(dir)/*.s))
O_FILES := $(foreach file,$(S_FILES),$(BUILD_DIR)/$(file:.s=.o))


# elf2dol needs to know these in order to calculate sbss correctly.
SDATA_PDHR := 9
SBSS_PDHR := 10
# Used for elf2dol
USES_SBSS2 := yes

ASFLAGS := -mbroadway
# LDFLAGS := -fp hard -nodefaults -msgstyle gcc
LDFLAGS := --no-check-sections --accept-unknown-input-arch

default: all

all: $(BUILD_DIR)/speedracer.dol

clean:
	rm -f -r $(BUILD_DIR)/*

DUMMY = mkdir -p build

main.s: baserom.dol
	mkdir -p build

$(BUILD_DIR)/%.o: %.s
	mkdir -p build
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD_DIR)/$(LD_SCRIPT): $(LD_SCRIPT)
	$(CPP) -MMD -MP -MT $@ -MF $@.d -o $@ $< \
	-DBUILD_DIR=$(BUILD_DIR)

$(BUILD_DIR)/speedracer.elf: $(O_FILES) $(BUILD_DIR)/$(LD_SCRIPT)
	$(LD) $(LDFLAGS) -Map build/speedracer.map  -T $(BUILD_DIR)/$(LD_SCRIPT) -o $@ $(BUILD_DIR)/main.o
	$(OBJCOPY) $@ $@

# $(BUILD_DIR)/speedracer.elf: $(O_FILES) $(LDSCRIPT)
# 	$(LD) $(LDFLAGS) -o $@ -lcf $(LD_SCRIPT) $(O_FILES)
# # The Metrowerks linker doesn't generate physical addresses in the ELF program headers. This fixes it somehow.
# 	$(OBJCOPY) $@ $@

# $(BUILD_DIR)/speedracer.dol: $(BUILD_DIR)/speedracer.elf
# 	$(ELF2DOL) $< $@
# 	$(MD5SUM) -c $(MD5_FILE)


$(BUILD_DIR)/speedracer.dol: $(BUILD_DIR)/speedracer.elf
	$(ELF2DOL) $< $@ $(SDATA_PDHR) $(SBSS_PDHR) $(USES_SBSS2)
	$(MD5SUM) -c $(MD5_FILE)