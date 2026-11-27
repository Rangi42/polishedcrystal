; 'text' has started; we are waiting to see if compression will be tried.
DEF _might_compress_text = 0
; 'text' has started being compressible; we are counting to see if compression will save space.
DEF _compressing_text = 0
; Add an "@" terminator to compressed 'text' which uncompressed does not need.
DEF _compression_terminator = 0
; A terminator has stopped compressing text; see if we need to resume trying to compress.
DEF _stopped_compressing_text = 0

; Text commands

MACRO text_start
; Enter text writing mode.
	stop_compressing_text
	db "<START>"
ENDM

MACRO text_ram
; Write text from a RAM address.
	stop_compressing_text
	db "<RAM>"
	dw \1 ; address
ENDM

MACRO text_promptbutton
; Wait for button press; show arrow.
	stop_compressing_text
	db "<WAIT>"
ENDM

MACRO text_asm
; Start interpreting assembly code.
	stop_compressing_text
	db "<ASM>"
ENDM

MACRO text_decimal
; Read bytes from address and print them as a number.
	stop_compressing_text
	db "<NUM>"
	dw \1 ; address
	dn \2, \3 ; bytes, digits
ENDM

MACRO text_pause
; Pause for 30 frames unless A or B is pressed.
	stop_compressing_text
	db "<PAUSE>"
ENDM

MACRO text_sound
; Play a sound effect.
	stop_compressing_text
	db "<SOUND>"
	db \1 ; sfx
ENDM

MACRO text_today
; Print the weekday.
	stop_compressing_text
	db "<DAY>"
ENDM

MACRO text_far
; Write text from a different bank.
	stop_compressing_text
	db "<FAR>"
	bigdw \1
	db BANK(\1)
ENDM

MACRO text_farend
; Write text from a different bank and end it.
	stop_compressing_text
	db "<FAR>"
	bigdw (\1) | $8000
	db BANK(\1)
ENDM

MACRO text_plural
; Overwrite text with its plural suffix.
	stop_compressing_text
	db "<PLURAL>"
ENDM

MACRO text_end
; Stops processing text commands.
	stop_compressing_text
	db "@"
ENDM

MACRO stop_compressing_text
; Stops text compression if it is ongoing.
	DEF _might_compress_text = 0
	if _compressing_text
		DEF _compression_terminator = 1
		_dtxt "@"
	endc
	DEF _stopped_compressing_text = 1
ENDM


; Special characters

MACRO text
; Start writing text.
	if _might_compress_text || _compressing_text
		fail "'text' was already started!"
	endc
	DEF _stopped_compressing_text = 1
	_dtxt \#
ENDM

MACRO next1
; Move one screen row down.
	_dtxt "<LNBRK>", \#
ENDM

MACRO next
; Move one line down (two rows).
	_dtxt "<NEXT>", \#
ENDM

MACRO line
; Start writing at the bottom line.
	_dtxt "<LINE>", \#
ENDM

MACRO cont
; Scroll to the next line.
	_dtxt "<CONT>", \#
ENDM

MACRO para
; Start a new paragraph.
	_dtxt "<PARA>", \#
ENDM

MACRO done
; End a text box.
	_dtxt "<DONE>", \#
ENDM

MACRO prompt
; Prompt the player to end a text box (initiating some other event).
	_dtxt "<PROMPT>", \#
ENDM

MACRO page
; Start a new Pokedex page.
	_dtxt "@"
	text \#
ENDM

MACRO _dtxt
	if _stopped_compressing_text && !_might_compress_text && !_compressing_text
		DEF _might_compress_text = 1
		DEF _compression_terminator = 0
	endc
	DEF _stopped_compressing_text = 0
	if !_might_compress_text && !_compressing_text
		db \#
	else
		rept _NARG
			DEF _str EQUS \1
			rept $7fff_ffff
				if !STRLEN(#_str)
					break
				endc
				DEF _sub EQUS STRCHAR(#_str, 0)
				REDEF _str EQUS STRSLICE(#_str, STRLEN(#_sub))
				_dchr #_sub
				PURGE _sub
			endr
			PURGE _str
			shift
		endr
	endc
ENDM

MACRO _dchr
	DEF _chr = CHARVAL(\1)
	DEF _encodable = (_chr >= HUFFMAN_FIRST_SHIFTED_CHAR && _chr <= HUFFMAN_LAST_SHIFTED_CHAR) \
		|| (_chr >= FIRST_REGULAR_TEXT_CHAR && _chr < HUFFMAN_FIRST_SHIFTED_TOKEN)
	if _might_compress_text && _encodable
		DEF _might_compress_text = 0
		DEF _compressing_text = 1
		DEF _raw_bytes = 0
		setcharmap compressing
	endc
	if _compressing_text && !_encodable
		; A character outside the token alphabet makes this segment raw.
		if DEF(DEBUG)
			warn "Uncompressible character in text: {#02X:_chr}"
		endc
		DEF _might_compress_text = 0
		DEF _compressing_text = 0
		DEF _compression_terminator = 0
		; Declare the raw bytes we've accumulated so far
		for _text_idx, _raw_bytes
			db _raw_byte_{d:_text_idx}
		endr
	endc
	if !_compressing_text
		; We're not compressing text; declare the raw character
		db _chr
		if _chr == '@' || _chr == '<DONE>' || _chr == '<PROMPT>'
			; We've reached the end of the text
			DEF _might_compress_text = 0
		endc
	else
		; Append the raw character
		DEF _raw_byte_{d:_raw_bytes} = _chr
		DEF _raw_bytes += 1
		if _chr == '@' || _chr == '<DONE>' || _chr == '<PROMPT>'
			; Compare this complete segment with its raw encoding.
			DEF _compressing_text = 0
			DEF _might_compress_text = 0
			setcharmap default
			if DEF(HUFFMAN)
				_pair_text_record
			endc
			_emit_text_segment
			if DEF(HUFFMAN)
.pair_text_{d:_pair_record_id}_end:
				DEF _pair_record_id += 1
			endc
			DEF _compression_terminator = 0
		endc
	endc
ENDM
