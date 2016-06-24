const_value set 2
	const GOLDENRODPOKECOMCENTER1F_NURSE
	const GOLDENRODPOKECOMCENTER1F_GAMEBOY_KID
	const GOLDENRODPOKECOMCENTER1F_LASS1
	const GOLDENRODPOKECOMCENTER1F_POKEFAN_F
	const GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	const GOLDENRODPOKECOMCENTER1F_SUPER_NERD
	const GOLDENRODPOKECOMCENTER1F_YOUNGSTER
	const GOLDENRODPOKECOMCENTER1F_TEACHER
	const GOLDENRODPOKECOMCENTER1F_ROCKER
	const GOLDENRODPOKECOMCENTER1F_GRAMPS
	const GOLDENRODPOKECOMCENTER1F_LASS2
	const GOLDENRODPOKECOMCENTER1F_SCIENTIST1
	const GOLDENRODPOKECOMCENTER1F_SCIENTIST2
	const GOLDENRODPOKECOMCENTER1F_SCIENTIST3


GoldenrodPokeComCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x60f91:
	setevent EVENT_WELCOMING_TO_POKECOM_CENTER
	jumpstd pokecenternurse

GameboyKidScript_0x6101e:
	jumptextfaceplayer UnknownText_0x62105

UnknownText_0x62105:
	text "The Colosseum"
	line "upstairs is for"
	cont "link battles."

	para "Battle records are"
	line "posted on the"

	para "wall, so I can't"
	line "afford to lose."
	done

Lass1Script_0x61021:
	jumptextfaceplayer UnknownText_0x62260

UnknownText_0x62260:
	text "A higher level"
	line "#mon doesn't"
	cont "always win."

	para "After all, it may"
	line "have a type dis-"
	cont "advantage."

	para "I don't think"
	line "there is a single"

	para "#mon that is"
	line "the toughest."
	done

PokefanFScript_0x61024:
	faceplayer
	opentext
	writetext UnknownText_0x623fb
	waitbutton
	writetext UnknownText_0x6248c
	yesorno
	iffalse UnknownScript_0x6104b
	takeitem EON_MAIL
	iffalse UnknownScript_0x6104b
	writetext UnknownText_0x62549
	waitbutton
	writetext UnknownText_0x624a4
	waitbutton
	verbosegiveitem REVIVE
	iffalse UnknownScript_0x61051
	writetext UnknownText_0x624e9
	waitbutton
	closetext
	end

UnknownScript_0x6104b:
	writetext UnknownText_0x62509
	waitbutton
	closetext
	end

UnknownScript_0x61051:
	giveitem EON_MAIL
	writetext UnknownText_0x6252a
	waitbutton
	closetext
	end

UnknownText_0x623fb:
	text "Oh my, your bag"
	line "looks so heavy!"

	para "Oh! Do you happen"
	line "to have something"
	cont "named Eon Mail?"

	para "My daughter is"
	line "after one."

	para "You can part with"
	line "one, can't you?"
	done

UnknownText_0x6248c:
	text "Give away an Eon"
	line "Mail?"
	done

UnknownText_0x624a4:
	text "Oh, that's great!"
	line "Thank you, honey!"

	para "Here, this is for"
	line "you in return!"
	done

UnknownText_0x624e9:
	text "My daughter will"
	line "be delighted!"
	done

UnknownText_0x62509:
	text "Oh? You don't have"
	line "one? Too bad."
	done

UnknownText_0x6252a:
	text "Oh… Well, another"
	line "time, then."
	done

UnknownText_0x62549:
	text "<PLAYER> gave away"
	line "the Eon Mail."
	done

WonderTradeReceptionistScript:
	opentext
	writetext WonderTradeIntroText
	waitbutton
	wonder_trade
	writetext WonderTradeGoodbyeText
	waitbutton
	closetext
	end

WonderTradeIntroText:
	text "Hello! Welcome to"
	line "#Com Center"
	cont "Wonder Trade Hub."

	para "You can trade"
	line "#mon with other"
	cont "people far away."

;	text "With Wonder Trade,"
;	line "you can quickly"
;	cont "and easily trade"
;
;	para "your #mon with"
;	line "anyone from anywh-"
;	cont "ere in the world!"

	done

