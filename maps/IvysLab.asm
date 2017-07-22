const_value set 2
	const IVYSLAB_IVY
	const IVYSLAB_COOLTRAINER_F
	const IVYSLAB_NIDORINO

IvysLab_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ProfIvyScript:
	faceplayer
	opentext
	checkevent EVENT_HEALED_NIDORINO
	iftrue .GetItem
	writetext .RequestText
	yesorno
	iffalse .NoBerry
	checkitem FIGY_BERRY
	iffalse .NoBerry
	takeitem FIGY_BERRY
	checkitem FIGY_BERRY
	iffalse .Return1
	takeitem FIGY_BERRY
	checkitem FIGY_BERRY
	iffalse .Return2
	takeitem FIGY_BERRY
	writetext .OkayText
	waitbutton
	closetext
	spriteface IVYSLAB_IVY, RIGHT
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
	iffalse .Done
	setevent EVENT_GOT_MOON_STONE_FROM_IVY
.GotItem:
	checkevent EVENT_BEAT_PROF_IVY
	iftrue .Beaten
	writetext .ChallengeText
	yesorno
	iffalse .NoBattle
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked IVYSLAB_IVY
	loadtrainer PROF_IVY, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PROF_IVY
	opentext
.Beaten:
	writetext .AfterText
	waitbutton
.Done:
	closetext
	end

.Return2:
	giveitem FIGY_BERRY
.Return1:
	giveitem FIGY_BERRY
.NoBerry:
	writetext .NoBerryText
	waitbutton
	closetext
	end

.NoBattle:
	writetext .NoText
	waitbutton
	closetext
	end

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
	line "find three Figy"
	cont "Berries for it?"
	done

.NoBerryText:
	text "Ivy: I under-"
	line "stand…"

	para "You don't have"
	line "three Figy Berries"
	cont "to spare."
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
	faceplayer
	opentext
	checkevent EVENT_HEALED_NIDORINO
	iftrue .HealedNidorino
	writetext .Text1
	waitbutton
	closetext
	end

.HealedNidorino:
	writetext .Text2
	waitbutton
	closetext
	end

.Text1:
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
	opentext
	checkevent EVENT_HEALED_NIDORINO
	iftrue .Healed
	writetext .WeakCry
	writebyte NIDORINO
	special PlaySlowCry
	buttonsound
	writetext .WeakText
	waitbutton
	closetext
	end

.Healed:
	writetext IvysLabNidorinoText
	cry NIDORINO
	waitbutton
	closetext
	end

.WeakCry:
	text "Nidorino: Gyun…"
	done

.WeakText:
	text "Its cry is weak…"
	done

IvysLabNidorinoText:
	text "Nidorino: Gyun!"
	done

IvysLabHealingMachine:
	opentext
	writetext .Text
	yesorno
	iftrue .HealParty
	closetext
	end

.HealParty:
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 1 ; Machine is in Elm's Lab
	special HealMachineAnim
	pause 30
	special RestoreMusic
	closetext
	end

.Text:
	text "Would you like to"
	line "heal your #mon?"
	done

IvysLabWindow:
	jumptext .Text

.Text:
	text "The window's open."

	para "An ocean breeze"
	line "is blowing in."
	done

PokemonJournalProfIvyScript:
	setflag ENGINE_READ_PROF_IVY_JOURNAL
	jumptext .Text

.Text:
	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Ivy!"

	para "Philena Ivy worked"
	line "with Brock of Pew-"
	cont "ter City to study"

	para "a shiny Onix's"
	line "crystalline body."
	done

IvysLabBookshelf:
	jumpstd difficultbookshelf

IvysLab_MapEventHeader:
.Warps:
	db 2
	warp_def $b, $4, 1, VALENCIA_ISLAND
	warp_def $b, $5, 1, VALENCIA_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 14
	signpost 1, 2, SIGNPOST_READ, IvysLabHealingMachine
	signpost 0, 5, SIGNPOST_READ, IvysLabWindow
	signpost 1, 6, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 7, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 8, SIGNPOST_READ, IvysLabBookshelf
	signpost 1, 9, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 0, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 1, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 2, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 3, SIGNPOST_READ, PokemonJournalProfIvyScript
	signpost 7, 6, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 7, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 8, SIGNPOST_READ, IvysLabBookshelf
	signpost 7, 9, SIGNPOST_READ, IvysLabBookshelf

.PersonEvents:
	db 3
	person_event SPRITE_IVY, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ProfIvyScript, -1
	person_event SPRITE_COOLTRAINER_F, 9, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, IvysLabHopeScript, -1
	person_event SPRITE_NIDORINO, 2, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, IvysLabNidorinoScript, -1
