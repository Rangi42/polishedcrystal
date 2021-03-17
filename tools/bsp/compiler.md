# BSP compiler documentation

This document describes the functioning of the BSP compiler program included in this project, bspcomp, and the version
of the syntax that it uses. This document does _not_ intend to document the BSP format itself; the [specification] does
that, and it also documents the instruction set. Since the instruction set is documented there, duplicating it here
would be redundant; however, this document does describe the overall syntax that the compiler uses, and the various
pseudo-instructions that it supports.

[specification]: specification.md

## Invocation

The script compiler is invoked with two parameters: the source file and the target BSP filename. For instance, the
following invocation:

```
./bspcomp patch.txt patch.bsp
```

would create a `patch.bsp` file from the source code in `patch.txt`.

Note that it is impossible to use more than one source file in the invocation. However, this can be remedied by having
the main source file include the rest — this way, multiple source files can freely be combined into a single resulting
BSP file. All inclusion paths are resolved relative to the current working directory (that is, the directory from which
`bspcomp` is invoked).

## Overall syntax

This is a sample source file:

```
	define result, 0xff

Main:
	checksha1 #result, .empty_file_hash
	jumpnz #result, Error
	seek 0
	subtract #result, MessageEnd, Message
	writedata Message, #result
	exit 0
.empty_file_hash
	hexdata da39a3ee5e6b4b0d3255bfef95601890afd80709 ;hash for an empty input (0 bytes)

Error:
	print .error
	menu #result, .options
	jumptable #result
	dw .go_ahead
	dw .exit
.options
	dw .go_ahead_string
	dw .exit_string
	dw -1
.error
	string "The input file is not empty. Continue?"
.go_ahead_string
	string "Yes"
.exit_string
	string "No (abort)"

.go_ahead
	truncate 0
	jump Main

.exit
	exit 1

Message:
	db "Hello world!"
MessageEnd:
```

This script would patch an empty file into a file saying "Hello world!". If the source file isn't empty, the script
would give the option to the user of continuing anyway (deleting the data previously in the file in the process) or
aborting the patching process.

Several features of the syntax can be shown in the above sample script:

* Indented lines contain instructions (or pseudo-instructions). Non-indented lines contain labels. (Indentation can be
  any amount of whitespace; that is, spaces and/or tabs.) A label can only contain letters (uppercase or lowercase;
  they are case-sensitive), numbers and underscores; it also must not begin with a number. A label can also be preceded
  by a dot, in which case it is a local label. A label can be on its own in a line, or it can be followed by a colon,
  and optionally an instruction in the same line.
* A label can be used in an instruction (or pseudo-instruction) as a value. The value of a label is the address at
  which the label will be located when the BSP file is compiled and built; the compilation process resolves the labels
  into constant values. A local label can only be used in the same scope it is defined, the scope being between one
  global (that is, non-local) label and the next; the `.empty_file_hash` label defined in the above sample script can
  only be used between the `Main` and `Error` labels.
* Labels must be unique; local labels only need to be unique within their scope.
* Blank lines are ignored. A semicolon marks a comment; anything between a semicolon and the end of the line is ignored
  as well.
* Arguments to instructions are given after the instruction itself. The first argument is separated from the name of
  the instruction simply by whitespace; further arguments are separated from prior ones by a comma surrounded by
  arbitrary amounts of whitespace.
