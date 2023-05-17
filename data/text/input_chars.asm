; see engine/naming_screen.asm

NameInputLower:
	table_width 1, NameInputLower
	rawchar "abcdefghi"
	rawchar "jklmnopqr"
	rawchar "stuvwxyz-"
	rawchar "é'd'l'm'r's't'v0"
	rawchar "123456789"
	assert_table_length 9 * 5

NameInputUpper:
	table_width 1, NameInputUpper
	rawchar "ABCDEFGHI"
	rawchar "JKLMNOPQR"
	rawchar "STUVWXYZ "
	rawchar "/()¥<PK><MN>★♥♪"
	rawchar "?!♂♀.,:&%"
	assert_table_length 9 * 5

MailEntry_Uppercase:
	table_width 1, MailEntry_Uppercase
	rawchar "ABCDEFGHIJ"
	rawchar "KLMNOPQRST"
	rawchar "UVWXYZ?!…:"
	rawchar "1234567890"
	rawchar "<PK><MN><PO><KE>&♂♀¥×/"
	assert_table_length 10 * 5

MailEntry_Lowercase:
	table_width 1, MailEntry_Lowercase
	rawchar "abcdefghij"
	rawchar "klmnopqrst"
	rawchar "uvwxyz -.,"
	rawchar "é'd'l'm'r's't'v()"
	rawchar "“”'%↑↓№★♥♪"
	assert_table_length 10 * 5

NameInputLowerQwerty:
	table_width 1, NameInputLowerQwerty
	rawchar "qwertyuio"
	rawchar "asdfghjkl"
	rawchar "zxcvbnmp-"
	rawchar "é'r't's'd'l'v'm0"
	rawchar "123456789"
	assert_table_length 9 * 5

NameInputUpperQwerty:
	table_width 1, NameInputUpperQwerty
	rawchar "QWERTYUIO"
	rawchar "ASDFGHJKL"
	rawchar "ZXCVBNMP "
	rawchar "/()¥<PK><MN>★♥♪"
	rawchar "?!♂♀.,:&%"
	assert_table_length 9 * 5

MailEntryQwerty_Uppercase:
	table_width 1, MailEntryQwerty_Uppercase
	rawchar "QWERTYUIOP"
	rawchar "ASDFGHJKL:"
	rawchar "ZXCVBNM?!…"
	rawchar "1234567890"
	rawchar "<PK><MN><PO><KE>&♂♀¥×/"
	assert_table_length 10 * 5

MailEntryQwerty_Lowercase:
	table_width 1, MailEntryQwerty_Lowercase
	rawchar "qwertyuiop"
	rawchar "asdfghjkl-"
	rawchar "zxcvbnm,. "
	rawchar "é'r't's'd'l'v'm()"
	rawchar "“”'%↑↓№★♥♪"
	assert_table_length 10 * 5
