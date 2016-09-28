Script_BattleWhiteout:: ; 0x124c1
	callasm BattleBGMap
	jump Script_Whiteout
; 0x124c8

Script_OverworldWhiteout:: ; 0x124c8
	refreshscreen $0
	callasm OverworldBGMap

Script_Whiteout: ; 0x124ce
	callasm LoseMoney
	iffalse .whiteout_text
	callasm DetermineWildBattlePanic
	iffalse .whiteout_wild_text
	writetext .WhitedOutToTrainerText
	jump .text_done
.whiteout_wild_text
	writetext .WhitedOutToWildText
	jump .text_done
.whiteout_text
	writetext .WhitedOutText
.text_done
	waitbutton
	special FadeOutPalettes
	pause 40
	check_nuzlocke
	iftrue Script_NuzlockeWhiteout
	special HealParty
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .bug_contest
	callasm GetWhiteoutSpawn
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	newloadmap MAPSETUP_WARP
	end_all

.bug_contest
	jumpstd bugcontestresultswarp
; 0x124f5

.WhitedOutText: ; 0x124f5
	; is out of useable #MON!  whited out!
	text_jump WhiteoutText
	db "@"
; 0x124fa

.WhitedOutToWildText:
	text_jump WhiteoutToWildText
	db "@"

.WhitedOutToTrainerText:
	text_jump WhiteoutToTrainerText
	db "@"

Script_NuzlockeWhiteout:
	special HealPartyEvenForNuzlocke
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .bug_contest
	callasm GetWhiteoutSpawn
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	newloadmap MAPSETUP_WARP
	end_all

.bug_contest:
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalse .no_return
	special ContestReturnMons
.no_return:
	domaptrigger ROUTE_35_NATIONAL_PARK_GATE, $0
	domaptrigger ROUTE_36_NATIONAL_PARK_GATE, $0
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	callasm GetWhiteoutSpawn
	farscall Script_AbortBugContest
	special WarpToSpawnPoint
	newloadmap MAPSETUP_WARP
	end_all

OverworldBGMap: ; 124fa
	call ClearPalettes
	call ClearScreen
	call WaitBGMap2
	call HideSprites
	call RotateThreePalettesLeft
	ret
; 1250a

BattleBGMap: ; 1250a
	ld b, SCGB_BATTLE_GRAYSCALE
	call GetSGBLayout
	call SetPalettes
	ret
; 12513

; Gen VI money loss code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/main.asm
LoseMoney: ; 12513
	xor a
	ld [wSpinning], a
	ld hl, Money
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ld a, 0
	jr z, .load
	; 806e1
	ld hl, Badges
	ld b, 2
	call CountSetBits
	cp 9
	jr c, .okay
	ld c, 8
.okay
	ld b, 0
	ld hl, .BasePayouts
	add hl, bc
	ld a, [hl]
	ld [hMultiplier], a
	ld a, [PartyCount]
	ld c, a
	ld b, 0
	ld hl, PartyMon1Level
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
	ld [hMultiplicand], a
	ld [hMultiplicand + 1], a
	ld a, b
	ld [hMultiplicand + 2], a
	call Multiply
	ld de, hMoneyTemp
	ld hl, hProduct + 1
	call .copy
	ld de, Money
	ld bc, hMoneyTemp
	push bc
	push de
	farcall CompareMoney
	jr nc, .nonzero
	ld hl, Money
	ld de, hMoneyTemp
	call .copy
.nonzero
	pop de
	pop bc
	farcall TakeMoney
	ld a, 1
.load
	ld [ScriptVar], a
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
	ld [ScriptVar], a
	xor a
	ld [hl], a
	ret


GetWhiteoutSpawn: ; 12527
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	farcall IsSpawnPoint
	ld a, c
	jr c, .yes
	xor a ; SPAWN_HOME

.yes
	ld [wd001], a
	ret
; 1253d
