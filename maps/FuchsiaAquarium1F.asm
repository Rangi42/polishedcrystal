FuchsiaAquarium1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, FuchsiaAquariumCheckIfWeekend

	def_warp_events
	warp_event  6,  9, FUCHSIA_CITY, 12
	warp_event  7,  9, FUCHSIA_CITY, 13
	warp_event 10,  2, FUCHSIA_AQUARIUM_2F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  5, BGEVENT_READ, FuchsiaAquarium1FGoldeenOrQwilfishSign
	bg_event  2,  5, BGEVENT_READ, FuchsiaAquarium1FMagikarpSign
	bg_event 13,  5, BGEVENT_READ, FuchsiaAquarium1FCorsolaSign
	bg_event 15,  5, BGEVENT_READ, FuchsiaAquarium1FTentacoolOrHorseaSign
	bg_event 16,  5, BGEVENT_READ, FuchsiaAquarium1FChinchouSign
	bg_event  8,  3, BGEVENT_JUMPTEXT, FuchsiaAquarium1FLaprasStatueSignText
	bg_event  5,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium1FPoster1Text
	bg_event  6,  2, BGEVENT_JUMPTEXT, FuchsiaAquarium1FPoster2Text

	def_object_events
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, GOLDEEN, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, QWILFISH, -1, PAL_NPC_AQUA_PURPLE, OBJECTTYPE_DONOTHING, HISUIAN_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  2,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_ADMIN_MEOWTH, 0, MAGIKARP, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 13,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, CORSOLA, -1, PAL_NPC_AQUA_RED, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, TENTACOOL, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 15,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_TOP, 0, HORSEA, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 16,  4, SPRITE_AQUARIUM_MON, SPRITEMOVEDATA_AQUARIUM_BOTTOM, 0, CHINCHOU, -1, PAL_NPC_AQUA_BLUE, OBJECTTYPE_DONOTHING, NO_FORM, DoNothingScript, -1
	object_event  3, 9, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FReceptionistText, -1
	object_event  1, 9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FOfficerText, -1
	object_event  9,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FCuteGirlText, -1
	object_event  4, 4, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FSchoolboyText, -1
	object_event  13, 9, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FFisherText, -1
	object_event  14, 9, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_ORANGE, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaAquarium1FAromaLadyText, -1

FuchsiaAquariumCheckIfWeekend:
	readvar VAR_WEEKDAY
	ifequalfwd SATURDAY, .weekend
	ifequalfwd SUNDAY, .weekend
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	endcallback

.weekend
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

FuchsiaAquarium1FGoldeenOrQwilfishSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .GoldeenText
	reanchormap
	pokepic GOLDEEN
	cry GOLDEEN
	waitbutton
	closepokepic
	setmonval GOLDEEN
	special SpecialSeenMon
	end

.weekend:
	showtext .QwilfishText
	reanchormap
	pokepic QWILFISH, HISUIAN_FORM
	cry QWILFISH, HISUIAN_FORM
	waitbutton
	closepokepic
	setmonval QWILFISH, HISUIAN_FORM
	special SpecialSeenMon
	end

.GoldeenText:
	text "Name: Goldeen"

	para "Known as the"
	line "“Water Queen” for"
	cont "its tail fin,"

	para "which billows like"
	line "a ballroom dress."
	done

.QwilfishText:
	text "Name: Qwilfish"

	para "It eats toxic min-"
	line "erals to build up"

	para "poison within its"
	line "body for defense."
	done

FuchsiaAquarium1FMagikarpSign:
	showtext .MagikarpText
	reanchormap
	pokepic MAGIKARP
	cry MAGIKARP
	waitbutton
	closepokepic
	setmonval MAGIKARP
	special SpecialSeenMon
	end

.MagikarpText:
	text "Name: Magikarp"

	para "Legend has it that"
	line "a Magikarp which"
	cont "climbs a waterfall"

	para "will evolve into a"
	line "powerful Gyarados."
	done

FuchsiaAquarium1FCorsolaSign:
	showtext .CorsolaText
	reanchormap
	pokepic CORSOLA
	cry CORSOLA
	waitbutton
	closepokepic
	setmonval CORSOLA
	special SpecialSeenMon
	end

.CorsolaText:
	text "Name: Corsola"

	para "It continuously"
	line "sheds and grows."

	para "The tip of its"
	line "head is prized as"

	para "a treasure for its"
	line "beauty."
	done

FuchsiaAquarium1FTentacoolOrHorseaSign:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftruefwd .weekend
	showtext .TentacoolText
	reanchormap
	pokepic TENTACOOL
	cry TENTACOOL
	waitbutton
	closepokepic
	setmonval TENTACOOL
	special SpecialSeenMon
	end

.weekend:
	showtext .HorseaText
	reanchormap
	pokepic HORSEA
	cry HORSEA
	waitbutton
	closepokepic
	setmonval HORSEA
	special SpecialSeenMon
	end

.TentacoolText:
	text "Name: Tentacool"

	para "Its body is almost"
	line "entirely water."

	para "It shoots strange"
	line "beams from its"
	cont "crystal-like eyes."
	done

.HorseaText:
	text "Name: Horsea"

	para "It makes its nest"
	line "in the shade of"
	cont "Corsola clusters."
	done

FuchsiaAquarium1FChinchouSign:
	showtext .ChinchouText
	reanchormap
	pokepic CHINCHOU
	cry CHINCHOU
	waitbutton
	closepokepic
	setmonval CHINCHOU
	special SpecialSeenMon
	end

.ChinchouText:
	text "Name: Chinchou"

	para "It flashes lights"
	line "on its antennae to"

	para "communicate with"
	line "other Chinchou."
	done

FuchsiaAquarium1FLaprasStatueSignText:
	text "Lapras were once"
	line "near extinction"
	cont "due to poaching."

	para "Thanks to captive"
	line "breeding efforts"
	cont "run by Silph Co."

	para "and new protective"
	line "regulations, there"

	para "is now an over-"
	line "abundance of them."
	done

FuchsiaAquarium1FPoster1Text:
	text "Please do not tap"
	line "on the glass."
	done

FuchsiaAquarium1FPoster2Text:
	text "Please do not"
	line "throw anything"
	cont "inside the tanks."
	done

FuchsiaAquarium1FReceptionistText:
	text "Welcome to"
	line "Fuchsia Aquarium!"

	para "Our exhibits have"
	line "been generously"

	para "funded by Silph"
	line "Co. donations."
	done

FuchsiaAquarium1FOfficerText:
	text "I went from wrang-"
	line "ling #mon for"
	cont "the Safari Game,"

	para "to cleaning their"
	line "tanks in here."

	para "At least this job"
	line "has A/C!"
	done

FuchsiaAquarium1FCuteGirlText:
	text "There used to be"
	line "an Octillery here,"

	para "but it kept get-"
	line "thing out of its"

	para "tank to tour the"
	line "aquarium itself."
	done

FuchsiaAquarium1FSchoolboyText:
	text "Scientists think"
	line "that all life"

	para "began as microbes"
	line "under the ocean."

	para "It took billions"
	line "of years to turn"

	para "into all these"
	line "different species."
	done

FuchsiaAquarium1FFisherText:
	text "I can see #mon"
	line "here that I've"

	para "never been able"
	line "to catch just by"
	cont "fishing."
	done

FuchsiaAquarium1FAromaLadyText:
	text "Don't the #mon"
	line "just look like"
	cont "living jewels?"

	para "They even give"
	line "off their own"
	cont "sparkling light!"
	done
