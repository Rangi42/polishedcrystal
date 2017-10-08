ViridianForest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianForest_MapEventHeader:

.Warps: db 3
	warp_def 5, 3, 1, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def 47, 18, 1, VIRIDIAN_FOREST_VIRIDIAN_GATE
	warp_def 47, 19, 2, VIRIDIAN_FOREST_VIRIDIAN_GATE

.XYTriggers: db 0

.Signposts: db 11
	signpost 7, 4, SIGNPOST_JUMPTEXT, ViridianForestSignText1
	signpost 26, 6, SIGNPOST_JUMPTEXT, ViridianForestSignText2
	signpost 19, 28, SIGNPOST_JUMPTEXT, ViridianForestSignText3
	signpost 34, 18, SIGNPOST_JUMPTEXT, ViridianForestSignText4
	signpost 42, 26, SIGNPOST_JUMPTEXT, ViridianForestSignText5
	signpost 44, 20, SIGNPOST_JUMPTEXT, ViridianForestSignText6
	signpost 44, 32, SIGNPOST_ITEM + MAX_ETHER, EVENT_VIRIDIAN_FOREST_HIDDEN_MAX_ETHER
	signpost 43, 18, SIGNPOST_ITEM + FULL_HEAL, EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_HEAL
	signpost 43, 4, SIGNPOST_ITEM + MULCH, EVENT_VIRIDIAN_FOREST_HIDDEN_MULCH
	signpost 9, 30, SIGNPOST_ITEM + REVIVE, EVENT_VIRIDIAN_FOREST_HIDDEN_REVIVE
	signpost 14, 3, SIGNPOST_ITEM + LEAF_STONE, EVENT_VIRIDIAN_FOREST_HIDDEN_LEAF_STONE

.PersonEvents: db 8
	person_event SPRITE_BALL_CUT_FRUIT, 18, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ViridianForestWeedleDoll, EVENT_DECO_WEEDLE_DOLL
	itemball_event 31, 14, DIRE_HIT, 1, EVENT_ROUTE_2_DIRE_HIT
	itemball_event 33, 3, MAX_POTION, 1, EVENT_ROUTE_2_MAX_POTION
	person_event SPRITE_BUG_MANIAC, 42, 29, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerBug_maniacDane, -1
	person_event SPRITE_BUG_MANIAC, 35, 33, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 5, TrainerBug_maniacDion, -1
	person_event SPRITE_BUG_MANIAC, 21, 32, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBug_maniacStacey, -1
	person_event SPRITE_BUG_MANIAC, 4, 31, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBug_maniacEllis, -1
	person_event SPRITE_BUG_MANIAC, 24, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBug_maniacAbner, -1

const_value set 1
	const VIRIDIAN_FOREST_POKE_BALL3

TrainerBug_maniacDane:
	trainer EVENT_BEAT_BUG_MANIAC_DANE, BUG_MANIAC, DANE, BugManiacDaneSeenText, BugManiacDaneBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BugManiacDaneAfterText

TrainerBug_maniacDion:
	trainer EVENT_BEAT_BUG_MANIAC_DION, BUG_MANIAC, DION, BugManiacDionSeenText, BugManiacDionBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BugManiacDionAfterText

TrainerBug_maniacStacey:
	trainer EVENT_BEAT_BUG_MANIAC_STACEY, BUG_MANIAC, STACEY, BugManiacStaceySeenText, BugManiacStaceyBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BugManiacStaceyAfterText

TrainerBug_maniacEllis:
	trainer EVENT_BEAT_BUG_MANIAC_ELLIS, BUG_MANIAC, ELLIS, BugManiacEllisSeenText, BugManiacEllisBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BugManiacEllisAfterText

TrainerBug_maniacAbner:
	trainer EVENT_BEAT_BUG_MANIAC_ABNER, BUG_MANIAC, ABNER, BugManiacAbnerSeenText, BugManiacAbnerBeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer BugManiacAbnerAfterText

ViridianForestWeedleDoll:
	disappear VIRIDIAN_FOREST_POKE_BALL3
	setevent EVENT_DECO_WEEDLE_DOLL
	opentext
	writetext ViridianForestWeedleDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	jumpopenedtext ViridianForestWeedleSentText

BugManiacDaneSeenText:
	text "Welcome to"
	line "Viridian Forest."
	cont "Enjoy my Bug-type"
	cont "#mon."
	done

BugManiacDaneBeatenText:
	text "That's wonderful…"
	done

BugManiacDaneAfterText:
	text "Pretty impressive!"

	para "I'm sure you can"
	line "go anywhere with"
	cont "that skill!"
	done

BugManiacDionSeenText:
	text "Shh! Be quiet! The"
	line "bug #mon will"
	cont "run away!"
	done

BugManiacDionBeatenText:
	text "Phew…"
	done

BugManiacDionAfterText:
	text "Bug-type #mon"
	line "make all kinds of"
	cont "sounds."

	para "For bug #mon"
	line "fans, knowing how"
	cont "to distinguish"
	cont "them is key!"
	done

BugManiacStaceySeenText:
	text "Wow, that's a HUGE"
	line "#mon!"

	para "…"
	line "…What kind of"
	cont "trainer?!"
	done

BugManiacStaceyBeatenText:
	text "I couldn't catch"
	line "it!"
	done

BugManiacStaceyAfterText:
	text "Has anyone ever"
	line "told you that from"
	cont "behind you look"
	cont "like a Venonat?"
	done

BugManiacEllisSeenText:
	text "There's nothing"
	line "more efficient and"
	cont "beautiful than a"
	cont "Bug-type #mon."
	done

BugManiacEllisBeatenText:
	text "I lost"
	line "beautifully!"
	done

BugManiacEllisAfterText:
	text "If this is it,"
	line "then I don't mind"
	cont "losing!"
	done

BugManiacAbnerSeenText:
	text "Many people prefer"
	line "solid bug #mon"
	cont "over squishy bug"
	cont "#mon."
	done

BugManiacAbnerBeatenText:
	text "Thanks for your"
	line "hard work, my"
	cont "lovely #mon…"
	done

BugManiacAbnerAfterText:
	text "Doesn't matter what"
	line "kind of #mon--"

	para "as long as you"
	line "like them, they"
	cont "all look cute."
	done

ViridianForestWeedleDollText:
	text "<PLAYER> found"
	line "Weedle Doll."
	done

ViridianForestWeedleSentText:
	text "Weedle Doll"
	line "was sent home."
	done

ViridianForestSignText1:
	text "Leaving"
	line "Viridian Forest"
	cont "Pewter City Ahead"
	done

ViridianForestSignText2:
	text "Trainer Tips"

	para "No stealing of"
	line "#mon from"
	cont "other trainers!"
	cont "Catch only wild"
	cont "#mon!"
	done

ViridianForestSignText3:
	text "Trainer Tips"

	para "Contact Prof.Oak"
	line "via PC to get"
	cont "your #dex"
	cont "evaluated!"
	done

ViridianForestSignText4:
	text "For poison, use"
	line "Antidote! Get it"
	cont "at #mon Marts!"
	done

ViridianForestSignText5:
	text "Trainer Tips"

	para "If you want to"
	line "avoid battles,"
	cont "stay away from"
	cont "grassy areas!"
	done

ViridianForestSignText6:
	text "Trainer Tips"

	para "Weaken #mon"
	line "before attempting"
	cont "capture!"

	para "When healthy,"
	line "they may escape!"
	done
