#define BEGIN_SEG(name, addr) \
    _##name##SegmentStart = ADDR(.name); \
    _##name##SegmentRomStart = __romPos; \
    .name addr : AT(__romPos)

#define END_SEG(name) \
    _##name##SegmentEnd = ADDR(.name) + SIZEOF(.name); \
    _##name##SegmentRomEnd = __romPos + SIZEOF(.name); \
    __romPos += SIZEOF(.name);

ENTRY(__start)
_SDA_BASE_ = 0x8055C2E0;
_SDA2_BASE_ = 0x8055F5A0;
PHDRS
{
    init PT_LOAD;
    text PT_LOAD;
    data0 PT_LOAD;
    data1 PT_LOAD;
    data2 PT_LOAD;
    data3 PT_LOAD;
    data4 PT_LOAD;
    data5 PT_LOAD;
    data6 PT_LOAD;
    data7 PT_LOAD;
    bss PT_LOAD;
}
SECTIONS
{
    __romPos = 0x100;
    BEGIN_SEG(init, 0x80004000) {
        *(.init);
    } : init
    END_SEG(init)
    BEGIN_SEG(code, 0x80006DA0) SUBALIGN(0x8) {
        build/./main.o(.text);
        build/src/func_804667C8.o(.text);
    } : text
    END_SEG(code)
    .data0 0x800064E0 : SUBALIGN(0x20) { build/data.o(.data0) } : data0
    .data1 0x80006860 : SUBALIGN(0x20) { build/data.o(.data1) } : data1
    .data2 0x80466860 : SUBALIGN(0x20) { build/data.o(.data2) } : data2
    .data3 0x80466E60 : SUBALIGN(0x20) { build/data.o(.data3) } : data3
    .data4 0x80466E80 : SUBALIGN(0x20) { build/data.o(.data4) } : data4
    .data5 0x804922A0 : SUBALIGN(0x20) { build/data.o(.data5) } : data5
    .data6 0x805542E0 : SUBALIGN(0x20) { build/data.o(.data6) } : data6
    .data7 0x805575A0 : SUBALIGN(0x20) { build/data.o(.data7) } : data7
    .bss 0x804D2540 (NOLOAD) : SUBALIGN(0x20) { build/data.o(.bss) } : bss
    /DISCARD/ :
    {
       *(*);
    }
}


