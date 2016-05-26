const_value set 2
	const VIRIDIAN_FOREST_POKE_BALL1
	const VIRIDIAN_FOREST_POKE_BALL2
	const VIRIDIAN_FOREST_BUG_CATCHER1
	const VIRIDIAN_FOREST_BUG_CATCHER2
	const VIRIDIAN_FOREST_BUG_CATCHER3
	const VIRIDIAN_FOREST_BUG_CATCHER4
	const VIRIDIAN_FOREST_BUG_CATCHER5

ViridianForest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerBug_catcherDane:
	trainer EVENT_BEAT_BUG_CATCHER_DANE, BUG_CATCHER, DANE, BugCatcherDaneSeenText, BugCatcherDaneBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext BugCatcherDaneAfterText
	waitbutton
	closetext
	end

TrainerBug_catcherDion:
	trainer EVENT_BEAT_BUG_CATCHER_DION, BUG_CATCHER, DION, BugCatcherDionSeenText, BugCatcherDionBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext BugCatcherDionAfterText
	waitbutton
	closetext
	end

TrainerBug_catcherStacey:
	trainer EVENT_BEAT_BUG_CATCHER_STACEY, BUG_CATCHER, STACEY, BugCatcherStaceySeenText, BugCatcherStaceyBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext BugCatcherStaceyAfterText
	waitbutton
	closetext
	end

TrainerBug_catcherEllis:
	trainer EVENT_BEAT_BUG_CATCHER_ELLIS, BUG_CATCHER, ELLIS, BugCatcherEllisSeenText, BugCatcherEllisBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext BugCatcherEllisAfterText
	waitbutton
	closetext
	end

TrainerBug_catcherAbner:
	trainer EVENT_BEAT_BUG_CATCHER_ABNER, BUG_CATCHER, ABNER, BugCatcherAbnerSeenText, BugCatcherAbnerBeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext BugCatcherAbnerAfterText
	waitbutton
	closetext
	end

MapViridianForestSignpost1Script:
	jumptext ViridianForestSignText1

MapViridianForestSignpost2Script:
	jumptext ViridianForestSignText2

MapViridianForestSignpost3Script:
	jumptext ViridianForestSignText3

MapViridianForestSignpost4Script:
	jumptext ViridianForestSignText4

MapViridianForestSignpost5Script:
	jumptext ViridianForestSignText5

MapViridianForestSignpost6Script:
	jumptext ViridianForestSignText6

ViridianForestDireHit:
	itemball DIRE_HIT

ViridianForestMaxPotion:
	itemball MAX_POTION

ViridianForestHiddenMaxEther:
	dwb EVENT_VIRIDIAN_FOREST_HIDDEN_MAX_ETHER, MAX_ETHER

ViridianForestHiddenFullHeal:
	dwb EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_HEAL, FULL_HEAL

ViridianForestHiddenFullRestore:
	dwb EVENT_VIRIDIAN_FOREST_HIDDEN_FULL_RESTORE, FULL_RESTORE

ViridianForestHiddenRevive:
	dwb EVENT_VIRIDIAN_FOREST_HIDDEN_REVIVE, REVIVE

ViridianForestHiddenLeafStone:
	dwb EVENT_VIRIDIAN_FOREST_HIDDEN_LEAF_STONE, LEAF_STONE

BugCatcherDaneSeenText:
	text "Welcome to"
	line "Viridian Forest."
	cont "Enjoy my Bug-type"
	cont "#mon."
	done

BugCatcherDaneBeatenText:
	text "That's wonderful…"
	done

BugCatcherDaneAfterText:
	text "Pretty impressive!"

	para "I'm sure you can"
	line "go anywhere with"
	cont "that skill!"
	done

BugCatcherDionSeenText:
	text "Shh! Be quiet! The"
	line "bug #mon will"
	cont "run away!"
	done

BugCatcherDionBeatenText:
	text "Phew…"
	done

BugCatcherDionAfterText:
	text "Bug-type #mon"
	line "make all kinds of"
	cont "sounds."

	para "For bug #mon"
	line "fans, knowing how"
	cont "to distinguish"
	cont "them is key!"
	done

BugCatcherStaceySeenText:
	text "Wow, that's a HUGE"
	line "#mon!"

	para "…"
	line "…What kind of"
	cont "Trainer?!"
	done

BugCatcherStaceyBeatenText:
	text "I couldn't catch"
	line "it!"
	done

BugCatcherStaceyAfterText:
	text "Has anyone ever"
	line "told you that from"
	cont "behind you look"
	cont "like a Venonat?"
	done

BugCatcherEllisSeenText:
	text "There's nothing"
	line "more efficient and"
	cont "beautiful than a"
	cont "Bug-type #mon."
	done

BugCatcherEllisBeatenText:
	text "I lost"
	line "beautifully!"
	done

BugCatcherEllisAfterText:
	text "If this is it,"
	line "then I don't mind"
	cont "losing!"
	done

BugCatcherAbnerSeenText:
	text "Many people prefer"
	line "solid bug #mon"
	cont "over squishy bug"
	cont "#mon."
	done

BugCatcherAbnerBeatenText:
	text "Thanks for your"
	line "hard work, my"
	cont "lovely #mon…"
	done

BugCatcherAbnerAfterText:
	text "Doesn't matter what"
	line "kind of #mon--"

	para "as long as you"
	line "like them, they"
	cont "all look cute."
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

ViridianForest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $3, $1, 1, VIRIDIAN_FOREST_PEWTER_GATE
	warp_def $2D, $11, 1, VIRIDIAN_FOREST_VIRIDIAN_GATE
	warp_def $2D, $12, 2, VIRIDIAN_FOREST_VIRIDIAN_GATE

.XYTriggers:
	db 0

.Signposts:
	db 11
	signpost 5, 2, SIGNPOST_READ, MapViridianForestSignpost1Script
	signpost 24, 4, SIGNPOST_READ, MapViridianForestSignpost2Script
	signpost 17, 26, SIGNPOST_READ, MapViridianForestSignpost3Script
	signpost 32, 16, SIGNPOST_READ, MapViridianForestSignpost4Script
	signpost 40, 24, SIGNPOST_READ, MapViridianForestSignpost5Script
	signpost 42, 18, SIGNPOST_READ, MapViridianForestSignpost6Script
	signpost 42, 30, SIGNPOST_ITEM, ViridianForestHiddenMaxEther
	signpost 41, 16, SIGNPOST_ITEM, ViridianForestHiddenFullHeal
	signpost 41, 2, SIGNPOST_ITEM, ViridianForestHiddenFullRestore
	signpost 7, 28, SIGNPOST_ITEM, ViridianForestHiddenRevive
	signpost 12, 1, SIGNPOST_ITEM, ViridianForestHiddenLeafStone

.PersonEvents:
	db 7
	person_event SPRITE_POKE_BALL, 29, 12, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, ViridianForestDireHit, EVENT_ROUTE_2_DIRE_HIT
	person_event SPRITE_POKE_BALL, 31, 1, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, 0, PERSONTYPE_ITEMBALL, 0, ViridianForestMaxPotion, EVENT_ROUTE_2_MAX_POTION
	person_event SPRITE_BUG_CATCHER, 40, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerBug_catcherDane, -1
	person_event SPRITE_BUG_CATCHER, 33, 31, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 5, TrainerBug_catcherDion, -1
	person_event SPRITE_BUG_CATCHER, 19, 30, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBug_catcherStacey, -1
	person_event SPRITE_BUG_CATCHER, 2, 29, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBug_catcherEllis, -1
	person_event SPRITE_BUG_CATCHER, 22, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBug_catcherAbner, -1
