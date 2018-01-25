musicheader: MACRO
	; number of tracks, track idx, address
	dbw ((\1 - 1) << 6) + (\2 - 1), \3
ENDM

note: MACRO
	dn (\1), (\2) - 1
ENDM

sound: MACRO
	note \1, \2
	db \3 ; intensity
	dw \4 ; frequency
ENDM

noise: MACRO
	note \1, \2 ; duration
	db \3 ; intensity
	db \4 ; frequency
ENDM

	enum_start $d8
	enum notetype_cmd
octave: MACRO
	db notetype_cmd - (\1)
ENDM

notetype: MACRO
	db notetype_cmd
	db \1 ; note_length
	if _NARG >= 2
	db \2 ; intensity
	endc
ENDM

	enum pitchoffset_cmd
pitchoffset: MACRO
	db pitchoffset_cmd
	dn \1, \2 - 1 ; octave, key
ENDM

	enum tempo_cmd
tempo: MACRO
	db tempo_cmd
	bigdw \1 ; tempo
ENDM

	enum dutycycle_cmd
dutycycle: MACRO
	db dutycycle_cmd
	db \1 ; duty_cycle
ENDM

	enum intensity_cmd
intensity: MACRO
	db intensity_cmd
	db \1 ; intensity
ENDM

	enum soundinput_cmd
soundinput: MACRO
	db soundinput_cmd
	db \1 ; input
ENDM

	enum sound_duty_cmd
sound_duty: MACRO
	db sound_duty_cmd
	db \1 | (\2 << 2) | (\3 << 4) | (\4 << 6) ; duty sequence
ENDM

	enum togglesfx_cmd
togglesfx: MACRO
	db togglesfx_cmd
ENDM

	enum slidepitchto_cmd
slidepitchto: MACRO
	db slidepitchto_cmd
	db \1 - 1 ; duration
	dn \2, \3 ; octave, pitch
ENDM

	enum vibrato_cmd
vibrato: MACRO
	db vibrato_cmd
	db \1 ; delay
	db \2 ; extent
ENDM

	enum unknownmusic0xe2_cmd
unknownmusic0xe2: MACRO
	db unknownmusic0xe2_cmd
	db \1 ; unknown
ENDM

	enum togglenoise_cmd
togglenoise: MACRO
	db togglenoise_cmd
	db \1 ; id
ENDM

	enum panning_cmd
panning: MACRO
	db panning_cmd
	db \1 ; tracks
ENDM

	enum volume_cmd
volume: MACRO
	db volume_cmd
	db \1 ; volume
ENDM

	enum tone_cmd
tone: MACRO
	db tone_cmd
	bigdw \1 ; tone
ENDM

	enum unknownmusic0xe7_cmd
unknownmusic0xe7: MACRO
	db unknownmusic0xe7_cmd
	db \1 ; unknown
ENDM

	enum unknownmusic0xe8_cmd
unknownmusic0xe8: MACRO
	db unknownmusic0xe8_cmd
	db \1 ; unknown
ENDM

	enum tempo_relative_cmd
tempo_relative: MACRO
	db tempo_relative_cmd
	bigdw \1 ; value
ENDM

	enum restartchannel_cmd
restartchannel: MACRO
	db restartchannel_cmd
	dw \1 ; address
ENDM

	enum newsong_cmd
newsong: MACRO
	db newsong_cmd
	bigdw \1 ; id
ENDM

	enum sfxpriorityon_cmd
sfxpriorityon: MACRO
	db sfxpriorityon_cmd
ENDM

	enum sfxpriorityoff_cmd
sfxpriorityoff: MACRO
	db sfxpriorityoff_cmd
ENDM

	enum unknownmusic0xee_cmd
unknownmusic0xee: MACRO
	db unknownmusic0xee_cmd
	dw \1 ; address
ENDM

	enum stereopanning_cmd
stereopanning: MACRO
	db stereopanning_cmd
	db \1 ; tracks
ENDM

	enum sfxtogglenoise_cmd
sfxtogglenoise: MACRO
	db sfxtogglenoise_cmd
	db \1 ; id
ENDM

	enum music0xf1_cmd
music0xf1: MACRO
	db music0xf1_cmd
ENDM

	enum music0xf2_cmd
music0xf2: MACRO
	db music0xf2_cmd
ENDM

	enum music0xf3_cmd
music0xf3: MACRO
	db music0xf3_cmd
ENDM

	enum music0xf4_cmd
music0xf4: MACRO
	db music0xf4_cmd
ENDM

	enum music0xf5_cmd
music0xf5: MACRO
	db music0xf5_cmd
ENDM

	enum music0xf6_cmd
music0xf6: MACRO
	db music0xf6_cmd
ENDM

	enum music0xf7_cmd
music0xf7: MACRO
	db music0xf7_cmd
ENDM

	enum music0xf8_cmd
music0xf8: MACRO
	db music0xf8_cmd
ENDM

	enum unknownmusic0xf9_cmd
unknownmusic0xf9: MACRO
	db unknownmusic0xf9_cmd
ENDM

	enum setcondition_cmd
setcondition: MACRO
	db setcondition_cmd
	db \1 ; condition
ENDM

	enum jumpif_cmd
jumpif: MACRO
	db jumpif_cmd
	db \1 ; condition
	dw \2 ; address
ENDM

	enum jumpchannel_cmd
jumpchannel: MACRO
	db jumpchannel_cmd
	dw \1 ; address
ENDM

	enum loopchannel_cmd
loopchannel: MACRO
	db loopchannel_cmd
	db \1 ; count
	dw \2 ; address
ENDM

	enum callchannel_cmd
callchannel: MACRO
	db callchannel_cmd
	dw \1 ; address
ENDM

	enum endchannel_cmd
endchannel: MACRO
	db endchannel_cmd
ENDM
