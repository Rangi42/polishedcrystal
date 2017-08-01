; rst vectors

SECTION "rst0", ROM0
	di
	jp Start

SECTION "rst8", ROM0
	jp RstFarCall

SECTION "rst10", ROM0
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret

SECTION "rst18", ROM0
	rst $38

SECTION "rst20", ROM0
	rst $38

SECTION "rst28", ROM0
	jp _Jumptable

SECTION "rst30", ROM0
	jp _Predef

SECTION "rst38", ROM0
	rst $38
