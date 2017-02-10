const_value set 2
	const DIGLETTSCAVE_POKEFAN_M
	const DIGLETTSCAVE_POKE_BALL

DiglettsCave_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PokefanMScript_0x74002:
	jumptextfaceplayer UnknownText_0x74008

DiglettsCaveDiglettDoll:
	disappear DIGLETTSCAVE_POKE_BALL
	setevent EVENT_DECO_DIGLETT_DOLL
	opentext
	writetext DiglettsCaveDiglettDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext DiglettsCaveDiglettSentText
	waitbutton
	closetext
	end

DiglettsCaveHiddenMaxRevive:
	dwb EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE, MAX_REVIVE

UnknownText_0x74008:
if DEF(FAITHFUL)
	text "A bunch of Diglett"
	line "popped out of the"

	para "ground! That was"
	line "shocking."
else
	text "When the volcano"
	line "on Cinnabar Island"
	cont "erupted, it radic-"

	para "ally affected some"
	line "#mon species."

	para "Diglett and Dug-"
	line "trio burrowing"
	cont "underground got"

	para "covered in strands"
	line "of cooled lava,"

	para "blown here all the"
	line "way from Cinnabar."

	para "It's made them even"
	line "tougher. Good luck"
	cont "in the caves!"
endc
	done

DiglettsCaveDiglettDollText:
	text "<PLAYER> found"
	line "Diglett Doll."
	done

DiglettsCaveDiglettSentText:
	text "Diglett Doll"
	line "was sent home."
	done

DiglettsCave_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $21, $3, 10, VERMILION_CITY
	warp_def $1f, $5, 5, DIGLETTS_CAVE
	warp_def $5, $f, 5, ROUTE_2
	warp_def $3, $11, 6, DIGLETTS_CAVE
	warp_def $21, $11, 2, DIGLETTS_CAVE
	warp_def $3, $3, 4, DIGLETTS_CAVE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 6, SIGNPOST_ITEM, DiglettsCaveHiddenMaxRevive

.PersonEvents:
	db 2
	person_event SPRITE_POKEFAN_M, 31, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x74002, -1
	person_event SPRITE_POKE_BALL, 17, 12, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, DiglettsCaveDiglettDoll, EVENT_DECO_DIGLETT_DOLL
