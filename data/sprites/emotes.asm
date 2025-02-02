Emotes:
; entries correspond to EMOTE_* constants
	table_width 2
	farbank "Emote Graphics"
	fardw ShockEmote
	fardw QuestionEmote
	fardw HappyEmote
	fardw SadEmote
	fardw HeartEmote
	fardw BoltEmote
	fardw SleepEmote
	fardw FishEmote
	assert_table_length NUM_EMOTES

EmotePalettes:
; entries correspond to EMOTE_* constants
	table_width 1
	db PAL_OW_EMOTE_BLACK  ; EMOTE_SHOCK
	db PAL_OW_EMOTE_BLACK  ; EMOTE_QUESTION
	db PAL_OW_EMOTE_GREEN  ; EMOTE_HAPPY
	db PAL_OW_EMOTE_PURPLE ; EMOTE_SAD
	db PAL_OW_EMOTE_RED    ; EMOTE_HEART
	db PAL_OW_EMOTE_ORANGE ; EMOTE_BOLT
	db PAL_OW_EMOTE_BLUE   ; EMOTE_SLEEP
	db PAL_OW_EMOTE_BLUE   ; EMOTE_FISH
	assert_table_length NUM_EMOTES
