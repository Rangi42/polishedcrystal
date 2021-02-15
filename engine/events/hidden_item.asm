HiddenItemScript:
	opentext
	copybytetovar wHiddenItemID
	itemtotext STRING_BUFFER_3, USE_SCRIPT_VAR
	farwritetext _FoundItemText
	giveitem ITEM_FROM_MEM
	iffalse .bag_full
	callasm SetMemEvent
	specialsound
	itemnotify
	endtext

.bag_full
	buttonsound
	pocketisfull
	endtext

SetMemEvent:
	ld hl, wHiddenItemEvent
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, SET_FLAG
	jp EventFlagAction
