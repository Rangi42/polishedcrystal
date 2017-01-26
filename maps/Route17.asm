const_value set 2
	const ROUTE17_BIKER1
	const ROUTE17_BIKER2
	const ROUTE17_BIKER3
	const ROUTE17_BIKER4
	const ROUTE17_BIKER5
	const ROUTE17_BIKER6
	const ROUTE17_BIKER7
	const ROUTE17_ROUGHNECK1
	const ROUTE17_ROUGHNECK2
	const ROUTE17_ROUGHNECK3

Route17_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, UnknownScript_0x1ad0ab

UnknownScript_0x1ad0ab:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	return

TrainerBikerReilly:
	trainer EVENT_BEAT_BIKER_REILLY, BIKER, REILLY, BikerReillySeenText, BikerReillyBeatenText, 0, BikerReillyScript

BikerReillyScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad13b
	waitbutton
	closetext
	end

TrainerBikerJoel:
	trainer EVENT_BEAT_BIKER_JOEL, BIKER, JOEL, BikerJoelSeenText, BikerJoelBeatenText, 0, BikerJoelScript

BikerJoelScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad196
	waitbutton
	closetext
	end

TrainerBikerGlenn:
	trainer EVENT_BEAT_BIKER_GLENN, BIKER, GLENN, BikerGlennSeenText, BikerGlennBeatenText, 0, BikerGlennScript

BikerGlennScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad225
	waitbutton
	closetext
	end

TrainerBikerDale:
	trainer EVENT_BEAT_BIKER_DALE, BIKER, DALE, BikerDaleSeenText, BikerDaleBeatenText, 0, BikerDaleScript

BikerDaleScript:
	end_if_just_battled
	opentext
	writetext BikerDaleAfterText
	waitbutton
	closetext
	end

TrainerBikerJacob:
	trainer EVENT_BEAT_BIKER_JACOB, BIKER, JACOB, BikerJacobSeenText, BikerJacobBeatenText, 0, BikerJacobScript

BikerJacobScript:
	end_if_just_battled
	opentext
	writetext BikerJacobAfterText
	waitbutton
	closetext
	end

TrainerBikerAiden:
	trainer EVENT_BEAT_BIKER_AIDEN, BIKER, AIDEN, BikerAidenSeenText, BikerAidenBeatenText, 0, BikerAidenScript

BikerAidenScript:
	end_if_just_battled
	opentext
	writetext BikerAidenAfterText
	waitbutton
	closetext
	end

TrainerRoughneckBrian:
	trainer EVENT_BEAT_ROUGHNECK_BRIAN, ROUGHNECK, BRIAN, RoughneckBrianSeenText, RoughneckBrianBeatenText, 0, RoughneckBrianScript

RoughneckBrianScript:
	end_if_just_battled
	opentext
	writetext RoughneckBrianAfterText
	waitbutton
	closetext
	end

TrainerRoughneckTheron:
	trainer EVENT_BEAT_ROUGHNECK_THERON, ROUGHNECK, THERON, RoughneckTheronSeenText, RoughneckTheronBeatenText, 0, RoughneckTheronScript

RoughneckTheronScript:
	end_if_just_battled
	opentext
	writetext RoughneckTheronAfterText
	waitbutton
	closetext
	end

TrainerRoughneckMarkey:
	trainer EVENT_BEAT_ROUGHNECK_MARKEY, ROUGHNECK, MARKEY, RoughneckMarkeySeenText, RoughneckMarkeyBeatenText, 0, RoughneckMarkeyScript

RoughneckMarkeyScript:
	end_if_just_battled
	opentext
	writetext RoughneckMarkeyAfterText
	waitbutton
	closetext
	end

Route17HiddenMaxEther:
	dwb EVENT_ROUTE_17_HIDDEN_MAX_ETHER, MAX_ETHER

Route17HiddenMaxElixer:
	dwb EVENT_ROUTE_17_HIDDEN_MAX_ELIXER, MAX_ELIXER

