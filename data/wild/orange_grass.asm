; Orange Pokémon in grass

	def_grass_wildmons ROUTE_49
	db 10 percent, 10 percent, 10 percent ; encounter rates: morn/day/nite
	; morn
	wildmon LEVEL_FROM_BADGES - 2, XATU
	wildmon LEVEL_FROM_BADGES - 2, SUNFLORA
	wildmon LEVEL_FROM_BADGES + 0, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 1, XATU
	wildmon LEVEL_FROM_BADGES + 2, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 3, JUMPLUFF
	wildmon LEVEL_FROM_BADGES + 1, JUMPLUFF
	; day
	wildmon LEVEL_FROM_BADGES - 2, XATU
	wildmon LEVEL_FROM_BADGES - 2, SUNFLORA
	wildmon LEVEL_FROM_BADGES + 0, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 1, XATU
	wildmon LEVEL_FROM_BADGES + 2, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 3, JUMPLUFF
	wildmon LEVEL_FROM_BADGES + 1, JUMPLUFF
	; nite
	wildmon LEVEL_FROM_BADGES - 2, NOCTOWL
	wildmon LEVEL_FROM_BADGES - 2, EXEGGCUTE
	wildmon LEVEL_FROM_BADGES + 0, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 1, NOCTOWL
	wildmon LEVEL_FROM_BADGES + 2, EXEGGUTOR, ALOLAN_FORM
	wildmon LEVEL_FROM_BADGES + 3, YANMEGA
	wildmon LEVEL_FROM_BADGES + 1, YANMEGA
	end_grass_wildmons

	def_grass_wildmons NAVEL_ROCK_INSIDE
	db 1 percent, 1 percent, 1 percent ; encounter rates: morn/day/nite
	; morn
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 80, DRAGONAIR
	wildmon 82, DRAGONITE
	wildmon 85, DRAGONITE
	; day
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 80, DRAGONAIR
	wildmon 82, DRAGONITE
	wildmon 85, DRAGONITE
	; nite
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 1, 0
	wildmon 80, DRAGONAIR
	wildmon 82, DRAGONITE
	wildmon 85, DRAGONITE
	end_grass_wildmons

	db -1 ; end