* String arguments to pseudo-instructions that accept them are surrounded by double quotes. A `"` character itself
  inside a string argument may be escaped by duplicating it; there are no other escape sequences in strings. (In
  particular, the `\` character has no useful effect other than representing itself in a string argument.)
* Numerical constants may be written explicitly (in decimal, in hexadecimal preceded by `0x`, or in octal preceded by
  `0`; negative constants will be converted to unsigned constants in the usual two's complement form), or they may
  be represented by a label or a definition. A label can only be used where a word constant (or a word-sized immediate
  argument) would fit; a definition may be used in any context where a number is required, including a variable number.
  Hence, `#result` is simply a clearer way of writing `#255` in the above example, since `result` has been defined to
  represent `0xff` (which is 255).
* Variables are written in the form `#<number>`, where `<number>` is either a number or a defined symbol representing a
  number. Therefore, `#255` means variable number 255. Note that variable numbers are byte-sized; a number greater than
  255 will be silently truncated to fit.

## Pseudo-instructions

Pseudo-instructions are instructions for the compiler. They aren't actually instructions, since an engine won't be able
to execute them (or know they were there in the first place); instead, they are used for various purposes other than
writing code itself, such as adding data to the BSP file, or creating symbolic names for numbers.

The list of available pseudo-instructions that this compiler supports is the following:

* [align]
* [db][data]
* [define]
* [dh][data]
* [dw][data]
* [hexdata]
* [incbin][include]
* [include]
* [string]

[data]: #inserting-data-into-the-bsp-file
[string]: #inserting-null-terminated-strings-into-the-bsp-file
[hexdata]: #inserting-hexadecimal-data-into-the-bsp-file
[align]: #aligning-the-next-instruction-to-a-certain-alignment
[define]: #defining-a-symbolic-name-for-a-value
[include]: #including-other-files

### Inserting data into the BSP file

```
db any[, any[, ...]]
dh any[, any[, ...]]
dw any[, any[, ...]]
```

These pseudo-instructions respectively insert bytes, halfwords (16-bit) or words (32-bit) into the BSP directly, given
by value. They can take any number of arguments, and the bytes, halfwords or words are inserted in the order they are
given; halfwords and words are inserted in little-endian format. Note that only `dw` can accept labels as arguments,
since labels are always 32-bit values; also, these pseudo-instructions will silently truncate arguments that are too
large for the data type they accept.

All of these pseudo-instructions also accept strings as arguments, given between quotes. They will insert the strings
as given, encoded in UTF-8; the `dh` and `dw` pseudo-instructions will zero-pad the strings to make their lengths
respectively multiples of 2 and 4 bytes. Strings and regular values can be mixed in the same line.

### Inserting null-terminated strings into the BSP file

```
string "string"[, "string"[, ...]]
```

This pseudo-instruction inserts strings followed by null (`0x00`) bytes. It is provided purely as a convenience for
clearer code; the following:

```
	string "abc"
	string "123", "890"
```

is equivalent to:

```
	db "abc", 0
	db "123", 0, "890", 0
```

Just like the data pseudo-instructions (`db`, `dh` and `dw`), this pseudo-instruction can take any number of arguments.

### Inserting hexadecimal data into the BSP file

```
hexdata hexstring
```

This pseudo-instruction inserts raw data given in hexadecimal, of arbitrary length. The arguments must be sequences of
hexadecimal digits of any length (hexadecimal digits being 0-9, A-F, a-f); if any argument has an odd length, it is
padded with an extra 0 digit at the end to make it even.

This instruction inserts the data in the order it is given. Therefore, this:

```
	hexdata 0123456789abcdef
	hexdata fedc, 3210
```

is equivalent to:

```
	db 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef
	db 0xfe, 0xdc, 0x32, 0x10
```

### Aligning the next instruction to a certain alignment

```
align value
```

This pseudo-instruction aligns the next line's address to a multiple of the specified value, by padding the BSP file
with zeros. It is an error to do `align 0`.

### Defining a symbolic name for a value

```
define name, value
```

This pseudo-instruction defines a symbol to be equal to a certain value. The value must be a 32-bit constant, and the
name must be a valid name (the restrictions are the same as for label names, only that defined names cannot be local).
It is possible to change this value by using another `define` pseudo-instruction, which changes the value for further
lines of code; for instance, the following example:

```
	define value, 1
	set #1, value
	define value, 5
	set #2, value
	define value, 3
	set #value, 10
```

would set variable number 1 to 1, variable number 2 to 5 and variable number 3 to 10.

### Including other files

```
include "filename"
incbin "filename"
```

These pseudo-instructions include another file into the current one. The filename must be passed as a string; and, if
it is a relative filename, it will be resolved relative to the current working directory of the compiler.

The `include` pseudo-instruction will include the file as a source file, and therefore compile it as if it had been
transcribed into the original source file in the location the `include` pseudo-instruction is; on the other hand, the
`incbin` pseudo-instruction will simply insert the contents of the binary file as a blob, without any parsing.
