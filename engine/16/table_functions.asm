INCLUDE "engine/16/macros.asm"

ForceGarbageCollection::
	push bc
	ldh a, [rSVBK]
	push af
	ld a, BANK("16-bit WRAM tables")
	ldh [rSVBK], a
	call MoveTableGarbageCollection
	pop af
	ldh [rSVBK], a
	pop bc
	ret

; Note: ID = 8-bit ID used in memory, etc.; index = true 16-bit index into tables

_GetMoveIndexFromID::
	___conversion_table_load wMoveIndexTable, MOVE_TABLE
_GetMoveIDFromIndex::
	___conversion_table_store wMoveIndexTable, MOVE_TABLE
	; fallthrough
MoveTableGarbageCollection:
	; must preserve de and rSVBK
	push de
	ldh a, [rSVBK]
	push af
	ld a, 1
	ldh [rSVBK], a
	FOR ___move, NUM_MOVES
		___conversion_bitmap_check_structs wPartyMon1Moves + ___move, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
		___conversion_bitmap_check_structs wBreedMon1Moves + ___move, wBreedMon2 - wBreedMon1, 2, .set_bit
		; may or may not be valid
		___conversion_bitmap_check_structs wOTPartyMon1Moves + ___move, PARTYMON_STRUCT_LENGTH, PARTY_LENGTH, .set_bit
		___conversion_bitmap_check_values .set_bit, wTempMonMoves + ___move, wContestMonMoves + ___move, wLevelUpMonMoves + ___move, \
                                                    wBattleMonMoves + ___move, wEnemyMonMoves + ___move, wPlayerUsedMoves + ___move, \
                                                    wAIMoves + ___move
	endr
	ld a, [wNamedObjectIndex] ;or any of its aliases...
	call .set_bit
	; only valid sometimes
	___conversion_bitmap_check_values .set_bit, wCurPlayerMove, wCurEnemyMove, \
	                                            wLastPlayerMove, wLastEnemyMove, wLastPlayerCounterMove, wLastEnemyCounterMove, \
	                                            wPlayerTrappingMove, wEnemyTrappingMove, wPlayerMoveStructAnimation, wEnemyMoveStructAnimation, \
	                                            wPutativeTMHMMove, wCurMove, wPlayerSelectedMove, wEnemySelectedMove, wForgettingMove
	pop af
	ldh [rSVBK], a
	___conversion_bitmap_free_unused wMoveIndexTable, MOVE_TABLE
	pop de
	ret

.set_bit
	___conversion_bitmap_set MOVE_TABLE

_LockMoveID::
	___conversion_table_lock_ID wMoveIndexTable, MOVE_TABLE
