; see engine/naming_screen.asm

NameInputLower:
	db "a b c d e f g h i"
	db "j k l m n o p q r"
	db "s t u v w x y z -"
	db "/ ( ) ¥ <PK> <MN> ★ ♥ ♪"
	db "Upper  Del   End "

BoxNameInputLower:
	db "a b c d e f g h i"
	db "j k l m n o p q r"
	db "s t u v w x y z -"
	db "é 'd 'l 'm 'r 's 't 'v 0"
	db "1 2 3 4 5 6 7 8 9"
	db "Upper  Del   End "

NameInputUpper:
	db "A B C D E F G H I"
	db "J K L M N O P Q R"
	db "S T U V W X Y Z  "
	db "? ! ♂ ♀ . , : & %"
	db "Lower  Del   End "

BoxNameInputUpper:
	db "A B C D E F G H I"
	db "J K L M N O P Q R"
	db "S T U V W X Y Z  "
	db "/ ( ) ¥ <PK> <MN> ★ ♥ ♪"
	db "? ! ♂ ♀ . , : & %"
	db "Lower  Del   End "

MailEntry_Uppercase:
	db "A B C D E F G H I J"
	db "K L M N O P Q R S T"
	db "U V W X Y Z ? ! … :"
	db "1 2 3 4 5 6 7 8 9 0"
	db "<PK> <MN> <PO> <KE> é ♂ ♀ ¥ × /"
	db "Lower  Del   End   "

MailEntry_Lowercase:
	db "a b c d e f g h i j"
	db "k l m n o p q r s t"
	db "u v w x y z   - . ,"
	db "'d 'l 'm 'r 's 't 'v ( ) &"
	db "“ ” ' % ↑ ↓ № ★ ♥ ♪"
	db "Upper  Del   End   "
