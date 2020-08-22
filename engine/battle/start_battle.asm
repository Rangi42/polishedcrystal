ShowLinkBattleParticipants:
; If we're not in a communications room,
; we don't need to be here.
	ld a, [wLinkMode]
	and a
	ret z

	farcall _ShowLinkBattleParticipants
	ld c, 150
	call DelayFrames
	call ClearTileMap
	jp ClearSprites

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
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	call MaxVolume

	; Are we fighting a trainer?
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .trainermusic

	ld a, [wTempEnemyMonSpecies]
	ld hl, BattleMusic_Legendaries
	call .loadfromarray
	jr c, .done

	; Are we in the Safari Game?
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	ld de, MUSIC_WILD_BATTLE_GO
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
	ld de, MUSIC_CHAMPION_BATTLE
	jr .done

.not_rival2_4
	ld a, [wOtherTrainerClass]
	cp GIOVANNI
	jr nz, .othertrainer
	ld a, [wOtherTrainerID]
	cp 1 ; Armored Mewtwo
	jr nz, .othertrainer
	ld de, MUSIC_MOTHER_BEAST_BATTLE_SM
	jr .done

.othertrainer
	ld a, [wOtherTrainerClass]
	ld hl, BattleMusic_Trainers
	call .loadfromarray
	jr c, .done

	ld de, MUSIC_TRAINER_BATTLE_BW
	ld a, [wInBattleTowerBattle]
	bit 0, a
	jr nz, .done

	ld de, MUSIC_KANTO_GYM_LEADER_BATTLE
	farcall IsKantoGymLeader
	jr c, .done

	ld de, MUSIC_JOHTO_GYM_LEADER_BATTLE
	farcall IsJohtoGymLeader
	jr c, .done

	ld a, [wLinkMode]
	and a
	ld de, MUSIC_JOHTO_TRAINER_BATTLE
	jr nz, .done

	ld hl, BattleMusic_RegionalTrainers
	call .getregionmusicfromarray

.done
	call PlayMusic

	jp PopBCDEHL

.loadfromarray
	ld e, 3
	call IsInArray
	ret nc
	inc hl
	jr .found

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
	ld [wCriticalHit], a
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
