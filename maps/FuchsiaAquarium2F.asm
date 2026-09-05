FuchsiaAquarium2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FuchsiaAquariumCheckIfWeekend

	def_warp_events
	warp_event 10,  2, FUCHSIA_AQUARIUM_1F, 3

	def_coord_events

	def_bg_events
	bg_event  1,  5, BGEVENT_READ, FuchsiaAquarium1FRemoraidSign
	bg_event  2,  5, BGEVENT_READ, FuchsiaAquarium1FMantineSign
	bg_event  6,  5, BGEVENT_READ, FuchsiaAquarium1FSquirtleOrSeelSign
	bg_event 15,  5, BGEVENT_READ, FuchsiaAquarium1FShellderOrKrabbySign
	bg_event 16,  5, BGEVENT_READ, FuchsiaAquarium1FStaryuSign
	bg_event 12,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium2FPosterText

	def_object_events
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, REMORAID, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  2,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, MANTINE, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  6,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, SQUIRTLE, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  6,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, SEEL, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, SHELLDER, -1, PAL_NPC_AQUA_PURPLE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, KRABBY, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, STARYU, -1, PAL_NPC_AQUA_BROWN, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 12,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FPokefanMScript, -1
	object_event 16, 7, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium2FPokefanFText, -1
	object_event  2,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_DARK_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FLassScript, -1
	object_event  3,  7, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_AZURE, OBJECTTYPE_SCRIPT, 0, FuchsiaAquarium2FBattleGirlScript, -1

FuchsiaAquarium1FRemoraidSign:
	showtext .RemoraidText
	reanchormap
	pokepic REMORAID
	cry REMORAID
	waitbutton
	closepokepic
	setmonval REMORAID
	special SpecialSeenMon
	end

.RemoraidText:
	text "Name: Remoraid"

	para "Using its dorsal"
	line "fin as a suction"
	cont "pad, it clings to"

	para "a Mantine's under-"
	line "side to scavenge"
	cont "for leftovers."
	done

FuchsiaAquarium1FMantineSign:
	showtext .MantineText
	reanchormap
	pokepic MANTINE
	cry MANTINE
	waitbutton
	closepokepic
	setmonval MANTINE
	special SpecialSeenMon
	end

.MantineText:
	text "Name: Mantine"

	para "It may fly out of"
	line "the water and over"

	para "the waves if it"
	line "builds up enough"
	cont "speed."
	done

FuchsiaAquarium1FSquirtleOrSeelSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .SquirtleText
	reanchormap
	pokepic SQUIRTLE
	cry SQUIRTLE
	waitbutton
	closepokepic
	setmonval SQUIRTLE
	special SpecialSeenMon
	end

.weekend:
	showtext .SeelText
	reanchormap
	pokepic SEEL
	cry SEEL
	waitbutton
	closepokepic
	setmonval SEEL
	special SpecialSeenMon
	end

.SquirtleText:
	text "Name: Squirtle"

	para "Its shell pattern"
	line "resembles an old"
	cont "coin, so one"

	para "region recently"
	line "made commemorative"

	para "¥100 coins featur-"
	line "ing Squirtle."
	done

.SeelText:
	text "Name: Seel"

	para "This #mon does"
	line "not drink water--"

	para "it gets all its"
	line "hydration from the"
	cont "prey it eats."
	done

FuchsiaAquarium1FShellderOrKrabbySign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .ShellderText
	reanchormap
	pokepic SHELLDER
	cry SHELLDER
	waitbutton
	closepokepic
	setmonval SHELLDER
	special SpecialSeenMon
	end

.weekend:
	showtext .KrabbyText
	reanchormap
	pokepic KRABBY
	cry KRABBY
	waitbutton
	closepokepic
	setmonval KRABBY
	special SpecialSeenMon
	end

.ShellderText:
	text "Name: Shellder"

	para "It changes shape"
	line "drastically when"

	para "it bites a Slow-"
	line "poke to coevolve,"

	para "but this is not"
	line "considered a"
	cont "unique evolution."
	done

.KrabbyText:
	text "Name: Krabby"

	para "Fishers used to"
	line "release Krabby"

	para "they caught with"
	line "shells resembling"
	cont "an angry samurai."

	para "This may have re-"
	line "sulted in more"

	para "surviving Krabby"
	line "today with shell"

	para "patterns that look"
	line "like human faces."
	done

FuchsiaAquarium1FStaryuSign:
	showtext .StaryuText
	reanchormap
	pokepic STARYU
	cry STARYU
	waitbutton
	closepokepic
	setmonval STARYU
	special SpecialSeenMon
	end

.StaryuText:
	text "Name: Staryu"

	para "A popular science"
	line "fiction show for"

	para "children features"
	line "superheroes using"

	para "powers based on"
	line "Staryu's gem."
	done

FuchsiaAquarium2FPosterText:
	text "We rotate exhibits"
	line "on weekends to"

	para "keep the #mon"
	line "from being bored."
	done

FuchsiaAquarium2FPokefanMScript:
	checkevent EVENT_GOT_EJECT_BUTTON_FROM_FUCHSIA_AQUARIUM
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem EJECT_BUTTON, iffalse_endtext
	setevent EVENT_GOT_EJECT_BUTTON_FROM_FUCHSIA_AQUARIUM
	jumpthisopenedtext

.Text2:
	text "One time I hit a"
	line "Chansey with a"
	cont "rock, and it fled"

	para "as fast as if it"
	line "had been holding"
	cont "an Eject Button."

	para "Ah, the good old"
	line "days…"
	done

.Text1:
	text "All these Pokemon"
	line "behind glass, but"

	para "I can't throw any-"
	line "thing at them!"

	para "I miss tossing"
	line "bait and rocks in"
	cont "the Safari Game…"

	para "Right up until"
	line "they'd call time"

	para "on the PA system"
	line "and eject me."

	para "Shucks, you may as"
	line "well have this."
	done

FuchsiaAquarium2FPokefanFText:
	text "The Warden's sudden"
	line "departure was a"

	para "blessing in dis-"
	line "guise."

	para "Now we have this"
	line "lovely aquarium!"
	done

FuchsiaAquarium2FLassScript:
	turnobject LAST_TALKED, RIGHT
	showtext .Text1
	faceplayer
	showtext .Text2
	turnobject LAST_TALKED, UP
	end

.Text1:
	text "Remoraid clings to"
	line "Mantine and shares"
	cont "in its prosperity…"

	para "That's romantic,"
	line "right?"
	done

.Text2:
	text "I memorized lots"
	line "of #dex facts"

	para "to interest my"
	line "date!"
	done

FuchsiaAquarium2FBattleGirlScript:
	faceplayer
	showtext .Text
	turnobject LAST_TALKED, UP
	end

.Text:
	text "This girl has been"
	line "nerding out about"

	para "water #mon for"
	line "the past hour…"

	para "You think for Val-"
	line "entine's Day she'd"

	para "like fish instead"
	line "of chocolate?"
	done
