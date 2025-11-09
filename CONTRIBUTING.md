# Routine Documentation

When commenting routines be sure to follow this style guide for consistency.
Many different styles of comments exist from various points of time but, this is considered up to date.

* All register names, labels, and math expressions should be surrounded with backticks in comments.

```x86asm
; Fills `bc` bytes with the value of `a`, starting at `hl`.
```

* All registers and significant memory address inputs should be described with ``@input [reg] = [description]``. The order of registers and addresses should be "logical" with the function of the routine, rather than determined by which registers are used.

```x86asm
; @input `wFoo` = First value to multiply
; @input `a` = Second value to multiply
```

* All registers and significant memory address outputs should be described with ``@output [reg] -> [description]``. The order of registers and addresses should be "logical" with the function of the routine, rather than determined by which registers are used.

```x86asm
; @output `wFoo` -> Size of data read
; @output `hl` -> Start of data
```

* Routines which set flags as return values should document them as ``@flag [reg] -> [description]``.

```x86asm
; @flag `c` -> Set if found
```

* **Every** routine documented with comments **must** include an `@clobbers [reg] [, regN...]`. 
The list should include every register that is modified by the routine, even registers marked as outputs. When listing clobbered registers, use the order `a`, `hl`, `bc`, `de`.

```x86asm
; @clobbers `a`, `hl`, `c`
```

* Register joining should be used contextually based on use.
Use `bc` if the two registers are used as a single 16-bit number, but `b`, and `c` if the registers represent different values.

```x86asm
; @input `b` = Height to fill
; @input `c` = Width to fill
; @output `bc` -> Number of tiles filled
```

## Examples

```x86asm
; Fills `bc` bytes with the value of `a`, starting at `hl`.
; @input `hl` = Address to start filling from
; @input `bc` = How many bytes to fill
; @input `a` = Value to fill with
; @clobbers `hl`, `bc`
ByteFill::
```

## Reasoning

By far the most time consuming part of learning an assembly codebase and continuing to use it is understanding what registers are stable and clobbered by routines.
Understanding undocumented input and output behavior is also time consuming.
As such, it's most important to be able to trust that a routine properly documents this behavior, particularly clobbered registers.

Syntactically, `@input` is used as IDEs are prone to merge lines together most of the time.
A line that starts with `@` generally causes them to be shown on separate lines, which is highly desired for inputs and outputs.
`=` and `->` are used to more easily determine inputs and outputs at a glance.
Using backtick code blocks for registers helps notably for readability and scanning, particularly for registers like `a` which are a word in English.