WonderTradeGoodbyeText:
	text "We hope to see you"
	line "again."
	done

InfoSignScript:
	jumptext UnknownText_0x62370

UnknownText_0x62370:
	text "#Com Center"
	line "1F Information"

	para "Left:"
	line "Administration"

	para "Center:"
	line "Wonder Trade Hub"

	para "Right:"
	line "#mon News"
	done

NewsMachineScript:
	jumptext UnknownText_0x623c7

UnknownText_0x623c7:
	text "It's a #mon"
	line "News Machine!"

	para "It's not in"
	line "operation yet…"
	done

; unused
UnknownText_0x619db:
	text "It's a #mon"
	line "News Machine."
	done

; unused
UnknownText_0x61b7c:
	text "Would you like to"
	line "get the News?"
	done

; unused
UnknownText_0x61b9d:
	text "Reading the latest"
	line "News… Please wait."
	done

; unused
UnknownText_0x61bc4:
	text "There is no old"
	line "News…"
	done

; unused
UnknownText_0x61bdb:
	text "The News data is"
	line "corrupted."

	para "Please download"
	line "the News again."
	done

; unused
UnknownText_0x61c18:
	text "We're making"
	line "preparations."

	para "Please come back"
	line "later."
	done

; unused
UnknownText_0x61c4b:
	text "We will Save your"
	line "progress before"

	para "starting the News"
	line "Machine."
	done

; unused
UnknownText_0x61a11:
	text "#mon News is"
	line "news compiled from"

	para "the Save files of"
	line "#mon trainers."

	para "When reading the"
	line "News, your Save"

	para "file may be sent"
	line "out."

	para "The Save file data"
	line "will contain your"

	para "adventure log and"
	line "mobile profile."

	para "Your phone number"
	line "will not be sent."

	para "The contents of"
	line "the News will vary"

	para "depending on the"
	line "Save files sent by"

	para "you and the other"
	line "#mon trainers."

	para "You might even be"
	line "in the News!"
	done

SuperNerdScript:
	jumptextfaceplayer UnknownText_0x61c89

UnknownText_0x61c89:
	text "Whoa, this #mon"
	line "Center is huge."

	para "They just built"
	line "this place. They"

	para "installed lots of"
	line "new machines too."
	done

Lass2Script:
	jumptextfaceplayer UnknownText_0x61cef

; unused
UnknownText_0x61dfd:
	text "They said you can"
	line "trade #mon with"

	para "total strangers up"
	line "here."

	para "But they're still"
	line "adjusting things."
	done

UnknownText_0x61cef:
	text "I thought up a fun"
	line "new thing for the"
	cont "Wonder Trade Hub!"

	para "I make a Pidgey"
	line "hold Mail, then"

	para "put it up for"
	line "trade for another"
	cont "one!"

	para "If everyone did"
	line "that, Mail could"

	para "be traded with all"
	line "sorts of people!"

	para "I call it Pidgey"
	line "Mail!"

	para "If it becomes"
	line "popular, I might"

	para "make lots of new"
	line "friends!"
	done

YoungsterScript:
	jumptextfaceplayer UnknownText_0x61efa

UnknownText_0x61efa:
	text "What is the News"
	line "Machine?"

	para "Does it get news"
	line "from a wider area"
	cont "than the radio?"
	done

; unused
UnknownText_0x6202c:
	text "My friend was in"
	line "the News a while"

	para "back. I was really"
	line "surprised!"
	done

; unused
UnknownText_0x6206d:
	text "I get anxious if I"
	line "don't check out"
	cont "the latest News!"
	done

TeacherScript:
	jumptextfaceplayer UnknownText_0x61e5c

; unused
UnknownText_0x61f48:
	text "The #Com Center"
	line "will link with all"

	para "#mon Centers in"
	line "a wireless net."

	para "That must mean"
	line "I'll be able to"

	para "link with all"
	line "sorts of people."
	done

UnknownText_0x61e5c:
	text "Some girl I don't"
	line "know sent me her"

	para "Hoppip."
	line "You should trade"

	para "for a #mon that"
	line "you want."
	done

