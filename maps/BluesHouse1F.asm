BluesHouse1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BluesHouse1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $2, 2, PALLET_TOWN
	warp_def $7, $3, 2, PALLET_TOWN
	warp_def $0, $7, 1, BLUES_HOUSE_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 5, SIGNPOST_READ, BluesHouse1FTV

.PersonEvents: db 1
	person_event SPRITE_DAISY, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, DaisyScript_0x19b0d0, -1

DaisyScript_0x19b0d0:
	faceplayer
	opentext
	checkcode VAR_HOUR
	if_equal $f, UnknownScript_0x19b0de
	writetext UnknownText_0x19b130
	waitbutton
	closetext
	end

UnknownScript_0x19b0de:
	checkflag ENGINE_TEA_IN_BLUES_HOUSE
	iftrue UnknownScript_0x19b11e
	writetext UnknownText_0x19b1b6
	yesorno
	iffalse UnknownScript_0x19b124
	writetext UnknownText_0x19b244
	waitbutton
	special Special_DaisyMassage
	if_equal 0, UnknownScript_0x19b124
	if_equal 1, UnknownScript_0x19b12a
	setflag ENGINE_TEA_IN_BLUES_HOUSE
	writetext UnknownText_0x19b266
	waitbutton
	closetext
	special FadeOutPalettes
	special SaveMusic
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestoreMusic
	opentext
	writetext UnknownText_0x19b296
	special PlayCurMonCry
	buttonsound
	writetext UnknownText_0x19b2aa
	waitbutton
	closetext
	end

UnknownScript_0x19b11e:
	writetext UnknownText_0x19b2fa
	waitbutton
	closetext
	end

UnknownScript_0x19b124:
	writetext UnknownText_0x19b334
	waitbutton
	closetext
	end

UnknownScript_0x19b12a:
	writetext UnknownText_0x19b377
	waitbutton
	closetext
	end

BluesHouse1FTV:
	checkcode VAR_FACING
	if_not_equal UP, .wrongside
	jumptext BluesHouse1FTVText
.wrongside
	jumpstd tv

UnknownText_0x19b130:
	text "Daisy: Hi! My kid"
	line "brother is the Gym"

	para "Leader in Viridian"
	line "City."

	para "But he goes out"
	line "of town so often,"

	para "it causes problems"
	line "for the trainers."
	done

UnknownText_0x19b1b6:
	text "Daisy: Hi! Good"
	line "timing. I'm about"
	cont "to have some tea."

	para "Would you like to"
	line "join me?"

	para "Oh, your #mon"
	line "are a bit dirty."

	para "Would you like me"
	line "to groom one?"
	done

UnknownText_0x19b244:
	text "Daisy: Which one"
	line "should I groom?"
	done

UnknownText_0x19b266:
	text "Daisy: OK, I'll"
	line "get it looking"
	cont "nice in no time."
	done

UnknownText_0x19b296:
	text_from_ram StringBuffer3
	text " looks"
	line "content."
	done

UnknownText_0x19b2aa:
	text "Daisy: There you"
	line "go! All done."

	para "See? Doesn't it"
	line "look nice?"

	para "It's such a cute"
	line "#mon."
	done

UnknownText_0x19b2fa:
	text "Daisy: I always"
	line "have tea around"

	para "this time. Come"
	line "join me."
	done

UnknownText_0x19b334:
	text "Daisy: You don't"
	line "want to have one"

	para "groomed? OK, we'll"
	line "just have tea."
	done

UnknownText_0x19b377:
	text "Daisy: Oh, sorry."
	line "I honestly can't"
	cont "groom an Egg."
	done

BluesHouse1FTVText:
	text "They have programs"
	line "that aren't shown"
	cont "in Johto…"
	done
