HiddenItemScript:
	opentext
	readmem wHiddenItemID
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	farwritetext _FoundItemText
	giveitem ITEM_FROM_MEM
	iffalsefwd .bag_full
	callasm SetMemEvent
	special ShowItemIcon
	specialsound
	itemnotify
	endtext

.bag_full
	promptbutton
	pocketisfull
	endtext

SetMemEvent:
	ld hl, wHiddenItemEvent
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, SET_FLAG
	jmp EventFlagAction