; unused
UnknownText_0x61eb2:
	text "I received a"
	line "female Hoppip, but"
	cont "its named Stanley!"

	para "That's my dad's"
	line "name!"
	done

RockerScript:
	jumptextfaceplayer UnknownText_0x61fc9

UnknownText_0x61fc9:
	text "The machines here"
	line "can't all be used"
	cont "yet."

	para "Still, it's nice"
	line "coming to a trendy"

	para "place before other"
	line "people."
	done

; unused
UnknownText_0x620a1:
	text "If I get in the"
	line "News and become"

	para "famous, I bet I'll"
	line "be adored."

	para "I wonder how I"
	line "could get in the"
	cont "News?"
	done

GrampsScript:
	jumptextfaceplayer UnknownText_0x62222

; unused
UnknownText_0x62173:
	text "I came over here"
	line "when I got word"

	para "that Goldenrod's"
	line "#mon Center has"

	para "new machines that"
	line "no one's ever seen"
	cont "before."

	para "But it looks like"
	line "they're still busy"

	para "with all their"
	line "preparations…"
	done

UnknownText_0x62222:
	text "Just seeing all"
	line "these new things"

	para "here makes me feel"
	line "younger!"
	done

GoldenrodPokeCenter1F_GSBallTriggerLeft:
	writebyte BATTLETOWERACTION_CHECKMOBILEEVENT
	special BattleTowerAction
	if_equal MOBILE_EVENT_OBJECT_GS_BALL, .gsball
	end

; unused
.gsball
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .cancel
	playsound SFX_EXIT_BUILDING
	moveperson GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, $0, $7
	disappear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	playmusic MUSIC_SHOW_ME_AROUND
	applymovement GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, MovementData_0x6105a
	spriteface PLAYER, UP
	opentext
	writetext UnknownText_0x622f0
	waitbutton
	verbosegiveitem GS_BALL
	setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	writetext UnknownText_0x62359
	waitbutton
	closetext
	applymovement GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, MovementData_0x61060
	special RestartMapMusic
	disappear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	playsound SFX_EXIT_BUILDING
.cancel
	end

GoldenrodPokeCenter1F_GSBallTriggerRight:
	writebyte BATTLETOWERACTION_CHECKMOBILEEVENT
	special BattleTowerAction
	if_equal MOBILE_EVENT_OBJECT_GS_BALL, .gsball
	end

; unused
.gsball
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	iftrue .cancel
	playsound SFX_EXIT_BUILDING
	moveperson GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, $0, $7
	disappear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	playmusic MUSIC_SHOW_ME_AROUND
	applymovement GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, MovementData_0x61065
	spriteface PLAYER, UP
	opentext
	writetext UnknownText_0x622f0
	waitbutton
	verbosegiveitem GS_BALL
	setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	writetext UnknownText_0x62359
	waitbutton
	closetext
	applymovement GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST, MovementData_0x6106c
	special RestartMapMusic
	disappear GOLDENRODPOKECOMCENTER1F_LINK_RECEPTIONIST
	playsound SFX_EXIT_BUILDING
.cancel
	end

; unused
MovementData_0x6105a:
	step_up
	step_right
	step_right
	step_right
	turn_head_down
	step_end

; unused
MovementData_0x61060:
	step_left
	step_left
	step_left
	step_down
	step_end

; unused
MovementData_0x61065:
	step_up
	step_right
	step_right
	step_right
	step_right
	turn_head_down
	step_end

; unused
MovementData_0x6106c:
	step_left
	step_left
	step_left
	step_left
	step_down
	step_end

; unused
UnknownText_0x622f0:
	text "<PLAYER>, isn't it?"

	para "Congratulations!"

	para "As a special deal,"
	line "a GS Ball has been"
	cont "sent just for you!"

	para "Please accept it!"
	done

; unused
UnknownText_0x62359:
	text "Please do come"
	line "again!"
	done


ScientistScript_0x625d1:
	jumptextfaceplayer UnknownText_0x62674

ScientistScript_0x625d4:
	jumptextfaceplayer UnknownText_0x626f9

ScientistScript_0x625d7:
	jumptextfaceplayer UnknownText_0x62795

Computer0Script:
	opentext
	writetext UnknownText_0x627ee
	waitbutton
