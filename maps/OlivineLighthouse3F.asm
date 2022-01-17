OlivineLighthouse3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  3, OLIVINE_LIGHTHOUSE_4F, 1
	warp_event  5,  3, OLIVINE_LIGHTHOUSE_2F, 2
	warp_event  9,  5, OLIVINE_LIGHTHOUSE_4F, 4
	warp_event 16, 11, OLIVINE_LIGHTHOUSE_2F, 5
	warp_event 17, 11, OLIVINE_LIGHTHOUSE_2F, 6
	warp_event 16,  9, OLIVINE_LIGHTHOUSE_4F, 5
	warp_event 17,  9, OLIVINE_LIGHTHOUSE_4F, 6
	warp_event  8,  3, OLIVINE_LIGHTHOUSE_4F, 7
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_4F, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9, 14, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouse3FBattleGirlEmy, -1
	object_event  9,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSailorTerrell, -1
	object_event 13,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerGentlemanPreston, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	object_event  3,  9, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerBird_keeperTheo, -1
	itemball_event  8,  2, ETHER, 1, EVENT_OLIVINE_LIGHTHOUSE_3F_ETHER

	object_const_def
	const OLIVINELIGHTHOUSE3F_COOLTRAINER_F

OlivineLighthouse3FBattleGirlEmy:
	checkevent EVENT_GOT_PROTECT_PADS_FROM_LIGHTHOUSE_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_BATTLE_GIRL_EMY
	iftrue .Beaten
	opentext
	checkevent EVENT_BEAT_GENTLEMAN_ALFRED
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_SAILOR_HUEY
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BIRD_KEEPER_THEO
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_GENTLEMAN_PRESTON
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_SAILOR_TERRELL
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_LASS_CONNIE
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_SAILOR_KENT
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_BIRD_KEEPER_DENIS
	iffalse_jumpopenedtext .IntroText
	checkevent EVENT_BEAT_SAILOR_ERNEST
	iffalse_jumpopenedtext .IntroText
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked OLIVINELIGHTHOUSE3F_COOLTRAINER_F
	loadtrainer BATTLE_GIRL, EMY
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BATTLE_GIRL_EMY
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem PROTECT_PADS
	iffalse_endtext
	setevent EVENT_GOT_PROTECT_PADS_FROM_LIGHTHOUSE_LEADER
	jumpthisopenedtext

.AfterText2:
	ctxt "One of the Elite"
	line "Four, Bruno, is a"
	cont "fighter like me."

	para "To become as"
	line "strong as him--"
	cont "that's my aim."
	done

.IntroText:
	ctxt "As a Battle Girl,"
	line "I train intensely"
	cont "every day."

	para "There's something"
	line "intense about you."

	para "Can you beat all"
	line "the trainers in"
	cont "this Lighthouse?"

	para "If you can, then"
	line "I will battle you."
	done

.QuestionText:
	ctxt "So you've bested"
	line "this entire tower?"

	para "Then you have one"
	line "opponent left--"
	cont "Chuck's own stu-"
	cont "dent--me!"

	para "Ready to spar?"
	done

.RefusedText:
	ctxt "Back to training"
	line "on my own…"
	done

.SeenText:
	ctxt "From behind my"
	line "Protect Pads, I"
	cont "attack! Ki-yaah!"
	done

.BeatenText:
	ctxt "You broke through"
	line "my defense!"
	done

.AfterText1:
	ctxt "Your team is"
	line "formidable!"

	para "But you can become"
	line "even stronger."

	para "These Protect Pads"
	line "will let you make"

	para "contact with your"
	line "opponent without"
	cont "being harmed."
	done

TrainerBird_keeperTheo:
	trainer BIRD_KEEPER, THEO, EVENT_BEAT_BIRD_KEEPER_THEO, Bird_keeperTheoSeenText, Bird_keeperTheoBeatenText, 0, Bird_keeperTheoScript

Bird_keeperTheoScript:
	endifjustbattled
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer Bird_keeperTheoFinalText
	jumptextfaceplayer BirdKeeperTheoAfterBattleText

GenericTrainerGentlemanPreston:
	generictrainer GENTLEMAN, PRESTON, EVENT_BEAT_GENTLEMAN_PRESTON, GentlemanPrestonSeenText, GentlemanPrestonBeatenText

	ctxt "Jasmine used to"
	line "use Rock #mon"
	cont "like Onix."
	done

GenericTrainerSailorTerrell:
	generictrainer SAILOR, TERRELL, EVENT_BEAT_SAILOR_TERRELL, SailorTerrellSeenText, SailorTerrellBeatenText

	ctxt "Every time I come"
	line "back to Olivine, I"
	cont "visit the Gym."

	para "The Gym Leader's"
	line "#mon type has"

	para "changed without me"
	line "noticing."
	done

Bird_keeperTheoSeenText:
	ctxt "Why are you here?"
	line "Are you just going"

	para "to gawk? I suggest"
	line "that you leave!"
	done

Bird_keeperTheoBeatenText:
	ctxt "You really are"
	line "concerned…"
	done

BirdKeeperTheoAfterBattleText:
	ctxt "How the heck do"
	line "you go up?"

	para "I want to visit"
	line "the sick #mon,"

	para "but I can't get up"
	line "there…"
	done

Bird_keeperTheoFinalText:
	ctxt "How the heck do"
	line "you go up?"

	para "I heard the sick"
	line "#mon is better"
	cont "now, but I can't"
	cont "get up there…"
	done

SailorTerrellSeenText:
	ctxt "Sailors are both"
	line "kind and strong."
	cont "How about you?"
	done

SailorTerrellBeatenText:
	ctxt "You are both kind"
	line "and strong…"
	done

GentlemanPrestonSeenText:
	ctxt "I travel the world"
	line "to train my #-"
	cont "mon. I wish to"
	cont "battle with you."
	done

GentlemanPrestonBeatenText:
	ctxt "…sigh… I must"
	line "train some more…"
	done

