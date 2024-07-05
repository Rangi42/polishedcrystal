Script_BattleWhiteout::
	callasm BattleBGMap
	sjumpfwd Script_Whiteout

Script_OverworldWhiteout::
	reanchormap
	callasm OverworldWhiteoutFade

Script_Whiteout:
	callasm LoseMoney
	iffalsefwd .whiteout_text
	readmem wBattlePlayerAction
	ifequalfwd BATTLEACTION_FORFEIT, .forfeit_text
	callasm DetermineWildBattlePanic
	iffalsefwd .whiteout_wild_text
	farwritetext WhiteoutToTrainerText
	sjumpfwd .text_done
.forfeit_text
	farwritetext ForfeitToTrainerText
	sjumpfwd .text_done
.whiteout_wild_text
	farwritetext WhiteoutToWildText
	sjumpfwd .text_done
.whiteout_text
	farwritetext WhiteoutText
.text_done
	waitbutton
	special FadeOutPalettes
	pause 40
	special HealParty
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftruefwd .bug_contest
	callasm GetWhiteoutSpawn
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	newloadmap MAPSETUP_WARP
	endall

.bug_contest
	jumpstd bugcontestresultswarp

OverworldWhiteoutFade:
	farcall FadeOutPalettes
	call ClearTileMap
	call ClearSprites
	ld a, CGB_PLAIN
	call GetCGBLayout
	jmp SetDefaultBGPAndOBP

BattleBGMap:
	ld a, CGB_BATTLE_GRAYSCALE
	call GetCGBLayout
	jmp SetDefaultBGPAndOBP

; Gen VI money loss code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
LoseMoney:
	xor a
	ld [wSpinning], a
	ld hl, wMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ld a, FALSE ; no-optimize a = 0
	jr z, .load
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
	cp 9
	jr c, .okay
	ld c, 8
.okay
	ld b, 0
	ld hl, .BasePayouts
	add hl, bc
	ld a, [hl]
	ldh [hMultiplier], a
	ld a, [wPartyCount]
	ld c, a
	ld b, 0
	ld hl, wPartyMon1Level
	ld de, PARTYMON_STRUCT_LENGTH
.loop
	ld a, [hl]
	cp b
	jr c, .next
	ld b, a
.next
	add hl, de
	dec c
	jr nz, .loop
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, b
	ldh [hMultiplicand + 2], a
	farcall Multiply
	ld de, hMoneyTemp
	ld hl, hProduct + 1
	call .copy
	ld de, wMoney
	ld bc, hMoneyTemp
	push bc
	push de
	farcall CompareMoney
	jr nc, .nonzero
	ld hl, wMoney
	ld de, hMoneyTemp
	call .copy
.nonzero
	pop de
	pop bc
	farcall TakeMoney
	ld a, TRUE
.load
	ldh [hScriptVar], a
	ret

.copy
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

.BasePayouts
	db 8
	db 16
	db 24
	db 36
	db 48
	db 64
	db 80
	db 100
	db 120

DetermineWildBattlePanic:
	ld hl, wWildBattlePanic
	ld a, [hl]
	and $1
	ldh [hScriptVar], a
	xor a
	ld [hl], a
	ret

GetWhiteoutSpawn:
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	; a = carry ? c : SPAWN_HOME (0)
	sbc a
	and c
	ld [wDefaultSpawnpoint], a
	ret
