; rst vectors

SECTION "rst0",ROM0[0]
	di
	jp Start

SECTION "rst8",ROM0[FarCall]
	jp RstFarCall

SECTION "rst10",ROM0[Bankswitch]
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret

SECTION "rst18",ROM0[$18]
	rst $38

SECTION "rst20",ROM0[$20]
	rst $38

SECTION "rst28",ROM0[JumpTable]
	jp _Jumptable

SECTION "rst30",ROM0[Predef]
	jp _Predef

SECTION "rst38",ROM0[$38]
	rst $38