BikerReillySeenText:
	text "Hey, you! You're"
	line "from Johto, huh?"
	done

BikerReillyBeatenText:
	text "Whoa, you kick!"
	done

UnknownText_0x1ad13b:
	text "Don't get cocky,"
	line "you Johto punk!"
	done

BikerJoelSeenText:
	text "Wow. That's a cool"
	line "Bicycle!"
	done

BikerJoelBeatenText:
	text "But you don't just"
	line "look cool…"
	done

UnknownText_0x1ad196:
	text "I look cool, but"
	line "I'm weak, so I'm"
	cont "not really cool."

	para "I have to train"
	line "harder…"
	done

BikerGlennSeenText:
	text "Hey! Want to have"
	line "a speed battle?"
	done

BikerGlennBeatenText:
	text "Yikes! You've got"
	line "awesome torque!"
	done

UnknownText_0x1ad225:
	text "Hands-free riding"
	line "is considered cool"
	cont "on Cycling Road."
	done

BikerDaleSeenText:
	text "You're gonna lose!"
	line "I've got a hunch!"
	done

BikerDaleBeatenText:
	text "Maybe my hunch was"
	line "a little off…"
	done

BikerDaleAfterText:
	text "You're so cool!"
	line "You don't do any-"
	cont "thing halfway!"
	done

BikerJacobSeenText:
	text "Modding my"
	line "chopper costs a"

	para "bunch of money!"
	line "I need a job!"
	done

BikerJacobBeatenText:
	text "Argh. I failed!"
	done

BikerJacobAfterText:
	text "Chopper? Oh, I"
	line "was talking about"
	cont "my Bicycle!"
	done

BikerAidenSeenText:
	text "Vroom vroom!"
	line "Baribaribaribari!"

	para "What do you think"
	line "of my engine"
	cont "imitation?"
	done

BikerAidenBeatenText:
	text "Hnnff… hnnff…"
	line "I'm out of breath…"
	done

BikerAidenAfterText:
	text "Gaon gaooon!"
	line "Buwaribaribari…!"

	para "There, my engine"
	line "imitation has"
	cont "evolved!"
	done

RoughneckBrianSeenText:
	text "Hey, who told you"
	line "you could ride"
	cont "on this road?"
	done

RoughneckBrianBeatenText:
	text "Crash!"
	done

RoughneckBrianAfterText:
	text "See you later!"
	line "Come back anytime!"
	done

RoughneckTheronSeenText:
	text "I'll toughen you"
	line "up. Now, you come"
	cont "along with me."
	done

RoughneckTheronBeatenText:
	text "I lost. I lost!"
	done

RoughneckTheronAfterText:
	text "You wanna join"
	line "my team?"

	para "Won't you give it"
	line "a try?"
	done

RoughneckMarkeySeenText:
	text "Hey hey hey!"
	line "You're in my way!"

	para "IN MY WAY!"
	done

RoughneckMarkeyBeatenText:
	text "All right, thanks!"
	done

RoughneckMarkeyAfterText:
	text "All right!"

	para "That fighting"
	line "yell was great!"
	done

Route17_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 60, 9, SIGNPOST_ITEM, Route17HiddenMaxEther
	signpost 83, 8, SIGNPOST_ITEM, Route17HiddenMaxElixer

.PersonEvents:
	db 10
	person_event SPRITE_BIKER, 17, 4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBikerReilly, -1
	person_event SPRITE_BIKER, 57, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerBikerJoel, -1
	person_event SPRITE_BIKER, 50, 3, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBikerGlenn, -1
	person_event SPRITE_BIKER, 9, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBikerDale, -1
	person_event SPRITE_BIKER, 24, 18, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBikerJacob, -1
	person_event SPRITE_BIKER, 78, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBikerAiden, -1
	person_event SPRITE_BIKER, 90, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_ROUGHNECK, 29, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerRoughneckBrian, -1
	person_event SPRITE_ROUGHNECK, 38, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerRoughneckTheron, -1
	person_event SPRITE_ROUGHNECK, 73, 4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerRoughneckMarkey, -1