UnknownScript_0x625df:
	reloadmappart
	loadmenudata MenuDataHeader_0x62602
	verticalmenu
	closewindow
	if_equal $1, UnknownScript_0x625f0
	if_equal $2, UnknownScript_0x625f8
	jump UnknownScript_0x62600

UnknownScript_0x625f0:
	opentext
	writetext UnknownText_0x62828
	waitbutton
	jump UnknownScript_0x625df

UnknownScript_0x625f8:
	opentext
	writetext UnknownText_0x628f4
	waitbutton
	jump UnknownScript_0x625df

UnknownScript_0x62600:
	closetext
	end


MenuDataHeader_0x62602:
	db $40 ; flags
	db 00, 00 ; start coords
	db 08, 15 ; end coords
	dw MenuData2_0x6260a
	db 1 ; default option

MenuData2_0x6260a:
	db $80 ; flags
	db 3 ; items
	db "#Com Club@"
	db "Mobile Center@"
	db "Quit@"


Computer1Script:
	opentext
	writetext UnknownText_0x62989
	waitbutton
UnknownScript_0x62629:
	reloadmappart
	loadmenudata MenuDataHeader_0x6264c
	verticalmenu
	closewindow
	if_equal $1, UnknownScript_0x6263a
	if_equal $2, UnknownScript_0x62642
	jump UnknownScript_0x6264a

UnknownScript_0x6263a:
	opentext
	writetext UnknownText_0x629ae
	waitbutton
	jump UnknownScript_0x62629

UnknownScript_0x62642:
	opentext
	writetext UnknownText_0x62a5a
	waitbutton
	jump UnknownScript_0x62629

UnknownScript_0x6264a:
	closetext
	end


MenuDataHeader_0x6264c:
	db $40 ; flags
	db 00, 00 ; start coords
	db 08, 15 ; end coords
	dw MenuData2_0x62654
	db 1 ; default option

MenuData2_0x62654:
	db $80 ; flags
	db 3 ; items
	db "Instructions@"
	db "Troubleshoot@"
	db "Quit@"


Computer2Script:
	jumptext UnknownText_0x62b26

UnknownText_0x62674:
	text "#Com Center and"
	line "Mobile Center were"

	para "built to satisfy"
	line "demands for trades"

	para "and battles with"
	line "trainers far away"

	para "and with total"
	line "strangers."
	done

UnknownText_0x626f9:
	text "When you linked"
	line "with someone by"

	para "mobile phone for"
	line "the first time,"

	para "weren't you"
	line "impressed?"

	para "When my first try"
	line "worked, I was so"

	para "impressed that I"
	line "got the shakes!"
	done

UnknownText_0x62795:
	text "They were able to"
	line "build this huge"

	para "facility thanks to"
	line "advances in wire-"
	cont "less technology."
	done

UnknownText_0x627ee:
	text "It's a notice"
	line "about where Mobile"

	para "Adapters are to be"
	line "used…"
	done

UnknownText_0x62828:
	text "There's a #Com"
	line "Club upstairs in"

	para "any #mon"
	line "Center."

	para "There, you can"
	line "battle or trade"

	para "with a friend far"
	line "away by using a"
	cont "Mobile Adapter."

	para "To link up, your"
	line "friend must have"

	para "the same kind of"
	line "Mobile Adapter as"
	cont "you."
	done

UnknownText_0x628f4:
	text "To use the Trade"
	line "Corner or read the"

	para "#mon News, you"
	line "need to phone the"
	cont "Mobile Center."

	para "You must register"
	line "at the Mobile"

	para "Center before"
	line "connecting there."
	done

UnknownText_0x62989:
	text "It's a notice"
	line "about using the"
	cont "phone…"
	done

UnknownText_0x629ae:
	text "Please ensure that"
	line "your phone and"

	para "Mobile Adapter are"
	line "properly linked."

	para "Please make sure"
	line "the wireless phone"
	cont "signal is strong."

	para "Don't touch or"
	line "hang up the phone"
	cont "while linking."
	done

UnknownText_0x62a5a:
	text "If the server is"
	line "busy, it may not"

	para "be possible to log"
	line "on."

	para "If so, please call"
	line "back later."

	para "If you are unable"
	line "to log on or don't"

	para "understand the"
	line "error messages,"

	para "call a support"
	line "center or read the"
	cont "instructions."
	done

