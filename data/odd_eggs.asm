GiveOddEgg: ; 1fb4b6

	; Figure out which egg to give.

	; Compare a random word to
	; probabilities out of 0xffff.
	call Random
	ld hl, .Probabilities
	ld c, 0
	ld b, c
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; Break on $ffff.
	ld a, d
	cp $ffff / $100
	jr nz, .not_done
	ld a, e
	cp $ffff % $100
	jr z, .done
.not_done

	; Break when [hRandom] <= de.
	ld a, [hRandom + 1]
	cp d
	jr c, .done
	jr z, .ok
	jr .next
.ok
	ld a, [hRandom + 0]
	cp e
	jr c, .done
	jr z, .done
.next
	inc bc
	jr .loop
.done

	ld hl, OddEggs
	ld a, OddEgg2 - OddEgg1
	call AddNTimes

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

	; load Odd Egg Name in wTempOddEggNickname
	ld hl, .Odd
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
; 1fb546

.Odd:
	db "Odd@@@@@@@@@"

.Probabilities:

prob: MACRO
prob_total = prob_total + (\1)
	dw prob_total * $ffff / 100
ENDM

prob_total = 0
; Pichu
	prob 4
	prob 4
; Smoochum
	prob 12
	prob 12
; Magby
	prob 12
	prob 12
; Elekid
	prob 12
	prob 12
; Tyrogue
	prob 5
	prob 5
; Munchlax
	prob 5
	prob 5
; 1fb56e


OddEggs: ; 1fb56e

OddEgg1:
	db PICHU
	db NO_ITEM
	db THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0
	dw 02048 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 30, 20, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 11 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

OddEgg2:
	db PICHU
	db NO_ITEM
	db THUNDERSHOCK, CHARM, DIZZY_PUNCH, 0
	dw 00256 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $5b, SPDSPCDV_SHINY ; DVs
	db 30, 20, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 11 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db SMOOCHUM
	db NO_ITEM
	db POUND, LICK, DIZZY_PUNCH, 0
	dw 03584 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 35, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 7 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db SMOOCHUM
	db NO_ITEM
	db POUND, LICK, DIZZY_PUNCH, 0
	dw 00512 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $7b, SPDSPCDV_SHINY ; DVs
	db 35, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 7 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db MAGBY
	db NO_ITEM
	db LEER, DIZZY_PUNCH, 0, 0
	dw 02560 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 30, 10, 0, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db MAGBY
	db NO_ITEM
	db LEER, DIZZY_PUNCH, 0, 0
	dw 00512 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $3b, SPDSPCDV_SHINY ; DVs
	db 30, 10, 0, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 6 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db ELEKID
	db NO_ITEM
	db QUICK_ATTACK, LEER, DIZZY_PUNCH, 0
	dw 03072 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 7 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db ELEKID
	db NO_ITEM
	db QUICK_ATTACK, LEER, DIZZY_PUNCH, 0
	dw 00512 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $3b, SPDSPCDV_SHINY ; DVs
	db 30, 30, 10, 0 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 7 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db TYROGUE
	db NO_ITEM
	db TACKLE, RAGE, FORESIGHT, DIZZY_PUNCH
	dw 02560 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 35, 20, 40, 10 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 6 ; Atk
	bigdw 5 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db TYROGUE
	db NO_ITEM
	db TACKLE, RAGE, FORESIGHT, DIZZY_PUNCH
	dw 00256 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $7b, SPDSPCDV_SHINY ; DVs
	db 35, 20, 40, 10 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 12 ; Max HP
	bigdw 5 ; Atk
	bigdw 5 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 6 ; SDef
	db "Egg@@@@@@@@"

	db MUNCHLAX
	db NO_ITEM
	db SWEET_KISS, METRONOME, TACKLE, DIZZY_PUNCH
	dw 04096 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db ATKDEFDV_SHINY, SPDSPCDV_SHINY ; DVs
	db 10, 10, 35, 10 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 14 ; Max HP
	bigdw 7 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 7 ; SDef
	db "Egg@@@@@@@@"

	db MUNCHLAX
	db NO_ITEM
	db SWEET_KISS, METRONOME, TACKLE, DIZZY_PUNCH
	dw 00768 ; OT ID
	dt 0 ; Exp
	; Stat exp
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	bigdw 0
	db $1b, SPDSPCDV_SHINY ; DVs
	db 10, 10, 35, 10 ; PP
	db 20 ; Happiness
	db 0, 0, 0 ; Pokerus, Caught data
	db EGG_LEVEL ; Level
	db 0, 0 ; Status
	bigdw 0 ; HP
	bigdw 14 ; Max HP
	bigdw 6 ; Atk
	bigdw 6 ; Def
	bigdw 5 ; Spd
	bigdw 6 ; SAtk
	bigdw 7 ; SDef
	db "Egg@@@@@@@@"
