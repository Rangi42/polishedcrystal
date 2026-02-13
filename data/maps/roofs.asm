MapGroupRoofs:
; entries correspond to map groups
; values are indexes for LoadMapGroupRoof.Roofs
	table_width 1
	db -1             ; 0
	db ROOF_OLIVINE   ; 1 (Olivine City)
	db ROOF_AZALEA    ; 2 (Mahogany Town)
	db -1             ; 3
	db ROOF_VIOLET    ; 4 (Ecruteak City)
	db ROOF_AZALEA    ; 5 (Blackthorn City)
	db -1             ; 6
	db -1             ; 7
	db ROOF_AZALEA    ; 8 (Azalea Town)
	db ROOF_OLIVINE   ; 9 (Battle Tower Outside)
	db ROOF_VIOLET    ; 10 (Violet City)
	db ROOF_GOLDENROD ; 11 (Goldenrod City)
	db -1             ; 12
	db -1             ; 13
	db -1             ; 14
	db -1             ; 15
	db -1             ; 16
	db -1             ; 17
	db -1             ; 18
	db ROOF_NEW_BARK  ; 19 (Route 28)
	db -1             ; 20
	db -1             ; 21
	db ROOF_OLIVINE   ; 22 (Cianwood City)
	db -1             ; 23
	db ROOF_NEW_BARK  ; 24 (New Bark Town)
	db -1             ; 25
	db ROOF_NEW_BARK  ; 26 (Cherrygrove City)
	db -1             ; 27
	db -1             ; 28
	db ROOF_OLIVINE   ; 29 (Goldenrod Harbor)
	db ROOF_NEW_BARK  ; 30 (Ruins of Alph)
	db -1             ; 31
	db -1             ; 32
	db -1             ; 33
	db ROOF_AZALEA    ; 34 (Sinjoh Ruins)
	db -1             ; 35
	db ROOF_VIOLET    ; 36 (Rugged Road)
	db -1             ; 37
	assert_table_length NUM_MAP_GROUPS + 1
