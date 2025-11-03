FindItemInBallScript::
	callasm .TryReceiveItem
	iffalsefwd .no_room
	disappear LAST_TALKED
	opentext
	farwritetext _FoundItemText
	special ShowItemIcon
	specialsound
	itemnotify
	closetext
	end

.no_room
	opentext
	farwritetext _FoundItemText
	waitbutton
	pocketisfull
	closetext
	end

.TryReceiveItem:
	xor a
	ldh [hScriptVar], a
	ld a, [wItemBallItemID]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, wStringBuffer3
	call CopyName2
	ld a, [wItemBallItemID]
	ld [wCurItem], a
	ld a, [wItemBallQuantity]
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	ret nc
	ld a, $1
	ldh [hScriptVar], a
	ret

FindKeyItemInBallScript::
	callasm .ReceiveKeyItem
	disappear LAST_TALKED
	opentext
	farwritetext _FoundItemText
	special ShowKeyItemIcon
	specialsound
	keyitemnotify
	closetext
	end

.ReceiveKeyItem:
	xor a
	ldh [hScriptVar], a
	ld a, [wItemBallItemID]
	ld [wNamedObjectIndex], a
	call GetKeyItemName
	ld hl, wStringBuffer3
	call CopyName2
	ld a, [wItemBallItemID]
	ld [wCurKeyItem], a
	call ReceiveKeyItem
	ld a, $1
	ldh [hScriptVar], a
	ret

FindTMHMInBallScript::
	callasm .ReceiveTMHM
	disappear LAST_TALKED
	opentext
	farwritetext _FoundItemText
	callasm ShowTMHMIcon
	playsound SFX_GET_TM
	waitsfx
	tmhmnotify
	closetext
	end

.ReceiveTMHM:
	xor a
	ldh [hScriptVar], a
	ld a, [wItemBallItemID]
	ld [wNamedObjectIndex], a
	call GetTMHMName
	ld hl, wStringBuffer3
	call CopyName2

	; off by one error?
	ld a, [wNamedObjectIndex]
	inc a
	ld [wTempTMHM], a

	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld hl, wStringBuffer3 + 4 ; assume all TM names are 4 characters, "TM##"
	ld a, ' '
	ld [hli], a
	call CopyName2

	ld a, [wItemBallItemID]
	ld [wCurTMHM], a
	call ReceiveTMHM
	ld a, $1
	ldh [hScriptVar], a
	ret
