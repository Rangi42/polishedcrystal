OlivineLighthouse3F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse3F_MapEventHeader:

.Warps: db 9
	warp_def 3, 13, 1, OLIVINE_LIGHTHOUSE_4F
	warp_def 3, 5, 2, OLIVINE_LIGHTHOUSE_2F
	warp_def 5, 9, 4, OLIVINE_LIGHTHOUSE_4F
	warp_def 11, 16, 5, OLIVINE_LIGHTHOUSE_2F
	warp_def 11, 17, 6, OLIVINE_LIGHTHOUSE_2F
	warp_def 9, 16, 5, OLIVINE_LIGHTHOUSE_4F
	warp_def 9, 17, 6, OLIVINE_LIGHTHOUSE_4F
	warp_def 3, 8, 7, OLIVINE_LIGHTHOUSE_4F
	warp_def 3, 9, 8, OLIVINE_LIGHTHOUSE_4F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_COOLTRAINER_F, 14, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OlivineLighthouse3FBattleGirlEmy, -1
	person_event SPRITE_SAILOR, 2, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSailorTerrell, -1
	person_event SPRITE_GENTLEMAN, 5, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerGentlemanPreston, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	person_event SPRITE_YOUNGSTER, 9, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBird_keeperTheo, -1
	itemball_event 2, 8, ETHER, 1, EVENT_OLIVINE_LIGHTHOUSE_3F_ETHER

const_value set 1
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
	buttonsound
	verbosegiveitem PROTECT_PADS
	iffalse_endtext
	setevent EVENT_GOT_PROTECT_PADS_FROM_LIGHTHOUSE_LEADER
	thisopenedtext

.AfterText2:
	text "One of the Elite"
	line "Four, Bruno, is a"
	cont "fighter like me."

	para "To become as"
	line "strong as him--"
	cont "that's my aim."
	done

.IntroText:
	text "As a Battle Girl,"
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
	text "So you've bested"
	line "this entire tower?"

	para "Then you have one"
	line "opponent left--"
	cont "Chuck's own stu-"
	cont "dent--me!"

	para "Ready to spar?"
	done

.RefusedText:
	text "Back to training"
	line "on my own…"
	done

.SeenText:
	text "From behind my"
	line "Protect Pads, I"
	cont "attack! Ki-yaah!"
	done

.BeatenText:
	text "You broke through"
	line "my defense!"
	done

.AfterText1:
	text "Your team is"
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
	trainer EVENT_BEAT_BIRD_KEEPER_THEO, BIRD_KEEPER, THEO, Bird_keeperTheoSeenText, Bird_keeperTheoBeatenText, 0, Bird_keeperTheoScript

Bird_keeperTheoScript:
	end_if_just_battled
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer Bird_keeperTheoFinalText
	jumptextfaceplayer UnknownText_0x5b2df

TrainerGentlemanPreston:
	trainer EVENT_BEAT_GENTLEMAN_PRESTON, GENTLEMAN, PRESTON, GentlemanPrestonSeenText, GentlemanPrestonBeatenText, 0, GentlemanPrestonScript

GentlemanPrestonScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5b457

TrainerSailorTerrell:
	trainer EVENT_BEAT_SAILOR_TERRELL, SAILOR, TERRELL, SailorTerrellSeenText, SailorTerrellBeatenText, 0, SailorTerrellScript

SailorTerrellScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5b384

Bird_keeperTheoSeenText:
	text "Why are you here?"
	line "Are you just going"

	para "to gawk? I suggest"
	line "that you leave!"
	done

Bird_keeperTheoBeatenText:
	text "You really are"
	line "concerned…"
	done

UnknownText_0x5b2df:
	text "How the heck do"
	line "you go up?"

	para "I want to visit"
	line "the sick #mon,"

	para "but I can't get up"
	line "there…"
	done

Bird_keeperTheoFinalText:
	text "How the heck do"
	line "you go up?"

	para "I heard the sick"
	line "#mon is better"
	cont "now, but I can't"
	cont "get up there…"
	done

SailorTerrellSeenText:
	text "Sailors are both"
	line "kind and strong."
	cont "How about you?"
	done

SailorTerrellBeatenText:
	text "You are both kind"
	line "and strong…"
	done

UnknownText_0x5b384:
	text "Every time I come"
	line "back to Olivine, I"
	cont "visit the Gym."

	para "The Gym Leader's"
	line "#mon type has"

	para "changed without me"
	line "noticing."
	done

GentlemanPrestonSeenText:
	text "I travel the world"
	line "to train my #-"
	cont "mon. I wish to"
	cont "battle with you."
	done

GentlemanPrestonBeatenText:
	text "…sigh… I must"
	line "train some more…"
	done

UnknownText_0x5b457:
	text "Jasmine used to"
	line "use Rock #mon"
	cont "like Onix."
	done
