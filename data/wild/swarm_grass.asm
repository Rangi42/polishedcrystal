; swarms in grass

; Dunsparce swarm
	def_grass_wildmons DARK_CAVE_VIOLET_ENTRANCE
	db 4 percent, 4 percent, 4 percent ; encounter rates: morn/day/nite
	; morn
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE
	wildmon 4, DUNSPARCE
	wildmon 4, DUNSPARCE
	; day
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE
	wildmon 4, DUNSPARCE
	wildmon 4, DUNSPARCE
	; nite
	wildmon 3, GEODUDE
	wildmon 3, DUNSPARCE
	wildmon 2, ZUBAT
	wildmon 2, GEODUDE
	wildmon 2, DUNSPARCE
	wildmon 4, DUNSPARCE
	wildmon 4, DUNSPARCE
	end_grass_wildmons

; Yanma swarm
	def_grass_wildmons ROUTE_35
	db 10 percent, 10 percent, 10 percent ; encounter rates: morn/day/nite
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
