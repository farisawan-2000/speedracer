#define BEGIN_SEG(name, addr) \
    _##name##SegmentStart = ADDR(.name); \
    _##name##SegmentRomStart = __romPos; \
    .name addr : AT(__romPos)

#define END_SEG(name) \
    _##name##SegmentEnd = ADDR(.name) + SIZEOF(.name); \
    _##name##SegmentRomEnd = __romPos + SIZEOF(.name); \
    __romPos += SIZEOF(.name);

#define BEGIN_NOLOAD(name) \
    _##name##SegNoloadStart = ADDR(.name); \
    .name (NOLOAD) :

#define END_NOLOAD(name) \
    _##name##SegNoloadEnd = ADDR(.name) + SIZEOF(.name);

/*ENTRY(__start)*/

_SDA_BASE_ = 0x8055C2E0;
_SDA2_BASE_ = 0x8055F5A0;
PHDRS
{
    text0 PT_LOAD;
    text1 PT_LOAD;
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
    BEGIN_SEG(code, 0x80004000) SUBALIGN(16) {
        BUILD_DIR/main.o(.text0);
    } : text0
    END_SEG(code)

    /*BEGIN_SEG(code2, 0x80004000) SUBALIGN(16) {
        BUILD_DIR/main.o(.text1);
    } : text1
    END_SEG(code)*/
/*    .text0 0x80004000 : { *(.text0) } : text0 */
    .text1 0x80006DA0 : { *(.text1) } : text1
    .data0 0x800064E0 : { *(.data0) } : data0
    .data1 0x80006860 : { *(.data1) } : data1
    .data2 0x80466860 : { *(.data2) } : data2
    .data3 0x80466E60 : { *(.data3) } : data3
    .data4 0x80466E80 : { *(.data4) } : data4
    .data5 0x804922A0 : { *(.data5) } : data5
    .data6 0x805542E0 : { *(.data6) } : data6
    .data7 0x805575A0 : { *(.data7) } : data7
    .bss 0x804D2540 (NOLOAD) : { *(.bss) } : bss
}
