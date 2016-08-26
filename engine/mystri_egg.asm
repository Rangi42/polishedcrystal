GiveMystriEgg:
	ld hl, MystriEgg
	ld de, OddEggSpecies
	ld bc, PARTYMON_STRUCT_LENGTH + 2 * PKMN_NAME_LENGTH
	call CopyBytes

	; load species in wcd2a
	ld a, EGG
	ld [wMobileMonSpeciesBuffer], a

	; load pointer to (wMobileMonSpeciesBuffer - 1) in wMobileMonSpeciesPointerBuffer
	ld a, (wMobileMonSpeciesBuffer - 1) % $100
	ld [wMobileMonSpeciesPointerBuffer], a
	ld a, (wMobileMonSpeciesBuffer - 1) / $100
	ld [wMobileMonSpeciesPointerBuffer + 1], a
	; load pointer to OddEggSpecies in wMobileMonStructurePointerBuffer
	ld a, OddEggSpecies % $100
	ld [wMobileMonStructurePointerBuffer], a
	ld a, OddEggSpecies / $100
	ld [wMobileMonStructurePointerBuffer + 1], a

	; load Egg name in wTempOddEggNickname
	ld hl, .MystriEggName
	ld de, wTempOddEggNickname
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes

	; load pointer to wTempOddEggNickname in wMobileMonOTNamePointerBuffer
	ld a, wTempOddEggNickname % $100
	ld [wMobileMonOTNamePointerBuffer], a
	ld a, wTempOddEggNickname / $100
	ld [wMobileMonOTNamePointerBuffer + 1], a
	; load pointer to wOddEggName in wMobileMonNicknamePointerBuffer
	ld a, wOddEggName % $100
	ld [wMobileMonNicknamePointerBuffer], a
	ld a, wOddEggName / $100
	ld [wMobileMonNicknamePointerBuffer + 1], a
	callba AddMobileMonToParty
	ret

.MystriEggName:
	db "Egg@@@@@@@@@"

MystriEgg:
	db TOGEPI
	db NO_ITEM
	db GROWL, CHARM, MOONBLAST, AEROBLAST
	dw 08192 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 40, 20, 15, 5 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"
