LoadBattleMenu:
	ld hl, BattleMenuDataHeader
	jr _BattleMenuCommon

ContestBattleMenu:
	ld hl, ContestBattleMenuDataHeader
	jr _BattleMenuCommon

SafariBattleMenu:
	ld hl, SafariBattleMenuDataHeader
_BattleMenuCommon:
	call LoadMenuHeader
	ld a, [wBattleMenuCursorBuffer]
	ld [wMenuCursorBuffer], a
	ld b, QUICK_B
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jr z, .ok
	cp BATTLETYPE_CONTEST
	jr z, .ok
	ld b, QUICK_B | QUICK_START | QUICK_SELECT
	ld a, [wBattleMode]
	dec a
	ld a, QUICK_START | QUICK_SELECT
	jr nz, .ok2
.ok
	ld a, b
.ok2
	ld [wBattleMenuFlags], a
	call _2DMenu
	ld a, [wBattleMenuFlags]
	and QUICK_PACK
	ld [wBattleMenuFlags], a
	ld a, [wMenuCursorBuffer]
	ld [wBattleMenuCursorBuffer], a
	jp ExitMenu

BattleMenuDataHeader:
	db $40 ; flags
	db 12, 08 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $87 ; flags
	dn 2, 2 ; rows, columns
	db 6 ; spacing
	dba .Strings
	dbw BANK(.MenuData2), 0

.Strings:
	db "Fight@"
	db "<PK><MN>@"
	db "Bag@"
	db "Run@"

ContestBattleMenuDataHeader:
	db $40 ; flags
	db 12, 05 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $81 ; flags
	dn 2, 2 ; rows, columns
	db 8 ; spacing
	dba .Strings
	dba ShowParkBallsRemaining

.Strings:
	db "Fight@"
	db "<PK><MN>@"
	db "Ball×  @"
	db "Run@"

ShowParkBallsRemaining:
	hlcoord 12, 16
	ld de, wParkBallsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum

SafariBattleMenuDataHeader:
	db $40 ; flags
	db 12, 04 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $81 ; flags
	dn 2, 2 ; rows, columns
	db 8 ; spacing
	dba .Strings
	dba ShowSafariBallsRemaining

.Strings:
	db "Ball×  @"
	db "Bait@"
	db "Rock@"
	db "Run@"

ShowSafariBallsRemaining:
	hlcoord 11, 14
	ld de, wSafariBallsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum
