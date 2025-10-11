ShowLinkBattleParticipants:
; If we're not in a communications room,
; we don't need to be here.
	ld a, [wLinkMode]
	and a
	ret z

	call _ShowLinkBattleParticipants
	ld c, 150
	call DelayFrames
	call ClearTileMap
	jmp ClearSprites

FindFirstAliveMonAndStartBattle:
	xor a
	ldh [hMapAnims], a
	call DelayFrame
	ld b, 6
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH - 1

.loop
	ld a, [hli]
	or [hl]
	jr nz, .okay
	add hl, de
	dec b
	jr nz, .loop

.okay
	ld de, MON_LEVEL - MON_HP
	add hl, de
	ld a, [hl]
	ld [wBattleMonLevel], a
	farcall DoBattleTransition
	farcall _LoadBattleFontsHPBar
	ld a, 1
	ldh [hBGMapMode], a
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	ldh [rWY], a
	ldh [hMapAnims], a
	ret

PlayBattleMusic:
	push hl
	push de
	push bc

	call SaveMusic
	xor a
	ld [wMusicFade], a
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	call MaxVolume

	; Are we fighting a trainer?
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .trainermusic

	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld a, [wTempEnemyMonForm]
	and SPECIESFORM_MASK
	ld b, a
	ld hl, BattleMusic_Legendaries
	call .loadfromwordarray
	jr c, .done

	; Are we in the Safari Game?
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	ld e, MUSIC_WILD_BATTLE_GO
	jr z, .done

	ld hl, BattleMusic_RegionalWilds
	call .getregionmusicfromarray
	jr .done

.trainermusic
	ld a, [wOtherTrainerClass]
	cp RIVAL2
	jr nz, .not_rival2_4
	ld a, [wOtherTrainerID]
	cp 4 ; Rival in Indigo Plateau
	jr c, .not_rival2_4
	ld e, MUSIC_CHAMPION_BATTLE
	jr .done

.not_rival2_4
	ld a, [wOtherTrainerClass]
	cp GIOVANNI
	jr nz, .othertrainer
	ld a, [wOtherTrainerID]
	dec a ; Armored Mewtwo = GIOVANNI 1
	ld e, MUSIC_MOTHER_BEAST_BATTLE_SM
	jr z, .done

.othertrainer
	ld a, [wOtherTrainerClass]
	ld hl, BattleMusic_Trainers
	call .loadfromarray
	jr c, .done

	ld e, MUSIC_TRAINER_BATTLE_BW
	ld a, [wInBattleTowerBattle]
	and a
	jr nz, .done

	ld e, MUSIC_KANTO_GYM_LEADER_BATTLE
	farcall IsKantoGymLeader
	jr c, .done

	ld e, MUSIC_JOHTO_GYM_LEADER_BATTLE
	farcall IsJohtoGymLeader
	jr c, .done

	ld a, [wLinkMode]
	and a
	ld e, MUSIC_JOHTO_TRAINER_BATTLE
	jr nz, .done

	ld hl, BattleMusic_RegionalTrainers
	call .getregionmusicfromarray

.done
	ld a, e
	ld [wMapMusic], a
	call PlayMusic

	jmp PopBCDEHL

.loadfromarray
	ld de, 2
	call IsInArray
	ret nc
	jr .foundinarray

.loadfromwordarray
	ld de, 3
	call IsInWordArray
	ret nc
	inc hl
.foundinarray
	inc hl
	ld e, [hl]
	ld d, 0
	ret

.getregionmusicfromarray
	push hl
	call RegionCheck
	pop hl
	ld a, [wTimeOfDay]
	cp NITE
	; a = carry ? 0 : NUM_REGIONS
	ccf
	sbc a
	and NUM_REGIONS
	add e
	add a
	ld e, a
	ld d, 0
	add hl, de
.found
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

INCLUDE "data/battle/music.asm"

ClearBattleRAM:
	xor a
	ld [wBattlePlayerAction], a
	ld [wBattleResult], a

	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld [wMenuScrollPosition], a
	ld [wMoveHitState], a
	ld [wBattleMonSpecies], a
	ld [wCurBattleMon], a
	ld [wTimeOfDayPal], a
	ld [wPlayerTurnsTaken], a
	ld [wEnemyTurnsTaken], a
	ld [wEvolvableFlags], a

	ld hl, wPlayerHPPal
	ld [hli], a
	ld [hl], a

	ld hl, wBattleMonDVs
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wBattleMonPersonality
	ld [hli], a
	ld [hl], a

	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wEnemyMonPersonality
	ld [hli], a
	ld [hl], a

	; Clear the entire BattleMons area
	ld hl, wBattle
	ld bc, wBattleEnd - wBattle
	xor a
	rst ByteFill

	; Clear UsedItems
	ld hl, wPartyUsedItems
	ld bc, 6
	xor a
	rst ByteFill
	ld hl, wOTPartyUsedItems
	ld bc, 6
	xor a
	rst ByteFill

	call ClearWindowData

	ld hl, hBGMapAddress
	xor a ; LOW(vBGMap0)
	ld [hli], a
	ld [hl], HIGH(vBGMap0)
	ret
