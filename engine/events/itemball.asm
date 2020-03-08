FindItemInBallScript::
	callasm .TryReceiveItem
	iffalse .no_room
	disappear LAST_TALKED
	opentext
	writetext .text_found
	specialsound
	itemnotify
	closetext
	end

.no_room
	opentext
	writetext .text_found
	waitbutton
	pocketisfull
	closetext
	end

.text_found
	; found @ !
	text_jump UnknownText_0x1c0a1c
	db "@"

.TryReceiveItem:
	xor a
	ld [hScriptVar], a
	ld a, [wCurItemBallContents]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, wStringBuffer3
	call CopyName2
	ld a, [wCurItemBallContents]
	ld [wCurItem], a
	ld a, [wCurItemBallQuantity]
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	ret nc
	ld a, $1
	ld [hScriptVar], a
	ret

FindKeyItemInBallScript::
	callasm .ReceiveKeyItem
	disappear LAST_TALKED
	opentext
	writetext .text_found
	specialsound
	waitsfx
	keyitemnotify
	closetext
	end

.text_found
	; found @ !
	text_jump UnknownText_0x1c0a1c
	db "@"

.ReceiveKeyItem:
	xor a
	ld [hScriptVar], a
	ld a, [wCurItemBallContents]
	inc a
	ld [wNamedObjectIndexBuffer], a
	call GetKeyItemName
	ld hl, wStringBuffer3
	call CopyName2
	ld a, [wCurItemBallContents]
	ld [wCurKeyItem], a
	call ReceiveKeyItem
	ld a, $1
	ld [hScriptVar], a
	ret

FindTMHMInBallScript::
	callasm .ReceiveTMHM
	disappear LAST_TALKED
	opentext
	writetext .text_found
	playsound SFX_GET_TM
	waitsfx
	tmhmnotify
	closetext
	end

.text_found
	; found @ !
	text_jump UnknownText_0x1c0a1c
	db "@"

.ReceiveTMHM:
	xor a
	ld [hScriptVar], a
	ld a, [wCurItemBallContents]
	ld [wNamedObjectIndexBuffer], a
	call GetTMHMName
	ld hl, wStringBuffer3
	call CopyName2

	; off by one error?
	ld a, [wd265]
	inc a
	ld [wd265], a

	predef GetTMHMMove
	ld a, [wd265]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld hl, wStringBuffer3 + 4 ; assume all TM names are 4 characters, "TM##"
	ld a, " "
	ld [hli], a
	call CopyName2

	ld a, [wCurItemBallContents]
	ld [wCurTMHM], a
	call ReceiveTMHM
	ld a, $1
	ld [hScriptVar], a
	ret
