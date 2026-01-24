; swarms in grass

; Dunsparce swarm
	def_grass_wildmons DARK_CAVE_VIOLET_ENTRANCE
	db 4 percent ; encounter rate
	; morn
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	; day
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	; nite
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM
	wildmon 4, DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM
	end_grass_wildmons

; Yanma swarm
	def_grass_wildmons ROUTE_35
	db 10 percent ; encounter rate
	; morn
	wildmon 12, NIDORAN_M
	wildmon 12, NIDORAN_F
	wildmon 12, YANMA
	wildmon 14, YANMA
	wildmon 14, PIDGEY
	wildmon 10, DITTO
	wildmon 10, DITTO
	; day
	wildmon 12, NIDORAN_M
	wildmon 12, NIDORAN_F
	wildmon 12, YANMA
	wildmon 14, YANMA
	wildmon 14, PIDGEY
	wildmon 10, DITTO
	wildmon 10, DITTO
	; nite
	wildmon 12, NIDORAN_M
	wildmon 12, NIDORAN_F
	wildmon 12, YANMA
	wildmon 14, YANMA
	wildmon 14, HOOTHOOT
	wildmon 10, DITTO
	wildmon 10, DITTO
	end_grass_wildmons

	db -1 ; end
