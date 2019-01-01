MapGroupRoofs:
; entries correspond to map groups
; values are indexes for Roofs (see below)
	db -1 ; group 0
	db  3 ; group 1 (Olivine City)
	db  2 ; group 2 (Mahogany Town)
	db -1 ; group 3
	db  4 ; group 4 (Ecruteak City)
	db -1 ; group 5 (Blackthorn City)
	db -1 ; group 6
	db -1 ; group 7
	db -1 ; group 8 (Azalea Town)
	db -1 ; group 9 (Lake of Rage)
	db  1 ; group 10 (Violet City)
	db  5 ; group 11 (Goldenrod City)
	db -1 ; group 12
	db -1 ; group 13
	db -1 ; group 14
	db -1 ; group 15
	db -1 ; group 16
	db -1 ; group 17
	db -1 ; group 18
	db  4 ; group 19 (Route 28)
	db  6 ; group 20 (Ecruteak Shrine)
	db -1 ; group 21
	db  3 ; group 22 (Cianwood City)
	db -1 ; group 23
	db  0 ; group 24 (New Bark Town)
	db -1 ; group 25
	db  0 ; group 26 (Cherrygrove City)
	db -1 ; group 27
	db -1 ; group 28
	db  3 ; group 29 (Goldenrod Harbor)
	db -1 ; group 30 (Ruins of Alph)
	db -1 ; group 31
	db -1 ; group 32
	db -1 ; group 33
	db -1 ; group 34
	db -1 ; group 35
	db  4 ; group 36 (Route 35+36)

Roofs:
INCBIN "gfx/tilesets/roofs/0.2bpp"
INCBIN "gfx/tilesets/roofs/1.2bpp"
INCBIN "gfx/tilesets/roofs/2.2bpp"
INCBIN "gfx/tilesets/roofs/3.2bpp"
INCBIN "gfx/tilesets/roofs/4.2bpp"
INCBIN "gfx/tilesets/roofs/5.2bpp"
INCBIN "gfx/tilesets/roofs/6.2bpp"
