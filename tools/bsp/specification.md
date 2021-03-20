# BSP specification

A binary scripted patch, hereafter a BSP, is a file containing a script indicating how to convert some data, called the
source, into some other data, called the target. In order to achieve this goal, the patcher must execute the script
contained in the BSP. This document formally specifies how that execution must be done, and how the BSP file must be
interpreted.

The words "byte", "halfword" and "word" throughout this document respectively refer to 8, 16 and 32-bit quantities. All
halfword or word quantities are stored, read and written in little-endian form (that is, least significant byte first)
unless otherwise indicated.

For clarity of exposition, in some cases, the patch source syntax (as interpreted by this project's compiler) is used.
This is done purely for simplicity; the patch source syntax does not constitute part of this specification, and any
other implementation of a BSP compiler may use any other syntax or even a completely different language compiled to the
BSP format. The BSP format is fully specified by its binary form as documented here.

## Execution model

A BSP engine must be capable of executing a BSP file according to this model. The model describes how the engine
behaves and what a BSP can expect of the engine running it.

The execution model consists of the following elements:

* A patch space, which contains the contents of the BSP file; this space is initialized when loading the BSP file. The
  patch space is immutable (that is, read-only and of fixed size), and it has the same size as the BSP file itself.
* A file buffer, which is the memory space where the operations of the BSP file are carried out. This file buffer is of
  variable size, and it is initialized with the data of the source file; it has the same size as the source file upon
  initialization.
* 256 word variables, all of which are initialized to zero. These variables are numbered 0 to 255 and can be referenced
  by the instructions in the BSP.
* An instruction pointer, which is a word initialized to zero.
* A current file pointer, which is a word initialized to zero and in unlocked state. The current file pointer can be in
  one of two states: unlocked, in which case it behaves normally as documented here, and locked, which makes it a
  read-only value; writes or updates to the current file pointer must be silently discarded (without causing any
  warnings or other kinds of error messages) while in locked state.
* A stack, unbounded in size, that contains word values. It is initialized empty.
* A message buffer, unbounded in size (although engines may limit the size to a reasonable length and discard any data
  added to it beyond that limit), that is initialized to an empty string.

The patch space and the file buffer have a maximum size of 4,294,967,295 bytes. Attempting to write to the file buffer
past its end increases its length (zero-filling any gaps that occur this way); attempting to read from either the file
buffer or the patch space beyond their respective ends is an error. Note that executing code involves reading from the
patch space, and thus this restriction still applies.

A location in the patch space is referred to as an _address_, while a location in the file buffer is referred to as a
_position_ (therefore, the value of the instruction pointer is an address, and the value of the current file pointer is
a position). Both of them are numbered sequentially from zero in the usual way.

All arithmetic is carried out in 32-bit words unless otherwise noted. All values are treated as unsigned other than
when indicated; negative values are simply a notational convenience (e.g., -1 is actually `0xffffffff`, that is, the
same as 4,294,967,295).

All errors should be treated as fatal. If the engine encounters an error condition (such as an invalid opcode, reading
past the end, or a division by zero), it should not attempt to resume execution; instead, it should inform the user of
the error and abort immediately.

The execution of the patch results in a word value called an exit status, similar in spirit to the exit status of a
program in several operating systems. An exit status of zero indicates success; other values must be treated as failure
and thus handled as errors. When a BSP exits with a status of zero, the contents of the file buffer must be written out
to the target file as the output of the patching process.

Execution of the BSP proceeds one instruction at a time, in the usual way for this format: the byte pointed by the
instruction pointer is read, which determines the opcode; the operands (if any) for that opcode are read as well; and
the instruction pointer is incremented by the total amount of bytes read; the instruction is then executed. Execution
continues this way until the BSP exits (via the corresponding instruction). Note that some instructions will modify
the instruction pointer upon execution.

## Opcodes

The opcode of each instruction is defined by the first byte. This also defines its length, and the kind of operands it
will take. An instruction can be asigned more than one opcode depending on its arguments. For instance, the `set`
instruction has two opcodes: one when called with two variables as its operands, and another one when called with a
variable and an immediate (a constant value encoded in the instruction itself).

Variables are always encoded as a single byte indicating the variable number. Immediates (that is, constant numerical
operands that are encoded directly in the instruction) are typically words, and they are encoded in little-endian
format; the actual width of immediate operands is indicated in the opcode table. Operands are encoded in the order that
they appear.

Note that the size of an instruction (in bytes) can be calculated by adding the size of its operands and adding one
byte for the opcode itself. It is shown in the table for simplicity.

Opcode bytes that don't appear in the following table constitute undefined instructions, and attempting to execute one
of them must be considered a fatal error.

|Opcode byte|Instruction           |Size|Operands                                |
|:---------:|:---------------------|---:|:---------------------------------------|
|`0x00`     |nop                   |   1|none                                    |
|`0x01`     |return                |   1|none                                    |
|`0x02`     |jump                  |   5|word                                    |
|`0x03`     |jump                  |   2|variable                                |
|`0x04`     |call                  |   5|word                                    |
|`0x05`     |call                  |   2|variable                                |
|`0x06`     |exit                  |   5|word                                    |
|`0x07`     |exit                  |   2|variable                                |
|`0x08`     |push                  |   5|word                                    |
|`0x09`     |push                  |   2|variable                                |
|`0x0a`     |pop                   |   2|variable                                |
|`0x0b`     |length                |   2|variable                                |
|`0x0c`     |readbyte              |   2|variable                                |
|`0x0d`     |readhalfword          |   2|variable                                |
|`0x0e`     |readword              |   2|variable                                |
|`0x0f`     |pos                   |   2|variable                                |
|`0x10`     |getbyte               |   6|variable, word                          |
|`0x11`     |getbyte               |   3|variable, variable                      |
|`0x12`     |gethalfword           |   6|variable, word                          |
|`0x13`     |gethalfword           |   3|variable, variable                      |
|`0x14`     |getword               |   6|variable, word                          |
|`0x15`     |getword               |   3|variable, variable                      |
|`0x16`     |checksha1             |   6|variable, word                          |
|`0x17`     |checksha1             |   3|variable, variable                      |
|`0x18`     |writebyte             |   2|byte                                    |
|`0x19`     |writebyte             |   2|variable                                |
|`0x1a`     |writehalfword         |   3|halfword                                |
|`0x1b`     |writehalfword         |   2|variable                                |
|`0x1c`     |writeword             |   5|word                                    |
|`0x1d`     |writeword             |   2|variable                                |
|`0x1e`     |truncate              |   5|word                                    |
|`0x1f`     |truncate              |   2|variable                                |
|`0x20`     |add                   |  10|variable, word, word                    |
|`0x21`     |add                   |   7|variable, word, variable                |
|`0x22`     |add                   |   7|variable, variable, word                |
|`0x23`     |add                   |   4|variable, variable, variable            |
|`0x24`     |subtract              |  10|variable, word, word                    |
|`0x25`     |subtract              |   7|variable, word, variable                |
|`0x26`     |subtract              |   7|variable, variable, word                |
|`0x27`     |subtract              |   4|variable, variable, variable            |
|`0x28`     |multiply              |  10|variable, word, word                    |
|`0x29`     |multiply              |   7|variable, word, variable                |
|`0x2a`     |multiply              |   7|variable, variable, word                |
|`0x2b`     |multiply              |   4|variable, variable, variable            |
|`0x2c`     |divide                |  10|variable, word, word                    |
|`0x2d`     |divide                |   7|variable, word, variable                |
|`0x2e`     |divide                |   7|variable, variable, word                |
|`0x2f`     |divide                |   4|variable, variable, variable            |
|`0x30`     |remainder             |  10|variable, word, word                    |
|`0x31`     |remainder             |   7|variable, word, variable                |
|`0x32`     |remainder             |   7|variable, variable, word                |
|`0x33`     |remainder             |   4|variable, variable, variable            |
|`0x34`     |and                   |  10|variable, word, word                    |
|`0x35`     |and                   |   7|variable, word, variable                |
|`0x36`     |and                   |   7|variable, variable, word                |
|`0x37`     |and                   |   4|variable, variable, variable            |
|`0x38`     |or                    |  10|variable, word, word                    |
|`0x39`     |or                    |   7|variable, word, variable                |
|`0x3a`     |or                    |   7|variable, variable, word                |
|`0x3b`     |or                    |   4|variable, variable, variable            |
|`0x3c`     |xor                   |  10|variable, word, word                    |
|`0x3d`     |xor                   |   7|variable, word, variable                |
|`0x3e`     |xor                   |   7|variable, variable, word                |
|`0x3f`     |xor                   |   4|variable, variable, variable            |
|`0x40`     |iflt                  |  10|variable, word, word                    |
|`0x41`     |iflt                  |   7|variable, word, variable                |
|`0x42`     |iflt                  |   7|variable, variable, word                |
|`0x43`     |iflt                  |   4|variable, variable, variable            |
|`0x44`     |ifle                  |  10|variable, word, word                    |
|`0x45`     |ifle                  |   7|variable, word, variable                |
|`0x46`     |ifle                  |   7|variable, variable, word                |
|`0x47`     |ifle                  |   4|variable, variable, variable            |
|`0x48`     |ifgt                  |  10|variable, word, word                    |
|`0x49`     |ifgt                  |   7|variable, word, variable                |
|`0x4a`     |ifgt                  |   7|variable, variable, word                |
|`0x4b`     |ifgt                  |   4|variable, variable, variable            |
|`0x4c`     |ifge                  |  10|variable, word, word                    |
|`0x4d`     |ifge                  |   7|variable, word, variable                |
|`0x4e`     |ifge                  |   7|variable, variable, word                |
|`0x4f`     |ifge                  |   4|variable, variable, variable            |
|`0x50`     |ifeq                  |  10|variable, word, word                    |
|`0x51`     |ifeq                  |   7|variable, word, variable                |
|`0x52`     |ifeq                  |   7|variable, variable, word                |
|`0x53`     |ifeq                  |   4|variable, variable, variable            |
|`0x54`     |ifne                  |  10|variable, word, word                    |
|`0x55`     |ifne                  |   7|variable, word, variable                |
|`0x56`     |ifne                  |   7|variable, variable, word                |
|`0x57`     |ifne                  |   4|variable, variable, variable            |
|`0x58`     |jumpz                 |   6|variable, word                          |
|`0x59`     |jumpz                 |   3|variable, variable                      |
|`0x5a`     |jumpnz                |   6|variable, word                          |
|`0x5b`     |jumpnz                |   3|variable, variable                      |
|`0x5c`     |callz                 |   6|variable, word                          |
|`0x5d`     |callz                 |   3|variable, variable                      |
|`0x5e`     |callnz                |   6|variable, word                          |
|`0x5f`     |callnz                |   3|variable, variable                      |
|`0x60`     |seek                  |   5|word                                    |
|`0x61`     |seek                  |   2|variable                                |
|`0x62`     |seekfwd               |   5|word                                    |
|`0x63`     |seekfwd               |   2|variable                                |
|`0x64`     |seekback              |   5|word                                    |
|`0x65`     |seekback              |   2|variable                                |
|`0x66`     |seekend               |   5|word                                    |
|`0x67`     |seekend               |   2|variable                                |
|`0x68`     |print                 |   5|word                                    |
|`0x69`     |print                 |   2|variable                                |
|`0x6a`     |menu                  |   6|variable, word                          |
|`0x6b`     |menu                  |   3|variable, variable                      |
|`0x6c`     |xordata               |   9|word, word                              |
|`0x6d`     |xordata               |   6|word, variable                          |
|`0x6e`     |xordata               |   6|variable, word                          |
|`0x6f`     |xordata               |   3|variable, variable                      |
|`0x70`     |fillbyte              |   6|word, byte                              |
|`0x71`     |fillbyte              |   6|word, variable                          |
|`0x72`     |fillbyte              |   3|variable, byte                          |
|`0x73`     |fillbyte              |   3|variable, variable                      |
|`0x74`     |fillhalfword          |   7|word, halfword                          |
|`0x75`     |fillhalfword          |   6|word, variable                          |
|`0x76`     |fillhalfword          |   4|variable, halfword                      |
|`0x77`     |fillhalfword          |   3|variable, variable                      |
|`0x78`     |fillword              |   9|word, word                              |
|`0x79`     |fillword              |   6|word, variable                          |
|`0x7a`     |fillword              |   6|variable, word                          |
|`0x7b`     |fillword              |   3|variable, variable                      |
|`0x7c`     |writedata             |   9|word, word                              |
|`0x7d`     |writedata             |   6|word, variable                          |
|`0x7e`     |writedata             |   6|variable, word                          |
|`0x7f`     |writedata             |   3|variable, variable                      |
|`0x80`     |lockpos               |   1|none                                    |
|`0x81`     |unlockpos             |   1|none                                    |
|`0x82`     |truncatepos           |   1|none                                    |
|`0x83`     |jumptable             |   2|variable                                |
|`0x84`     |set                   |   6|variable, word                          |
|`0x85`     |set                   |   3|variable, variable                      |
|`0x86`     |ipspatch              |   6|variable, word                          |
|`0x87`     |ipspatch              |   3|variable, variable                      |
|`0x88`     |stackwrite            |   9|word, word                              |
|`0x89`     |stackwrite            |   6|word, variable                          |
|`0x8a`     |stackwrite            |   6|variable, word                          |
|`0x8b`     |stackwrite            |   3|variable, variable                      |
|`0x8c`     |stackread             |   6|variable, word                          |
|`0x8d`     |stackread             |   3|variable, variable                      |
|`0x8e`     |stackshift            |   5|word                                    |
|`0x8f`     |stackshift            |   2|variable                                |
|`0x90`     |retz                  |   2|variable                                |
|`0x91`     |retnz                 |   2|variable                                |
|`0x92`     |pushpos               |   1|none                                    |
|`0x93`     |poppos                |   1|none                                    |
|`0x94`     |bsppatch              |  10|variable, word, word                    |
|`0x95`     |bsppatch              |   7|variable, word, variable                |
|`0x96`     |bsppatch              |   7|variable, variable, word                |
|`0x97`     |bsppatch              |   4|variable, variable, variable            |
|`0x98`     |getbyteinc            |   3|variable, variable                      |
|`0x99`     |gethalfwordinc        |   3|variable, variable                      |
|`0x9a`     |getwordinc            |   3|variable, variable                      |
|`0x9b`     |increment             |   2|variable                                |
|`0x9c`     |getbytedec            |   3|variable, variable                      |
|`0x9d`     |gethalfworddec        |   3|variable, variable                      |
|`0x9e`     |getworddec            |   3|variable, variable                      |
|`0x9f`     |decrement             |   2|variable                                |
|`0xa0`     |bufstring             |   5|word                                    |
|`0xa1`     |bufstring             |   2|variable                                |
|`0xa2`     |bufchar               |   5|word                                    |
|`0xa3`     |bufchar               |   2|variable                                |
|`0xa4`     |bufnumber             |   5|word                                    |
|`0xa5`     |bufnumber             |   2|variable                                |
|`0xa6`     |printbuf              |   1|none                                    |
|`0xa7`     |clearbuf              |   1|none                                    |
|`0xa8`     |setstacksize          |   5|word                                    |
|`0xa9`     |setstacksize          |   2|variable                                |
|`0xaa`     |getstacksize          |   2|variable                                |
|`0xab`     |_(bit shifts)_        |  --|_(see below)_                           |
|`0xac`     |getfilebyte           |   2|variable                                |
|`0xad`     |getfilehalfword       |   2|variable                                |
|`0xae`     |getfileword           |   2|variable                                |
|`0xaf`     |getvariable           |   3|variable, variable                      |
|`0xb0`     |addcarry              |  11|variable, variable, word, word          |
|`0xb1`     |addcarry              |   8|variable, variable, word, variable      |
|`0xb2`     |addcarry              |   8|variable, variable, variable, word      |
|`0xb3`     |addcarry              |   5|variable, variable, variable, variable  |
|`0xb4`     |subborrow             |  11|variable, variable, word, word          |
|`0xb5`     |subborrow             |   8|variable, variable, word, variable      |
|`0xb6`     |subborrow             |   8|variable, variable, variable, word      |
|`0xb7`     |subborrow             |   5|variable, variable, variable, variable  |
|`0xb8`     |longmul               |  11|variable, variable, word, word          |
|`0xb9`     |longmul               |   8|variable, variable, word, variable      |
|`0xba`     |longmul               |   8|variable, variable, variable, word      |
|`0xbb`     |longmul               |   5|variable, variable, variable, variable  |
|`0xbc`     |longmulacum           |  11|variable, variable, word, word          |
|`0xbd`     |longmulacum           |   8|variable, variable, word, variable      |
|`0xbe`     |longmulacum           |   8|variable, variable, variable, word      |
|`0xbf`     |longmulacum           |   5|variable, variable, variable, variable  |

### Bit shifting opcodes

Bit shifting opcodes are defined by the byte that follows the opcode byte. The first byte is always `0xab` for these
instructions; the next byte is divided into three bit fields, as follows (where bit 0 is the least significant):

* Bit 7: variable/immediate flag
* Bits 6-5: shift type
* Bits 4-0: shift count

The opcode is determined by the shift type, as follows:

|Shift type|Opcode              |
|:--------:|:-------------------|
|         0|shiftleft           |
|         1|shiftright          |
|         2|rotateleft          |
|         3|shiftrightarith     |

If the shift count is 0, the shift count is read from the lower 5 bits of a variable; a byte will be added after the
rest of the operands indicating which variable. Finally, the type of the shift operand is determined by the
variable/immediate flag: if the flag is 0, the operand is an immediate; if it is 1, the operand is a variable.

This is summarized in the following table (note that the operand list doesn't include the byte that comes after the
opcode byte, with the bitfields as specified above):

|V/I flag|Shift count|Size|Operands                       |
|:------:|----------:|---:|:------------------------------|
|       0|          0|   8|variable, word, variable       |
|       0|      not 0|   7|variable, word                 |
|       1|          0|   5|variable, variable, variable   |
|       1|      not 0|   4|variable, variable             |

## Instruction set

The different instructions are listed here in alphabetical order, for lookup convenience. They are described in
separate sections.

* [add][calc]
* [addcarry][longcalc]
* [and][calc]
* [bsppatch]
* [bufchar][msgbuffer]
* [bufnumber][msgbuffer]
* [bufstring][msgbuffer]
* [call][flow]
* [callnz][flow]
* [callz][flow]
* [checksha1]
* [clearbuf][msgbuffer]
* [decrement][var-basic]
* [divide][calc]
* [exit]
* [fillbyte][fill]
* [fillhalfword][fill]
* [fillword][fill]
* [getbyte][get]
* [getbytedec][get]
* [getbyteinc][get]
* [getfilebyte][read]
* [getfilehalfword][read]
* [getfileword][read]
* [gethalfword][get]
* [gethalfworddec][get]
* [gethalfwordinc][get]
* [getstacksize][stack-size]
* [getvariable][var-basic]
* [getword][get]
* [getworddec][get]
* [getwordinc][get]
* [ifeq][conditionals]
* [ifge][conditionals]
* [ifgt][conditionals]
* [ifle][conditionals]
* [iflt][conditionals]
* [ifne][conditionals]
* [increment][var-basic]
* [ipspatch]
* [jump][flow]
* [jumpnz][flow]
* [jumptable]
* [jumpz][flow]
* [length]
* [lockpos][pos]
* [longmul][longcalc]
* [longmulacum][longcalc]
* [mulacum][longcalc] (note that this is an alias)
* [menu]
* [multiply][calc]
* [nop]
* [or][calc]
* [pop][stack-basic]
* [poppos][pos]
* [pos]
* [print]
* [printbuf][msgbuffer]
* [push][stack-basic]
* [pushpos][pos]
* [readbyte][read]
* [readhalfword][read]
* [readword][read]
* [remainder][calc]
* [retnz][flow]
* [return][flow]
* [retz][flow]
* [rotateleft][bit-shifts]
* [seek]
* [seekback][seek]
* [seekend][seek]
* [seekfwd][seek]
* [set][var-basic]
* [setstacksize][stack-size]
* [shiftleft][bit-shifts]
* [shiftright][bit-shifts]
* [shiftrightarith][bit-shifts]
* [stackread][stack-adv]
* [stackshift][stack-adv]
* [stackwrite][stack-adv]
* [subborrow][longcalc]
* [subtract][calc]
* [truncate]
* [truncatepos][truncate]
* [unlockpos][pos]
* [writebyte][write]
* [writedata]
* [writehalfword][write]
* [writeword][write]
* [xor][calc]
* [xordata][writedata]

[nop]: #no-operation
[var-basic]: #basic-variable-operations
[calc]: #arithmetical-and-logical-instructions
[bit-shifts]: #bit-shifting-operations
[longcalc]: #long-arithmetical-instructions
[stack-basic]: #basic-stack-operations
[flow]: #control-flow
[conditionals]: #conditionals
[exit]: #exiting
[print]: #printing-messages
[msgbuffer]: #manipulating-the-message-buffer
[menu]: #option-menus
[jumptable]: #jump-tables
[stack-adv]: #advanced-stack-operations
[stack-size]: #resizing-the-stack
[get]: #reading-values-from-patch-space
[read]: #reading-values-from-the-file-buffer
[write]: #writing-values-to-the-file-buffer
[fill]: #filling-the-file-buffer-with-a-value
[writedata]: #operating-with-data-from-the-bsp-on-the-file-buffer
[length]: #retrieving-the-length-of-the-file-buffer
[truncate]: #resizing-the-file-buffer
[pos]: #operating-with-the-current-file-pointer
[seek]: #modifying-the-current-file-pointer
[checksha1]: #checking-a-sha-1-hash
[ipspatch]: #applying-an-ips-patch
[bsppatch]: #applying-a-bsp-patch-contained-within-the-bsp

## Instruction description

Instructions are detailed here, including their operands and semantics.

For simplicity, the script compiler's syntax is used to show the form of the instruction. Operands that must be
variables are prefixed with `#`; other operands can be either variables or immediates. (In no case an instruction
only accepts an immediate as an operand.)

### No operation

```
nop
```

This instruction does nothing at all. It can be used, for instance, as a filler.

### Basic variable operations

```
set #variable, any
increment #variable
decrement #variable
getvariable #variable, #number
```

The `set` instruction sets the variable's value to the specified value, which can be an immediate value or another
variable.

The `increment` and `decrement` instructions respectively add and subtract one from the specified variable. While they
are equivalent to using `add #variable, #variable, 1` or `subtract #variable, #variable, 1`, they are available as
shorter forms (that also use fewer bytes in the BSP file).

The `getvariable` instruction sets a variable to the value of a variable whose number matches the value of the second
argument. That is, if variable 1 has the value 5, then `getvariable #2, #1` would set variable 2 to the value of
variable 5. (Note that the second argument to `getvariable` can't be an immediate value, because that would be
equivalent to a `set` instruction: `getvariable #2, 5` would be the same as `set #2, #5`. Also note that only the least
significant byte of the second argument's value is used; the upper bytes are ignored.)

### Arithmetical and logical instructions

```
add #variable, any, any
subtract #variable, any, any
multiply #variable, any, any
divide #variable, any, any
remainder #variable, any, any
and #variable, any, any
or #variable, any, any
xor #variable, any, any
```

These instructions perform the specified calculation between the two last operands and store the result in the variable
indicated by the first. The operands to the calculation are treated as unsigned values in all cases.

If the last operand to `divide` or `remainder` is zero, a fatal error occurs.

Note that the script compiler accepts a two-operand shorthand for these instructions, that is simply expanded to the
full three-operand form by repeating the first operand. (That is, `add #var, 3` is converted to `add #var, #var, 3`
prior to compilation.) This shorthand is a feature of the compiler, not part of the specification for the instructions;
the instructions (in the binary file) can only exist in three-operand form.

### Bit shifting operations

```
shiftleft #variable, any, count
shiftright #variable, any, count
shiftrightarith #variable, any, count
rotateleft #variable, any, count
```

These instructions shift the value in the operand by the amount of bits specified in the count; bit counts of 1 to 31
bits are allowed. (An immediate bit count of 0 is not valid; in the script compiler language, specifying a bit count of
0 will cause the instruction to be encoded as a `set` instruction.) If the bit count is a variable, then only the five
least significant bits of that variable will be used as bit count; the rest are silently truncated. (A bit count of 0
as a result of using a variable bit count is acceptable.)

The `shiftleft` and `shiftright` instructions shift the value in the corresponding direction, filling the shifted bits
with zeros. The `shiftrightarith` instruction behaves like `shiftright`, but extends the sign bit (the most significant
bit) instead; if this bit is 1, the shifted bits will be filled with ones. The `rotateleft` instruction shifts the
value to the left and inserts the bits that are dropped from the value on the right: a left rotation of 4 bits on the
value `0x12345678` will generate the value `0x23456781`.

Note that no `rotateright` instruction exists; the same effect can be achieved by negating the rotation count and using
a `rotateleft` instruction.

As with the arithmetical and logical instructions, the script compiler accepts a two-operand shorthand for these
instructions, that is expanded to the full three-operand form by repeating the first operand: `shiftleft #var, 2` will
be expanded to `shiftleft #var, #var, 2` prior to compilation. This is a feature of the compiler, not part of the
specification for the instructions; the instructions (in the binary file format) only exist in three-operand form.

Note on encoding: the last operand, the bit count, is already encoded in the second byte of the instruction (which
selects the opcode and the operand types) when it is an immediate, and therefore will be out of order. (When it is a
variable, it will be encoded explicitly as the last byte of the instruction, as usual.)

### Long arithmetical instructions

```
addcarry #result, #carry, any, any
subborrow #result, #borrow, any, any
longmul #low, #high, any, any
longmulacum #low, #high, any, any
```

These instructions perform calculations that are similar to their regular counterparts, but with special care for
results that do not fit in 32 bits.

The `addcarry` instruction adds the last two operands and stores the result in the variable specified by the first. If
the addition carries (that is, if the result, as a 32-bit unsigned value, is strictly lower than the operands), the
variable specified by the second operand is incremented by one. (Note that the "strictly lower than its operands"
condition can only be fulfilled for both operands or for neither, so testing against any one of the operands is
sufficient.)

The `subborrow` instruction performs a subtraction in a similar way, storing the result in the variable specified by
the first operand. If the subtraction borrows (that is, if the minuend (the instruction's third operand) as a 32-bit
unsigned value is strictly lower than the subtrahend (the instruction's last operand)), the variable specified by the
second operand is decremented by one.

The `longmul` instruction performs a 64-bit (unsigned) multiplication between its operands, and stores the lower word
in the variable specified by the first operand and the higher word in the variable specified by the second. For
instance, `longmul #1, #2, 0x12345678, 0x87654321` would set variable 1 to `0x70b88d78` and variable 2 to `0x09a0cd05`.
(Note that `0x12345678` times `0x87654321` is `0x09a0cd0570b88d78`.)

The `longmulacum` instruction performs a 64-bit multiplication in the same way, but it adds the result to the 64-bit
value contained between the variables in the first two operands. For instance, if variable 1 contains `0xfedcba98` and
variable 2 contains `0x76543210`, then `longmulacum #1, #2, 0x01234567, 0x89abcdef` would set variable 1 to
`0xc82b00c1` and variable 2 to `0x76f0d5ae`. (Note that `0x76543210fedcba98` + (`0x01234567` * `0x89abcdef`) is
`0x76f0d5aec82b00c1`.)

In case that the first two operands point to the same variable, these instructions behave as follows:

* The `addcarry` and `subborrow` instructions will increment/decrement the variable in case of carry/borrow, but not
  store the actual result of the addition/subtraction anywhere; the result is discarded.
* The `longmul` instruction will store the high word of the result in the variable. The low word of the result is
  discarded.
* The `longmulacum` instruction will store the _low_ word of the result in the variable. The high word of the result is
  discarded. Note that this intentionally differs from the behavior of the other instructions.

Due to the special behavior of the `longmulacum` instruction when the first two operands are the same variable, the
compiler has a shorthand for this instruction, called `mulacum`; this instruction takes three operands, and it is
expanded to `longmulacum` by repeating the first operand (which must be a variable). Note that this is a feature of the
compiler, not part of the specification itself; the instruction in its binary form exists in four-operand form only.

### Basic stack operations

```
push any
pop #variable
```

These instructions perform basic stack manipulations. The `push` instruction pushes a value into the stack (which can
be either a variable or a word immediate), and the `pop` instruction pops a value from the stack and stores it in the
specified variable.

If the `pop` instruction is executed with an empty stack, a fatal error occurs.

### Control flow

```
jump address
jumpz #variable, address
jumpnz #variable, address

call address
callz #variable, address
callnz #variable, address

return
retz #variable
retnz #variable
```

The `jump` instruction updates the instruction pointer, setting it to the value in its operand, which causes control to
jump to the instruction pointed by it. (Note that the address operands in these instructions can be immediate addresses
or variables.)

The `call` instruction does the same, but it first pushes the current value of the instruction pointer (which points to
the next instruction) to the stack. The `return` instruction pops a value from the stack and sets the instruction
pointer to it, thus returning from a prior call; executing `return` with an empty stack is equivalent to `exit 0`.

The `z` versions of the instructions above execute conditionally based on the value of a variable: they execute if the
variable is zero, or do nothing otherwise. The `nz` versions invert this condition.

### Conditionals

```
ifeq #variable, any, address
ifne #variable, any, address
iflt #variable, any, address
ifle #variable, any, address
ifgt #variable, any, address
ifge #variable, any, address
```

These instructions conditionally jump to the specified address, based on the condition specified by the instruction
itself. Respectively, the conditions are that the variable is equal, not equal, less than, less than or equal, greater
than, and greater than or equal than the second argument to the instruction.

### Exiting

```
exit any
```

This instruction terminates the execution of the script. The operand to this instruction is the exit status of the BSP:
zero indicates success, and any other value indicates failure (the engine may use this value in any way it wishes as
long as it follows this convention). The engine must write out the contents of the file buffer to the output (the patch
target) upon exit with a status of zero.

If the current BSP is being executed as a result of a parent script executing a `bsppatch` instruction, the argument to
exit becomes the exit status that the parent `bsppatch` instruction will store. In this case, execution resumes with
the parent script; the engine must not terminate execution (regardless of exit status) and must not write to the output
(again, regardless of exit status) upon exit of a script invoked by `bsppatch`.

### Printing messages

```
print address
```

This instruction prints a message to the user. The address parameter indicates where in the patch space the message
begins; the message must be UTF-8 encoded, and continues until a null byte (a byte with value `0x00`) is found.

This document does not specify how the engine will display the message; however, in case of a console-based application
(or an environment that behaves in a similar fashion), it is recommended that the engine prints a newline character
after the message.

If the message is not valid UTF-8, the engine may choose to display the message anyway (handling the invalid characters
in any way it can) or to treat it as a fatal error.

An engine incapable of handling the full Unicode character set may choose to use a reduced character set and replace
the remaining characters with a suitable substitution character; however, an engine must at least support the Latin
letters (A-Z, a-z), digits (0-9), spaces, and the following punctuation characters: `'-,.;:#%&!?/()[]`.

### Manipulating the message buffer

```
bufstring address
bufchar any
bufnumber any
printbuf
clearbuf
```

The first three instructions concatenate data at the end of the message buffer. The last two display it and clear it.

The `bufstring` instruction concatenates a string (in the same format as for the `print` instruction) at the end of
the message buffer. No separator is inserted before or after the string.

The `bufchar` instruction appends a single Unicode character to the message buffer. An engine incapable of handling the
full Unicode character set may choose to use a reduced character set and replace the remaining characters with suitable
substitutes; it must however support at least the letters (A-Z, a-z), numbers (0-9), basic punctuation characters
(`'-,.;:#%&!?/()[]`) and the space character. Passing a value that isn't a valid Unicode codepoint (`0x000000` to 
`0x00d7ff` and `0x00e000` to `0x10ffff`) is a fatal error.

The `bufnumber` instruction appends the decimal representation of a number to the message buffer. The number is
treated as a 32-bit unsigned value and converted to decimal, and printed using the regular digit characters (0-9,
`U+0030` to `U+0039`). The shortest representation of the number is used; that is, no leading zeros are printed (other
than a single `0` for the number zero itself).

The `printbuf` instruction prints the contents of the message buffer as a message (as if it had been passed to the
`print` instruction) and clears the buffer, resetting it to the empty string. The `clearbuf` instruction resets the
message buffer to the empty string without printing it.

### Option menus

```
menu #variable, address
```

This instruction displays a menu with options, from which the user has to select one. The selected option number is
written to the indicated variable; the first option is numbered zero.

The address parameter should point to a list of pointers in patch space, each pointer pointing in turn to the text that
each option will contain (in the same format that the `print` instruction uses); the list is terminated with a
`0xffffffff` value. For instance, this code fragment would display a menu with four options:

```
	menu #result, Options
	; ...

Options:
	dw .zero
	dw .one
	dw .two
	dw .three
	dw -1
.zero
	string "Option 0"
.one
	string "Option 1"
.two
	string "Option 2"
.three
	string "Option 3"
```

If the list of pointers is empty (i.e., if the first pointer is `0xffffffff`), no menu is shown to the user, and the
variable is set to `0xffffffff`.

Note that a menu with just one option must still be shown to the user, as it is possible to use such a menu to give the
user the possibility of aborting the process by stopping the BSP engine.

### Jump tables

```
jumptable #variable
```

This instruction expects to be followed by a list of pointers, as many as needed according to the values the variable
may have. The instruction will read the word at `instruction pointer + 4 * #variable` and jump to the address that is
read. Note that no bounds checking is performed on the value of the variable, so the script must ensure that the
instruction will jump to a correct location.

For instance, the following code will jump to `.zero`, `.one` or `.two` depending on whether the value of `#var` is 0,
1 or 2 respectively (if `#var` is 3 or greater, the result is undefined):

```
	jumptable #var
	dw .zero
	dw .one
	dw .two

.zero
	; ...
.one
	; ...
.two
	; ...
```

### Advanced stack operations

```
stackread #variable, position
stackwrite position, any
stackshift amount
```

These instructions operate directly on the values in stack.

The `stackread` instruction reads a value from the stack into a variable, and the `stackwrite` instruction writes a
value to a position in stack. For both instructions, the position argument is treated as a _signed_ value: if it is
positive, it refers to a position starting from the bottom of the stack (that is, where values would be pushed or
popped next); and if it is negative, it refers to a position starting from the top of the stack (that is, where the
very first value in the stack was pushed).

Positive positions in stack are numbered from the current stack position upwards: the value that would be popped next
is position 0, the following one in stack is position 1, and so on. Negative positions in stack are numbered downwards
from the stack top: the very first value in the stack is position -1, the one pushed after that one is position -2, and
so on. Attempting to access a position in stack that doesn't exist (that is, a position that is greater or equal than
the number of elements in the stack, or less than minus that amount) is a fatal error.

The `stackshift` instruction performs a mass push/pop, changing the stack size. The argument to this instruction is
also treated as a _signed_ value: if it is positive, as many zeros as the argument indicates are pushed into the stack,
making it larger; if it is negative, as many elements as the absolute value of the argument indicates are popped and
stored nowhere, making the stack smaller (it is a fatal error to attempt to pop more values than the stack currently
holds). An argument of zero makes the instruction do nothing.

### Resizing the stack

```
getstacksize #variable
setstacksize any
```

These instructions manipulate the size of the stack directly.

The `getstacksize` instruction stores the size of the stack (in number of words) in the specified variable. If the size
of the stack is too large to be stored in a word, then `0xffffffff` is stored.

The `setstacksize` instruction changes the size of the stack to be the specified value. If this value is larger than
the current size of the stack, enough zeros are pushed to make the stack as large as needed; if this value is smaller
than the current size of the stack, enough values are popped (and stored nowhere) as to reduce the stack to the
specified size.

### Reading values from patch space

```
getbyte #variable, address
getbyteinc #variable, #address
getbytedec #variable, #address

gethalfword #variable, address
gethalfwordinc #variable, #address
gethalfworddec #variable, #address

getword #variable, address
getwordinc #variable, #address
getworddec #variable, #address
```

These instructions are used to fetch values from the BSP itself. They read a value from patch space and store it in a
variable. The address indicates where the value is located; halfwords and words are read in little-endian form.

The `inc` and `dec` variants respectively increment and decrement the address variable by the size of the value (1, 2
or 4) _after_ reading from that address. For these instructions, the address must be a variable; it cannot be an
immediate address. (Note that a reference to a label is compiled as an immediate.) If both arguments to one of these
instructions refer to the same variable, the instruction behaves as its regular counterpart, setting the variable to
the value at the address and disregarding the increment.

### Reading values from the file buffer

```
readbyte #variable
readhalfword #variable
readword #variable

getfilebyte #variable
getfilehalfword #variable
getfileword #variable
```

The first group of instructions reads a value from the file buffer, located at the position given by the current file
pointer. The current file pointer itself is incremented by the size of the value read (1, 2 or 4) after reading the
value, unless it is in locked state. Halfwords and words are read in little-endian form.

The instructions in the second group perform the same task as their counterparts in the first group, but they don't
update the current file pointer after reading, regardless of whether it is in locked or unlocked state.

It is a fatal error to attempt to read beyond the end of the file buffer.

### Writing values to the file buffer

```
writebyte any
writehalfword any
writeword any
```

These instructions write a value to the file buffer, at the position indicated by the current file pointer. The current
file pointer itself is incremented by the size of the value written (1, 2 or 4) after writing the value, unless it is
in locked state. Halfwords and words are written in little-endian form.

If the instruction attempts to write past the end of the file buffer, the file buffer is extended to accomodate the new
value. If this results in a gap of uninitialized data, this gap is filled with zeros.

Note that the `writebyte` and `writehalfword` instructions take respectively a byte and a halfword argument; the upper
bytes of the value are silently ignored.

### Filling the file buffer with a value

```
fillbyte count, any
fillhalfword count, any
fillword count, any
```

These instructions repeatedly write the value indicated by their second argument as many times as the first argument
indicates. All considerations about the current file pointer apply as in the `write` instructions; namely, this causes
the current file pointer to be incremented accordingly.

Attempting to write past the end of the file buffer behaves as with the `write` instructions.

Note that the `fillbyte` and `fillhalfword` respectively take a byte and a halfword as their second argument; the upper
bytes of the value passed there are silently ignored.

### Operating with data from the BSP on the file buffer

```
writedata address, length
xordata address, length
```

The `writedata` instruction writes data (from the patch space, starting at the location indicated by the address
argument) into the file buffer, starting at the current file pointer and going for as many bytes as the length argument
indicates. All considerations about the current file pointer apply as in the other `write` instructions; namely, this
causes the current file pointer to be incremented accordingly.

The `xordata` instruction applies a XOR operation between the data currently in the file buffer and the data pointed to
by the address in the patch space.

Attempting to write past the end of the file buffer behaves as with the `write` instructions. Note that `xordata`
behaves identically to `writedata` in this case.

Also note that, since these instructions read from the patch space, they may attempt to read beyond its end; this is a
fatal error.

### Retrieving the length of the file buffer

```
length #variable
```

This instruction stores the current length of the file buffer in the specified variable.

### Resizing the file buffer

```
truncate any
truncatepos
```

The `truncate` instruction changes the length of the file buffer to the specified value. If the file buffer is made
shorter this way, the data at the end of it is lost; if it is made longer, the gap at the end is filled with zeros.
Note that this instruction does not update the current file pointer, even if it would point beyond the end of the file
buffer after execution.

The `truncatepos` instruction changes the length of the file buffer to make it end at the current file pointer; that
is, it sets the length of the file buffer to the value of the current file pointer, causing the current file pointer to
point to the end of the file buffer.

### Operating with the current file pointer

```
pos #variable
lockpos
unlockpos
pushpos
poppos
```

The `pos` instruction stores the value of the current file pointer in the specified variable.

The `lockpos` and `unlockpos` instructions set the current file pointer's state accordingly.

The `pushpos` instruction pushes the value of the current file pointer into the stack, and the `poppos` instruction
pops a value from the stack and sets the current file pointer to it. Note that it is a fatal error to execute `poppos`
with an empty stack. Also note that `poppos` does not update the current file pointer if it is in locked state
(although it still pops a value, thus behaving as a dummy pop, or `stackshift -1`).

### Modifying the current file pointer

```
seek any
seekfwd any
seekback any
seekend any
```

The `seek` instruction sets the current file pointer to the specified value. The `seekfwd` and `seekback` instructions
respectively add and subtract the specified value from the current file pointer. The `seekend` instruction subtracts
the specified value from the file buffer length and sets the current file pointer to the result.

It is a fatal error to cause the calculations performed by the last three instructions to overflow.

Note that no bounds checking is performed on the current file pointer: it is allowed to point to a position beyond the
end of the file buffer by any amount. Also note that these instructions do nothing if the current file pointer is in
locked state.

### Checking a SHA-1 hash

```
checksha1 #variable, address
```

This instruction calculates the SHA-1 hash of the current contents of the file buffer (the current file pointer is not
read or updated by this instruction), and compares it to the hash stored in patch space at the specified address. The
hash is stored as a 20-byte value, most significant byte first for convenience. The hash is to be calculated as
specified by the formal specification in [RFC 3174][rfc3174].

The comparison returns a bit mask, which sets a bit for each byte that fails the comparison: bit 0 is set if the first
byte of the real hash differs from the first byte of the compared hash, and so on. For instance, knowing that the SHA-1
hash for an empty input is `da39a3ee5e6b4b0d3255bfef95601890afd80709`, the following script:

```
  checksha1 #result, .hash
  ; ...
.hash
  hexdata ff39a3ee5eff4b0d3255bfef95601890afd80709
```

when executed with an empty file buffer would set `#result` to `0x00000021`. (Notice that the first and sixth bytes of
the hash have been replaced with `0xff` bytes in the hash provided to `.hash`.)

Also notice that the instruction will set the variable to zero if (and only if) the hash matches in full.

If this instruction is executed multiple times (with any arguments), the engine is not required to recalculate the hash
as long as the contents of the file buffer haven't changed since the last time the hash was calculated; since it is
known that the hash will come out to the same value, the engine may simply reuse this value for efficiency.

[rfc3174]: https://tools.ietf.org/html/rfc3174

### Applying an IPS patch

```
ipspatch #variable, address
```

This instruction applies an IPS patch, embedded in the BSP itself (that is, read from patch space), to the current file
buffer. The current file pointer is taken as an offset to be added to all positions in the IPS patch itself (if this is
undesirable, execute a `seek 0` instruction beforehand), but it is not updated by this instruction.

The IPS patch is located in patch space, at the address specified by the corresponding argument to the instruction.
After applying the patch, the variable passed to this instruction is set to point to the address where the IPS patch
ends (that is, to the end of the patch, right after the `EOF` marker).

Note that, as with any other instruction that writes to the file buffer, writing past its end will extend it
accordingly and zero-fill any gaps that arise; also, as with any other instruction that reads from patch space, reading
past its end is a fatal error.

The IPS patching procedure (as implemented by this specification, in compliance with the IPS specification itself) is
defined as follows:

1. Read the first five bytes of the patch; they must be equal to the hexadecimal string `50 41 54 43 48` (representing
   the ASCII string `PATCH`). If these bytes don't match, a fatal error occurs.
2. Read three bytes and interpret them as a 24-bit big-endian unsigned value. If this value is equal to `0x454f46`
   (which happens to be the ASCII string `EOF`), the patch is done (and the variable passed to the `ipspatch`
   instruction must be set to the address that would be read next); otherwise, continue with the next step.
3. Add this value to the current file pointer to determine where to begin writing. (Note that this step is specific to
   this specification, and not part of the IPS format itself.)
4. Read two bytes and interpret them as a 16-bit big-endian unsigned value; this is the amount of data to write.
5. If the value read in the previous step is not zero, read as many bytes as that value indicates and write those bytes
   (in the same order) to the file buffer at the position calculated in step 3; then go back to step 2.
6. Otherwise (that is, if the value read in step 4 was zero), read another 16-bit unsigned value (representing the
   count) followed by a single byte; repeatedly write this byte as many times as the count specifies starting at the
   position calculated in step 3, and then go back to step 2.

### Applying a BSP patch contained within the BSP

```
bsppatch #variable, address, length
```

This instruction executes a BSP contained within the BSP. That is, it is used to create a child BSP that is forked from
the current one and executed separately; the parent is suspended until the child finishes.

The child BSP has its own variables, stack, instruction pointer, message buffer and patch space, but it shares the file
buffer and current file pointer with the parent; the file buffer and the current file pointer (including its state) are
inherited from the parent script (the one executing the `bsppatch` instruction), and they can be modified freely by the
child BSP (retaining the modifications when it exits).

The child BSP's patch space is created with the length specified in the `bsppatch` instruction, and filled with data
read from the parent's patch space starting at the specified address; a fatal error occurs if this causes the engine to
read past the end of the parent's patch space. The child BSP's variables and instruction pointer are all initialized to
zero, its message buffer is initialized to the empty string, and its stack is initialized empty, just like when
executing a BSP normally. Execution then resumes with the child, continuing until the child exits; only when the child
exits, the `bsppatch` instruction of the parent can be completed. When the child exits, the variable passed to
`bsppatch` in the parent is set to the child's exit status.

The engine must not write out to the target file when the child exits, regardless of exit status; it must, instead,
pass the exit status to the parent via the variable passed to `bsppatch`. The file buffer and current file position,
being shared resources between the parent and the child, must also conserve their state when execution returns from the
child to the parent.

If the child's execution triggers a fatal error, this fatal error must be propagated to the parent; in other words,
a fatal error at any depth must halt the whole engine. Execution of the parent must **not** be resumed after a fatal
error occurs in the child.
