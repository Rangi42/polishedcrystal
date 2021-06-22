MapGroupRoofs:
; entries correspond to map groups
; values are indexes for LoadMapGroupRoof.Roofs
	table_width 1, MapGroupRoofs
	db -1 ; group 0
	db  3 ; group 1 (Olivine City)
	db  2 ; group 2 (Mahogany Town)
	db -1 ; group 3
	db  1 ; group 4 (Ecruteak City)
	db  2 ; group 5 (Blackthorn City)
	db -1 ; group 6
	db -1 ; group 7
	db  2 ; group 8 (Azalea Town)
	db  2 ; group 9 (Lake of Rage)
	db  1 ; group 10 (Violet City)
	db -1 ; group 11 (Goldenrod City)
	db -1 ; group 12
	db -1 ; group 13
	db -1 ; group 14
	db -1 ; group 15
	db -1 ; group 16
	db -1 ; group 17
	db -1 ; group 18
	db  0 ; group 19 (Route 28)
	db -1 ; group 20 (Ecruteak Shrine)
	db -1 ; group 21
	db  3 ; group 22 (Cianwood City)
	db -1 ; group 23
	db  0 ; group 24 (New Bark Town)
	db -1 ; group 25
	db  0 ; group 26 (Cherrygrove City)
	db -1 ; group 27
	db -1 ; group 28
	db  3 ; group 29 (Goldenrod Harbor)
	db  0 ; group 30 (Ruins of Alph)
	db -1 ; group 31
	db -1 ; group 32
	db -1 ; group 33
	db  2 ; group 34 (Sinjoh Ruins)
	db -1 ; group 35
	assert_table_length NUM_MAP_GROUPS + 1
