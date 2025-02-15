SECTION "Follower Script", ROMX

FollowerScript::
; TODO: Implement follower script
;	callasm StoreFollowerNickInBuffer
	faceplayer
;	opentext
	cry PIKACHU
;	random 50
;	ifequalfwd 1, .give_item
	applymovement FOLLOWER, .followerjump
;	writetext .text
;	closetext
	end

.give_item
	writetext .found_item
	yesorno
	iffalse .done
	verbosegiveitem NUGGET
.done
	closetext
	end

.text
	text "@"
	text_ram wStringBuffer1
	text " is"
	line "happy to be with"
	cont "you!"
	done

.found_item
	text "@"
	text_ram wStringBuffer1
	text " seems"
	line "to have found"
	cont "something."

	para "Take it?"
	done

.followerjump:
	jump_in_place
	jump_in_place
	jump_in_place
	step_end

StoreFollowerNickInBuffer:
	ld a, [wFollowerPartyNum]
	dec a
	ld hl, wPartyMon1Nickname
	and a
	jr z, .done
	ld de, MON_NAME_LENGTH
.loop
	add hl, de
	dec a
	jr nz, .loop
.done
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	jp CopyBytes