UnknownText_0x62b26:
	text "The Administration"
	line "Office received an"
	cont "e-mail. It says…"

	para "<......> <......> <......>"

	para "To the #Com"
	line "Center staff…"

	para "Wireless communi-"
	line "cation has enabled"

	para "#mon trainers"
	line "to interact across"

	para "the nation. Let's"
	line "keep working for"

	para "the day when all"
	line "the trainers in"

	para "the world can link"
	line "without barriers!"

	para "<......> <......> <......>"
	done

GoldenrodPokeComCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $f, $6, 15, GOLDENROD_CITY
	warp_def $f, $7, 15, GOLDENROD_CITY
	warp_def $6, $0, 5, GOLDENROD_POKECOM_CENTER_1F
	warp_def $f, $0, 1, POKECENTER_2F
	warp_def $1f, $0, 3, GOLDENROD_POKECOM_CENTER_1F
	warp_def $1f, $1, 3, GOLDENROD_POKECOM_CENTER_1F

.XYTriggers:
	db 2
	xy_trigger 0, $f, $6, $0, GoldenrodPokeCenter1F_GSBallTriggerLeft, $0, $0
	xy_trigger 0, $f, $7, $0, GoldenrodPokeCenter1F_GSBallTriggerRight, $0, $0


.Signposts:
	db 19
	signpost 26, 6, SIGNPOST_UP, Computer0Script
	signpost 28, 6, SIGNPOST_UP, Computer1Script
	signpost 26, 3, SIGNPOST_UP, Computer2Script
	signpost 9, 2, SIGNPOST_UP, InfoSignScript
	signpost 5, 24, SIGNPOST_RIGHT, NewsMachineScript
	signpost 6, 24, SIGNPOST_RIGHT, NewsMachineScript
	signpost 7, 24, SIGNPOST_RIGHT, NewsMachineScript
	signpost 9, 24, SIGNPOST_RIGHT, NewsMachineScript
	signpost 10, 24, SIGNPOST_RIGHT, NewsMachineScript
	signpost 11, 25, SIGNPOST_UP, NewsMachineScript
	signpost 11, 26, SIGNPOST_UP, NewsMachineScript
	signpost 11, 27, SIGNPOST_UP, NewsMachineScript
	signpost 11, 28, SIGNPOST_UP, NewsMachineScript
	signpost 5, 29, SIGNPOST_LEFT, NewsMachineScript
	signpost 6, 29, SIGNPOST_LEFT, NewsMachineScript
	signpost 7, 29, SIGNPOST_LEFT, NewsMachineScript
	signpost 8, 29, SIGNPOST_LEFT, NewsMachineScript
	signpost 9, 29, SIGNPOST_LEFT, NewsMachineScript
	signpost 10, 29, SIGNPOST_LEFT, NewsMachineScript

.PersonEvents:
	db 14
	person_event SPRITE_NURSE, 7, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x60f91, -1
	person_event SPRITE_GAMEBOY_KID, 12, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x6101e, -1
	person_event SPRITE_LASS, 11, 3, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Lass1Script_0x61021, -1
	person_event SPRITE_POKEFAN_F, 14, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PokefanFScript_0x61024, -1
	person_event SPRITE_LINK_RECEPTIONIST, 8, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, WonderTradeReceptionistScript, -1
	person_event SPRITE_SUPER_NERD, 13, 8, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SuperNerdScript, -1
	person_event SPRITE_YOUNGSTER, 8, 23, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, YoungsterScript, -1
	person_event SPRITE_TEACHER, 13, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TeacherScript, -1
	person_event SPRITE_ROCKER, 6, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, RockerScript, -1
	person_event SPRITE_GRAMPS, 14, 19, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrampsScript, -1
	person_event SPRITE_LASS, 9, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Lass2Script, -1
	person_event SPRITE_SCIENTIST, 28, 4, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ScientistScript_0x625d1, -1
	person_event SPRITE_SCIENTIST, 27, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ScientistScript_0x625d4, -1
	person_event SPRITE_SCIENTIST, 29, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ScientistScript_0x625d7, -1
