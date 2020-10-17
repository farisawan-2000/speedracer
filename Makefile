ifeq ($(WINDOWS),1)
  WINE :=
else
  WINE := wine
endif

AS = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/as
LD = powerpc-linux-gnu-ld
# AS      := $(WINE) tools/GC_WII_COMPILERS/Wii/1.0/mwasmeppc.exe
# LD      := $(WINE) tools/GC_WII_COMPILERS/Wii/1.0/mwldeppc.exe
ELF2DOL = /opt/devkitpro/tools/bin/elf2dol
OBJCOPY = /opt/devkitpro/devkitPPC/powerpc-eabi/bin/objcopy
MD5SUM = md5sum
CPP     := cpp -P -Wno-trigraphs

LD_SCRIPT = ldscript.ld
MD5_FILE = speedracer.md5

BUILD_DIR = build

ASM_DIRS := .
S_FILES := $(foreach dir,$(ASM_DIRS),$(wildcard $(dir)/*.s))
O_FILES := $(foreach file,$(S_FILES),$(BUILD_DIR)/$(file:.s=.o))

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
	$(AS) -mbroadway -o $@ $<

$(BUILD_DIR)/$(LD_SCRIPT): $(LD_SCRIPT)
	$(CPP) -MMD -MP -MT $@ -MF $@.d -o $@ $< \
	-DBUILD_DIR=$(BUILD_DIR)

$(BUILD_DIR)/speedracer.elf: $(O_FILES) $(BUILD_DIR)/$(LD_SCRIPT)
	$(LD) $(LDFLAGS) -Map build/speedracer.map  -T $(BUILD_DIR)/$(LD_SCRIPT) -o $@ $(BUILD_DIR)/main.o
	$(OBJCOPY) $@ $@

$(BUILD_DIR)/speedracer.dol: $(BUILD_DIR)/speedracer.elf
	$(ELF2DOL) $< $@
	$(MD5SUM) -c $(MD5_FILE)