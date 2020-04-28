; see engine/naming_screen.asm
; TODO: fix rawchar macro so it can handle ',' (is this a rgbds problem?)

NameInputLower:
	rawchar "a b c d e f g h i"
	rawchar "j k l m n o p q r"
	rawchar "s t u v w x y z -"
	rawchar "/ ( ) ¥ <PK> <MN> ★ ♥ ♪"
	rawchar "Upper  Del   End "

BoxNameInputLower:
	rawchar "a b c d e f g h i"
	rawchar "j k l m n o p q r"
	rawchar "s t u v w x y z -"
	rawchar "é 'd 'l 'm 'r 's 't 'v 0"
	rawchar "1 2 3 4 5 6 7 8 9"
	rawchar "Upper  Del   End "

NameInputUpper:
	rawchar "A B C D E F G H I"
	rawchar "J K L M N O P Q R"
	rawchar "S T U V W X Y Z  "
	rawchar "? ! ♂ ♀ . \, : & %"
	rawchar "Lower  Del   End "

BoxNameInputUpper:
	rawchar "A B C D E F G H I"
	rawchar "J K L M N O P Q R"
	rawchar "S T U V W X Y Z  "
	rawchar "/ ( ) ¥ <PK> <MN> ★ ♥ ♪"
	rawchar "? ! ♂ ♀ . \, : & %"
	rawchar "Lower  Del   End "

MailEntry_Uppercase:
	rawchar "A B C D E F G H I J"
	rawchar "K L M N O P Q R S T"
	rawchar "U V W X Y Z ? ! … :"
	rawchar "1 2 3 4 5 6 7 8 9 0"
	rawchar "<PK> <MN> <PO> <KE> é ♂ ♀ ¥ × /"
	rawchar "Lower  Del   End   "

MailEntry_Lowercase:
	rawchar "a b c d e f g h i j"
	rawchar "k l m n o p q r s t"
	rawchar "u v w x y z   - . \,"
	rawchar "'d 'l 'm 'r 's 't 'v ( ) &"
	rawchar "“ ” ' % ↑ ↓ № ★ ♥ ♪"
	rawchar "Upper  Del   End   "
