IvysLab_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4, 11, VALENCIA_ISLAND, 1
	warp_event  5, 11, VALENCIA_ISLAND, 1

	db 0 ; coord events

	db 14 ; bg events
	bg_event  5,  0, SIGNPOST_JUMPTEXT, IvysLabWindowText
	bg_event  2,  1, SIGNPOST_READ, IvysLabHealingMachine
	bg_event  6,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  8,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  9,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  0,  7, SIGNPOST_READ, PokemonJournalProfIvyScript
	bg_event  1,  7, SIGNPOST_READ, PokemonJournalProfIvyScript
	bg_event  2,  7, SIGNPOST_READ, PokemonJournalProfIvyScript
	bg_event  3,  7, SIGNPOST_READ, PokemonJournalProfIvyScript
	bg_event  6,  7, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  7,  7, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  8,  7, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  9,  7, SIGNPOST_JUMPSTD, difficultbookshelf

	db 3 ; object events
	object_event  4,  3, SPRITE_IVY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ProfIvyScript, -1
	object_event  5,  3, SPRITE_NIDORINO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, IvysLabNidorinoScript, -1
	object_event  2,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, IvysLabHopeScript, -1

	const_def 1 ; object constants
	const IVYSLAB_IVY
	const IVYSLAB_NIDORINO

ProfIvyScript:
	faceplayer
	opentext
	checkevent EVENT_HEALED_NIDORINO
	iftrue .GetItem
	writetext .RequestText
	yesorno
	iffalse_jumpopenedtext .NoBerryText
	checkitem LIECHI_BERRY
	iffalse_jumpopenedtext .NoBerryText
	takeitem LIECHI_BERRY
	checkitem LIECHI_BERRY
	iffalse .Return1
	takeitem LIECHI_BERRY
	checkitem LIECHI_BERRY
	iffalse .Return2
	takeitem LIECHI_BERRY
	writetext .OkayText
	waitbutton
	closetext
	turnobject IVYSLAB_IVY, RIGHT
	pause 15
	playmusic MUSIC_HEAL
	pause 60
	special RestartMapMusic
	pause 15
	opentext
	writetext IvysLabNidorinoText
	cry NIDORINO
	waitsfx
	closetext
	showemote EMOTE_HAPPY, IVYSLAB_NIDORINO, 15
	setevent EVENT_HEALED_NIDORINO
	setlasttalked IVYSLAB_IVY
	faceplayer
	opentext
.GetItem
	checkevent EVENT_GOT_MOON_STONE_FROM_IVY
	iftrue .GotItem
	writetext .ThanksText
	buttonsound
	verbosegiveitem MOON_STONE
	iffalse_endtext
	setevent EVENT_GOT_MOON_STONE_FROM_IVY
.GotItem:
	checkevent EVENT_BEAT_PROF_IVY
	iftrue_jumpopenedtext .AfterText
	writetext .ChallengeText
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked IVYSLAB_IVY
	loadtrainer PROF_IVY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PROF_IVY
	jumptext .AfterText

.Return2:
	giveitem LIECHI_BERRY
.Return1:
	giveitem LIECHI_BERRY
	thisopenedtext

.NoBerryText:
	text "Ivy: I under-"
	line "stand…"

	para "You don't have"
	line "three Liechi"
	cont "Berries to spare."
	done

.RequestText:
	text "Ivy: Hello again,"
	line "<PLAYER>!"

	para "Can I ask you to"
	line "to do me a favor?"

	para "This Nidorino"
	line "is sick, and my"

	para "Lum Berries aren't"
	line "helping it."

	para "Can you please"
	line "find three Liechi"
	cont "Berries for it?"
	done

.OkayText:
	text "Ivy: Perfect!"
	line "Thanks, <PLAYER>!"

	para "Let's see if this"
	line "helps Nidorino…"
	done

.ThanksText:
	text "Ivy: Thank you,"
	line "<PLAYER>!"

	para "Nidorino looks"
	line "much healthier!"

	para "Please take this"
	line "for your trouble."
	done

.ChallengeText:
	text "Ivy: I could use a"
	line "break from work."

	para "How about a quick"
	line "battle?"
	done

.NoText:
	text "Ah well, I'll just"
	line "keep on with my"
	cont "research."
	done

.SeenText:
	text "Professor versus"
	line "Champion--let's go!"
	done

.BeatenText:
	text "No surprises"
	line "here!"
	done

.AfterText:
	text "Ivy: That was an"
	line "exhilarating"
	cont "battle!"
	done

IvysLabHopeScript:
	checkevent EVENT_HEALED_NIDORINO
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "Hope: Prof.Ivy"
	line "takes care of the"

	para "#mon on this"
	line "island."

	para "Right now she's"
	line "tending to a sick"
	cont "Nidorino."
	done

.Text2:
	text "Hope: Thanks for"
	line "helping out with"
	cont "that Nidorino!"
	done

IvysLabNidorinoScript:
	checkevent EVENT_HEALED_NIDORINO
	iftrue .Healed
	opentext
	writetext .WeakCry
	writebyte NIDORINO
	special PlaySlowCry
	buttonsound
	thisopenedtext

	text "Its cry is weak…"
	done

.WeakCry:
	text "Nidorino: Gyun…"
	done

.Healed:
	showcrytext IvysLabNidorinoText, NIDORINO
	end

IvysLabNidorinoText:
	text "Nidorino: Gyun!"
	done

IvysLabWindowText:
	text "The window's open."

	para "An ocean breeze"
	line "is blowing in."
	done

IvysLabHealingMachine:
	opentext
	writetext .Text
	yesorno
	iftrue .HealParty
	endtext

.HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	endtext

.Text:
	text "Would you like to"
	line "heal your #mon?"
	done

PokemonJournalProfIvyScript:
	setflag ENGINE_READ_PROF_IVY_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Ivy!"

	para "Philena Ivy worked"
	line "with Brock of Pew-"
	cont "ter City to study"

	para "a shiny Onix's"
	line "crystalline body."
	done
