.section .data0, "wa"  # 0x800064E0 - 0x80006860
	.incbin "baserom.dol", 0x4620A0, 0x380

.section .data1, "wa"  # 0x80006860 - 0x80006DA0
	.incbin "baserom.dol", 0x462420, 0x540

.section .data2, "wa"  # 0x80466860 - 0x80466E60
	.incbin "baserom.dol", 0x462960, 0x600

.section .data3, "wa"  # 0x80466E60 - 0x80466E80
	.incbin "baserom.dol", 0x462F60, 0x20

.section .data4, "wa"  # 0x80466E80 - 0x804922A0
	.incbin "baserom.dol", 0x462F80, 0x2B420

.section .data5, "wa"  # 0x804922A0 - 0x804D2540
	.incbin "baserom.dol", 0x48E3A0, 0x402A0

.section .data6, "wa"  # 0x805542E0 - 0x80555800
	.incbin "baserom.dol", 0x4CE640, 0x1520

.section .data7, "wa"  # 0x805575A0 - 0x8055B2C0
	.incbin "baserom.dol", 0x4CFB60, 0x3D20

.section .bss, "wa"  # 0x804D2540 - 0x8055B300
	.skip 0x88DC0
