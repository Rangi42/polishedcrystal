specialcall: MACRO
; condition, contact, script
	dw \1
	db \2
	dba \3
ENDM

SpecialPhoneCallList:
; entries correspond to SPECIALCALL_* constants
	table_width SPECIALCALL_SIZE, SpecialPhoneCallList
	specialcall SpecialCallOnlyWhenOutside, PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_POKERUS
	specialcall SpecialCallOnlyWhenOutside, PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_ROBBED
	specialcall SpecialCallOnlyWhenOutside, PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_ASSISTANT
	specialcall SpecialCallOnlyWhenOutside, PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_WEIRDBROADCAST
	specialcall SpecialCallWhereverYouAre,  PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_SSTICKET
	specialcall SpecialCallWhereverYouAre,  PHONE_OAK,  BikeShopPhoneScript   ; SPECIALCALL_BIKESHOP
	specialcall SpecialCallWhereverYouAre,  PHONE_MOM,  MomPhoneLectureScript ; SPECIALCALL_WORRIED
	specialcall SpecialCallOnlyWhenOutside, PHONE_ELM,  ElmPhoneScript2       ; SPECIALCALL_MASTERBALL
	specialcall SpecialCallOnlyWhenOutside, PHONE_LYRA, LyraPhoneScript2      ; SPECIALCALL_YELLOWFOREST
	specialcall SpecialCallOnlyWhenOutside, PHONE_LYRA, LyraPhoneScript2      ; SPECIALCALL_FIRSTBADGE
	specialcall SpecialCallOnlyWhenOutside, PHONE_BILL, BillPhoneScript2      ; SPECIALCALL_SECONDBADGE
	specialcall SpecialCallOnlyWhenOutside, PHONE_LYRA, LyraPhoneScript2      ; SPECIALCALL_LYRASEGG
	assert_table_length NUM_SPECIALCALLS
