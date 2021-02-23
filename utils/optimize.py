#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Search all .asm files for N code lines in a row that match some conditions.
"""

from collections import namedtuple
from glob import iglob

# Regular expressions are useful for text processing
import re

# Paired registers are also useful
PAIRS = {
	'a': 'f', 'f': 'a',
	'b': 'c', 'c': 'b',
	'd': 'e', 'e': 'd',
	'h': 'l', 'l': 'h',
}

# Other useful utility functions for implementing conditions

def isVolatile(code):
	return any(r in code for r in {
		'[hli]', '[hld]', '[hl+]', '[hl-]',
		'[rJOYP]', '[rBGPD]', '[rOBPD]'
	})

# Each line has five properties:
# - num (1, 2, 3, etc)
# - code (no indent or comment)
# - comment (if one exists)
# - text (the whole line of text)
# - context (the current label)
Line = namedtuple('Line', ['num', 'code', 'comment', 'text', 'context'])

# Suppress false positives with comments, like:
#     ld c, a ; no-optimize a = N - a (c gets used in .load_loop)
#     ld a, NUM_MOVES
#     sub c
SUPPRESS = 'no-optimize'

# A set of named patterns of suboptimal code
#
# Make lists of N conditions to check in N lines
# prev[-1] is the previous line, prev[-2] is before that one, etc
#
# For details on how to optimize these patterns:
# https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code
#
# Don't run them all at once unless you want to wait a long time
patterns = {
'Redundant arguments': [
	# Bad: add a, X (or other arithmetic|logic operators)
	# Good: add X
	(lambda line1, prev: re.match(r'(?:add|adc|sub|sbc|and|xor|or|cp) a,', line1.code)),
],
'nops': [
	# Bad: ld b, b (or other identical registers)
	# Meh: nop
	# Good: omit (unless you need it for timing)
	(lambda line1, prev: re.match(r'ld ([abcdehl]), \1$', line1.code)
		or line1.code == 'nop'),
],
'Inefficient HRAM load': [
	# Bad: ld a, [hFoo] (or [rFoo])
	# Good: ldh a, [hFoo]
	(lambda line1, prev: re.match(r'ld a, \[[hr][^l]', line1.code)),
],
'Inefficient HRAM store': [
	# Bad: ld [hFoo], a (or [rFoo])
	# Good: ldh [hFoo], a
	(lambda line1, prev: re.match(r'ld \[[hr][^l]', line1.code)
		and line1.code.endswith(', a')),
],
# 'a = 0': [
# 	# Bad: ld a, 0
# 	# Good: xor a (unless you need to preserve flags)
# 	(lambda line1, prev: re.match(r'ld a, [%\$&]?0+$', line1.code)),
# ],
'a++|a--': [
	# Bad: add|sub 1
	# Good: inc|dec a (unless you need to set the carry flag)
	(lambda line1, prev: re.match(r'(?:add|sub) (?:a, )?[%\$&]?0*1$', line1.code)),
],
'a = ~a': [
	# Bad: xor $ff
	# Good: cpl
	(lambda line1, prev: re.match(r'xor (?:255|-1|\$[Ff][Ff]|%11111111|&377)$', line1.code)),
],
'a = N - a': [
	# Bad: ld b, a / ld a, N / sub b (or other intermediate registers)
	# Good: cpl / add N + 1
	(lambda line1, prev: re.match(r'ld [bcdehl], a', line1.code)),
	(lambda line2, prev: re.match(r'ld a, [^afbcdehl\[]', line2.code)),
	(lambda line3, prev: re.match(r'sub [bcdehl]', line3.code)
		and line3.code[4] == prev[0].code[3]),
],
'a = carry ? P : Q': [
	# Bad: ld a, P / jr c|nc, .ok / ld a, Q / .ok
	# Bad: ld a, P / jr c|nc, .ok / xor|inc|dec a / .ok
	# Good: solutions involving sbc a
	(lambda line1, prev: re.match(r'ld a, [^afbcdehl\[]', line1.code)),
	(lambda line2, prev: re.match(r'j[rp] n?c,', line2.code)),
	(lambda line3, prev: re.match(r'ld a, [^afbcdehl\[]', line3.code)
		or line3.code in {'xor a', 'inc a', 'dec a'}),
	(lambda line4, prev: line4.code.rstrip(':') == prev[1].code.split(',')[1].strip()),
],
'a++|a-- if carry': [
	# Bad: jr nc, .ok / { inc|dec a }+ / .ok
	# Good: adc|sbc 0
	(lambda line1, prev: re.match(r'j[rp] nc,', line1.code)),
	(lambda line2, prev: line2.code in {'inc a', 'dec a'}),
	(1, lambda line3, prev: line3.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
],
'a = a >> 3': [
	# Bad: srl a / srl a / srl a
	# Good: rrca / rrca / rrca / and %00011111
	(lambda line1, prev: line1.code == 'srl a'),
	(lambda line2, prev: line2.code == 'srl a'),
	(lambda line3, prev: line3.code == 'srl a'),
],
'a = X + carry': [
	# Bad: ld b, a / ld a, c|N / adc 0
	# Good: ld b, a / adc c|N / sub b
	(lambda line1, prev: re.match(r'ld ([bcdehl]|\[hl\]), a', line1.code)),
	(lambda line2, prev: line2.code.startswith('ld a,')
		and (not line2.code.startswith('ld a, [') or line2.code == 'ld a, [hl]')),
	(lambda line3, prev: re.match(r'adc [%\$&]?0+$', line3.code)),
],
'a = carry + X': [
	# Bad: ld b, a / ld a, 0 / adc c|N
	# Good: ld b, a / adc c|N / sub b
	(lambda line1, prev: re.match(r'ld ([bcdehl]|\[hl\]), a', line1.code)),
	(lambda line2, prev: re.match(r'ld a, [%\$&]?0+$', line2.code)),
	(lambda line3, prev: line3.code.startswith('adc ')
		and (not line3.code.startswith('adc [') or line3.code == 'adc [hl]')),
],
'a|b|c|d|e|h|l = z|nz|c|nc ? P : Q': [
	# Bad: jr z|nz|c|nc, .p / ld a|b|c|d|e|h|l, Q / jr .ok / .p / (ld a|b|c|d|e|h|l, P | xor a) / (.ok | jr .ok)
	# Good: ld a|b|c|d|e|h|l, Q / jr nz|z|nc|c, .ok / .p / (ld a|b|c|d|e|h|l, P | xor a) / .ok
	(lambda line1, prev: re.match(r'j[rp] n?[zc],', line1.code)),
	(lambda line2, prev: re.match(r'ldh? [abcdehl],', line2.code)),
	(lambda line3, prev: re.match(r'j[rp] ', line3.code) and ',' not in line3.code
		and line3.code != 'jp hl'),
	(lambda line4, prev: line4.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
	(lambda line5, prev: re.match(r'ldh? [abcdehl],', line5.code)
		or (line5.code in {'xor a', 'xor a, a'} and re.match(r'ldh? a,', prev[1].code))),
	(lambda line6, prev: line6.code == prev[2].code
		or line6.code.rstrip(':') == prev[2].code[3:].strip()),
],
'hl|bc|de += a|N': [
	# Bad: add l|N / ld l, a / ld a, h|0 / adc 0|h / ld h, a (hl or bc or de)
	# Good: add l|N / ld l, a / adc h / sub l / ld h, a
	(lambda line1, prev: re.match(r'add (?:a, )?(?:[lce]|[^afbdh\[])', line1.code)),
	(lambda line2, prev: re.match(r'ld [lce], a', line2.code)
		and (lambda x: line2.code[3] == x or x not in 'lce')(prev[0].code.replace('add a,', 'add')[4])),
	(lambda line3, prev: re.match(r'ld a, (?:[hbd]|[%\$&]?0+$)', line3.code)
		and (line3.code[6] not in 'hbd' or line3.code[6] == PAIRS[prev[1].code[3]])),
	(lambda line4, prev: re.match(r'adc (?:[hbd]|[%\$&]?0+$)', line4.code)
		and (line4.code[4] not in 'hbd' or line4.code[4] == PAIRS[prev[1].code[3]])),
	(lambda line5, prev: re.match(r'ld [hbd], a', line5.code)
		and line5.code[3] == PAIRS[prev[1].code[3]]),
],
'hl|bc|de += a|N (jump)': [
	# Okay: add l|N / ld l, a / jr nc, .noCarry / inc h / .noCarry
	# Good: add l|N / ld l, a / adc h / sub l / ld h, a
	(lambda line1, prev: re.match(r'add (?:a, )?(?:[lce]|[^afbdh\[])', line1.code)),
	(lambda line2, prev: re.match(r'ld [lce], a', line2.code)
		and (lambda x: line2.code[3] == x or x not in 'lce')(prev[0].code.replace('add a,', 'add')[4])),
	(lambda line3, prev: re.match(r'j[rp] nc,', line3.code)),
	(lambda line4, prev: re.match(r'inc [hbd]', line4.code)
		and line4.code[4] == PAIRS[prev[1].code[3]]),
	(lambda line5, prev: line5.code.rstrip(':') == prev[2].code.split(',')[1].strip()),
],
'hl|bc|de = Foo + a': [
	# Bad: ld hl, Foo / add l / ld l, a / adc h / sub l / ld h, a
	# Good: add LOW(Foo) / ld l, a / adc HIGH(Foo) / sub l / ld h, a
	(lambda line1, prev: re.match(r'ld (?:hl|bc|de), [^\[]', line1.code)),
	(lambda line2, prev: re.match(r'add (?:a, )?(?:[lce])', line2.code)
		and line2.code[-1] == prev[0].code[4]),
	(lambda line3, prev: re.match(r'ld [lce], a', line3.code)
		and line3.code[3] == prev[0].code[4]),
	(lambda line4, prev: re.match(r'adc (?:a, )?(?:[hbd])', line4.code)
		and line4.code[-1] == prev[0].code[3]),
	(lambda line5, prev: re.match(r'sub (?:a, )?(?:[lce])', line5.code)
		and line5.code[-1] == prev[0].code[4]),
	(lambda line6, prev: re.match(r'ld [hbd], a', line6.code)
		and line6.code[3] == prev[0].code[3]),
],
'hl|bc|de -= N': [
	# Bad: ld a, l / sub N / ld l, a / ld a, h / sbc 0 / ld h, a (hl or bc or de)
	# Good: ld a, l / sub N / ld l, a / jr nc, .noCarry / dec h / .noCarry
	(lambda line1, prev: re.match(r'ld a, [lce]', line1.code)),
	(lambda line2, prev: re.match(r'sub (?:a, )?(?:[^afbcdehl\[])', line2.code)),
	(lambda line3, prev: re.match(r'ld [lce], a', line3.code)
		and (lambda x: line3.code[3] == prev[0].code[6])(prev[1].code.replace('sub a,', 'sub')[4])),
	(lambda line4, prev: re.match(r'ld a, [hbd]', line4.code)
		and line4.code[6] == PAIRS[prev[0].code[6]]),
	(lambda line5, prev: re.match(r'sbc [%\$&]?0+$', line5.code)),
	(lambda line6, prev: re.match(r'ld [hbd], a', line6.code)
		and line6.code[3] == PAIRS[prev[0].code[6]]),
],
'hl|bc|de = a * 16': [
	# Bad: ld l, a / ld h, 0 / add hl, hl / add hl, hl / add hl, hl / add hl, hl
	# Good: solutions involving 'add a' or 'xor a' (if possible)
	(lambda line1, prev: re.match(r'ld [lce], a', line1.code) or
		re.match(r'ld [hbd], [%\$&]?0+$', line1.code)),
	(lambda line2, prev: (re.match(r'ld [lce], a', line2.code) or
		re.match(r'ld [hbd], [%\$&]?0+$', line2.code)) and
		line2.code != prev[0].code and line2.code[3] == PAIRS[prev[0].code[3]]),
	(lambda line3, prev: re.match(r'add (hl|bc|de), \1$', line3.code) and
		line3.code[4] in {prev[0].code[3], PAIRS[prev[0].code[3]]}),
	(lambda line4, prev: re.match(r'add (hl|bc|de), \1$', line4.code) and
		line4.code[4] in {prev[0].code[3], PAIRS[prev[0].code[3]]}),
	(lambda line5, prev: re.match(r'add (hl|bc|de), \1$', line5.code) and
		line5.code[4] in {prev[0].code[3], PAIRS[prev[0].code[3]]}),
	(lambda line6, prev: re.match(r'add (hl|bc|de), \1$', line6.code) and
		line6.code[4] in {prev[0].code[3], PAIRS[prev[0].code[3]]}),
],
'hl|bc|de = a * 16 (rept)': [
	# Bad: ld l, a / ld h, 0 / rept 4 / add hl, hl / endr
	# Good: solutions involving 'add a' or 'xor a' (if possible)
	(lambda line1, prev: re.match(r'ld [lce], a', line1.code) or
		re.match(r'ld [hbd], [%\$&]?0+$', line1.code)),
	(lambda line2, prev: (re.match(r'ld [lce], a', line2.code) or
		re.match(r'ld [hbd], [%\$&]?0+$', line2.code)) and
		line2.code != prev[0].code and line2.code[3] == PAIRS[prev[0].code[3]]),
	(lambda line3, prev: line3.code.lower() == 'rept 4'),
	(lambda line4, prev: re.match(r'add (hl|bc|de), \1$', line4.code) and
		line4.code[4] in {prev[0].code[3], PAIRS[prev[0].code[3]]}),
	(lambda line5, prev: line5.code.lower() == 'endr'),
],
'hl *= 2': [
	# Bad: sla l / rl h
	# Good: add hl, hl
	(lambda line1, prev: line1.code == 'sla l'),
	(lambda line2, prev: line2.code == 'rl h'),
],
'hl = *Foo': [
	# Bad: ld a, [Foo] / ld l, a / ld a, [Foo+1] / ld h, a
	# Good: ld hl, Foo / ld a, [hli] / ld h, [hl] / ld l, a
	#
	# Bad: ld a, [Foo] / ld h, a / ld a, [Foo+1] / ld l, a
	# Good: ld hl, Foo / ld a, [hli] / ld l, [hl] / ld h, a
	(lambda line1, prev: re.match(r'ld a, \[[^hbd]', line1.code)),
	(lambda line2, prev: re.match(r'ld [lh], a', line2.code)),
	(lambda line3, prev: re.match(r'ld a, \[[^hbd]', line3.code)
		and re.split(r'[^A-Za-z0-9_\.%\$&]', line3.code[7:])[0] ==
			re.split(r'[^A-Za-z0-9_\.%\$&]', prev[0].code[7:])[0]),
	(lambda line4, prev: re.match(r'ld [lh], a', line4.code)
		and line4.code[3] == PAIRS[prev[1].code[3]]),
],
'h,l|b,c|d,e = P,Q': [
	# Bad: ld b, P / ld c, Q
	# Good: lb bc, P, Q
	(lambda line1, prev: re.match(r'ld [hlbcde], [^afbcdehl\[]', line1.code)),
	(lambda line2, prev: re.match(r'ld [hlbcde], [^afbcdehl\[]', line2.code)
		and line2.code[3] == PAIRS[prev[0].code[3]]
		and line2.context == prev[0].context),
],
# '*hl = N': [
# 	# Bad: ld a, N / ld [hl], a (unless you need N in a too)
# 	# Good: ld [hl], N
# 	(lambda line1, prev: re.match(r'ld a, [^afbcdehl\[]', line1.code)),
# 	(lambda line2, prev: line2.code == 'ld [hl], a'),
# ],
'*hl++|*hl--': [
	# Bad: ld a, [hl] / { inc|dec a }+ / ld [hl], a
	# Good: inc|dec [hl] (before ld a, [hl] if you need [hl] in a too)
	(lambda line1, prev: line1.code == 'ld a, [hl]'),
	(lambda line2, prev: line2.code in {'inc a', 'dec a'}),
	(1, lambda line3, prev: line3.code == 'ld [hl], a'),
],
'*hl++|*hl-- = a': [
	# Bad: ld [hl], a / inc|dec hl
	# Good: ld [hli|hld], a
	(lambda line1, prev: line1.code == 'ld a, [hl]'),
	(lambda line2, prev: line2.code in {'inc hl', 'dec hl'}),
],
'a = *hl++|*hl--': [
	# Bad: ld a, [hl] / inc|dec hl
	# Good: ld a, [hli|hld]
	(lambda line1, prev: line1.code == 'ld a, [hl]'),
	(lambda line2, prev: line2.code in {'inc hl', 'dec hl'}),
],
'a == 0': [
	# Bad: cp|or 0
	# Bad: and $ff
	# Good: and|or a
	(lambda line1, prev: re.match(r'(?:cp|or) [%\$&]?0+$', line1.code)
		or re.match(r'and (?:255|-1|\$[Ff][Ff]|%11111111|&377)$', line1.code)),
],
'Tail call': [
	# Bad: call Foo / ret (unless Foo messes with the stack)
	# Good: jr|jp Foo
	(lambda line1, prev: line1.code.startswith('call ') and ',' not in line1.code),
	(lambda line2, prev: line2.code == 'ret'),
],
'Tail predef': [
	# Bad: predef Foo / ret
	# Good: predef_jump Foo
	(lambda line1, prev: line1.code.startswith('predef ')),
	(lambda line2, prev: line2.code == 'ret'),
],
'Fallthrough': [
	# Bad: call Foo / ret / Foo: ...
	# Good: fall through to Foo: ...
	(lambda line1, prev: line1.code.startswith('call ') and ',' not in line1.code),
	(lambda line2, prev: line2.code == 'ret'),
	(lambda line3, prev: line3.code.rstrip(':') == prev[0].code[4:].strip()),
],
'Conditional call': [
	# Bad: jr z|nz|c|nc, .skip / call Foo / .skip
	# Good: call nz|z|nc|c, Foo
	# Bad: jr z|nz|c|nc, .ok / call Foo / jr .ok
	# Good: call nz|z|nc|c, Foo / jr .ok
	(lambda line1, prev: re.match(r'j[rp] n?[zc],', line1.code)),
	(lambda line2, prev: line2.code.startswith('call ') and ',' not in line2.code),
	(lambda line3, prev: (re.match(r'j[rp] ', line3.code) and ',' not in line3.code
		and line3.code.split()[-1].strip() == prev[0].code.split(',')[1].strip())
		or line3.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
],
'Conditional fallthrough': [
	# Bad: jr z|nz|c|nc, .foo / jr .bar / .foo: ...
	# Good: jr nz|z|nc|c .bar / .foo: ...
	(lambda line1, prev: re.match(r'j[rp] n?[zc],', line1.code)),
	(lambda line2, prev: re.match(r'j[rp] ', line2.code) and ',' not in line2.code
		and line2.code != 'jp hl'),
	(lambda line3, prev: line3.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
],
'call hl': [
	# Bad: ld bc|de, Foo / push bc|de / jp hl / Foo: ...
	# Good: call _hl_ (defined in home as _hl_:: jp hl)
	(lambda line1, prev: re.match(r'ld (?:bc|de), [^hbd]', line1.code)),
	(lambda line2, prev: line2.code in {'push bc', 'push de'}
		and line2.code[5:7] == prev[0].code[3:5]),
	(lambda line3, prev: line3.code == 'jp hl'),
	(lambda line4, prev: line4.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
],
'Pointless jumps': [
	# Bad: jr|jp Foo / Foo: ...
	# Good: fall through to Foo: ...
	(lambda line1, prev: (line1.code.startswith('jr ') or line1.code.startswith('jp '))
		and ',' not in line1.code),
	(lambda line2, prev: line2.code.rstrip(':') == prev[0].code[3:].strip()
		and (line2.context == prev[0].context or line2.context == line2.code)),
],
'Useless loads': [
	# Bad: ld P, Q / ld P, R (unless the lds have side effects)
	# Good: ld P, R
	(lambda line1, prev: (line1.code.startswith('ld ') or line1.code.startswith('ldh '))
		and ',' in line1.code and not isVolatile(line1.code)),
	(lambda line2, prev: (line2.code.startswith('ld ') or line2.code.startswith('ldh '))
		and ',' in line2.code and line2.code.split(',')[0] == prev[0].code.split(',')[0]),
],
'Redundant loads': [
	# Bad: ld P, Q / ld Q, P (unless the lds have side effects)
	# Good: ld P, Q
	(lambda line1, prev: (line1.code.startswith('ld ') or line1.code.startswith('ldh '))
		and ',' in line1.code and not isVolatile(line1.code)),
	(lambda line2, prev: (line2.code.startswith('ld ') or line2.code.startswith('ldh '))
		and ',' in line2.code
		and line2.code[3:].split(',')[0].strip() == prev[0].code.split(',')[1].strip()
		and line2.code.split(',')[1].strip() == prev[0].code[3:].split(',')[0].strip()
		and line2.context == prev[0].context),
],
'Similar loads': [
	# Bad: ld P, X / ld a, X (unless the lds have side effects)
	# Good: ld a, X / ld P, a (if possible)
	(lambda line1, prev: (line1.code.startswith('ld ') or line1.code.startswith('ldh '))
		and ',' in line1.code and not isVolatile(line1.code)
		and line1.code.split(',')[1].strip() not in 'afbcdehl'),
	(lambda line2, prev: line2.code.startswith('ld a,')
		and line2.code.split(',')[1] == prev[0].code.split(',')[1]),
],
'Conditionally load 0': [
	# Bad: and|or X / jr|jp nz, .foo / ld P, 0
	# Good: and|or X / jr|jp nz, .foo / ld P, a (if possible)
	(lambda line1, prev: line1.code.startswith('and ') or line1.code.startswith('or ')),
	(lambda line2, prev: re.match(r'j[rp] nz,', line2.code)),
	(lambda line3, prev: re.match(r'ld .+, [%\$&]?0+$', line3.code)),
],
'Inefficient prefix opcodes': [
	# Bad: rl|rlc|rr|rrc a (unless you need the z flag set for 0)
	# Good: rla|rlca|rra|rrca
	(lambda line1, prev: line1.code in {'rl a', 'rlc a', 'rr a', 'rrc a'}),
],
'Redundant and|or': [
	# Bad: and|or|xor X / and|or a
	# Good: and|or|xor N
	(lambda line1, prev: line1.code.startswith('and ')
		or line1.code.startswith('or ')
		or line1.code.startswith('xor ')),
	(lambda line2, prev: line2.code in {'and a', 'or a', 'and a, a', 'or a, a'}),
],
'Pointless and|or a': [
	# Bad: and|or a / (any instruction that affects z and c)
	# Good: (the instruction that affects z and c)
	(lambda line1, prev: line1.code in {'and a', 'or a', 'and a, a', 'or a, a'}),
	(lambda line2, prev: line2.code in {'rlca', 'rrca', 'rla', 'rra', 'daa', 'pop af'}
		or any(line2.code.startswith(x) for x in
			{'add ', 'adc ', 'sub ', 'sbc ', 'and ', 'or ', 'xor ', 'cp ',
			'rlc ', 'rrc ', 'rl ', 'rr ', 'sla ', 'sra ', 'swap ', 'srl ',
			'ld hl, sp', 'ldhl sp'})),
],
'Redundant inc|dec': [
	# Bad: ld P, N / inc|dec P (unless the inc|dec flags are needed)
	# Good: ld P, X+/-1
	(lambda line1, prev: re.match(r'ld .+, [^afbcdehl\[]', line1.code)),
	(lambda line2, prev: (line2.code.startswith('inc ') or line2.code.startswith('dec '))
		and line2.code[4:].strip() == prev[0].code.split(',')[0][2:].strip()),
],
'Redundant ret': [
	# Bad: ret z|nz|c|nc / ret
	# Bad: ret / ret z|nz|c|nc
	# Bad: ret z / ret nz
	# Good: ret
	(lambda line1, prev: line1.code == 'ret' or line1.code.startswith('ret ')),
	(lambda line2, prev: line2.code == 'ret' or line2.code.startswith('ret ')
		and (prev[0].code == 'ret' or
			line2.code.split()[-1].lstrip('n') == prev[0].code.split()[-1].lstrip('n'))),
],
'Stub function': [
	# Bad: call [z|nz|c|nc,] Foo / ... / Foo: / ret
	# Good: (do nothing)
	#
	# Bad: jr|jp [z|nz|c|nc,] Foo / ... / Foo: / ret
	# Good: ret [z|nz|c|nc]
	(lambda line1, prev: re.match(r'[A-Za-z_\.]', line1.text[0])
		and ' ' not in line1.code
		and line1.code.lower() not in {'endc', 'endr', 'endm'}),
	(lambda line2, prev: line2.code == 'ret'),
],
'Stub jump': [
	# Bad: call [z|nz|c|nc,] Foo / ... / Foo: / jr Bar
	# Good: call [z|nz|c|nc,] Bar
	#
	# Bad: jr|jp [z|nz|c|nc,] Foo / ... / Foo: / jr Bar
	# Good: jr|jp [z|nz|c|nc,] Bar
	(lambda line1, prev: re.match(r'[A-Za-z_\.]', line1.text[0])
		and ' ' not in line1.code
		and line1.code.lower() not in {'endc', 'endr', 'endm'}),
	(lambda line2, prev: line2.code.startswith('jr ') and ',' not in line2.code),
],
}

# Count the total instances of the pattern
count = 0

# Check all the .asm files
for filename in iglob('**/*.asm', recursive=True):
	printed = False
	# Read each file line by line
	with open(filename, 'r') as f:
		try:
			lines = [text.rstrip() for text in f]
			n = len(lines)
		except UnicodeDecodeError as ex:
			print('ERROR!!! %s: %s\n' % (filename, str(ex)))
			continue
	# Apply each pattern to the lines
	for pattern_name, conditions in patterns.items():
		printed_this = False
		cur_label = None
		prev_lines = []
		state = 0
		# Iterate over the lines
		i = 0
		while i < n:
			text = lines[i]
			# Remove comments
			code = text.split(';')[0].rstrip()
			comment = text.split(';', 1)[1].strip() if ';' in text else ''
			# Skip blank lines:
			if not code:
				i += 1
				continue
			# Save the most recent label for context
			if (code[0].isalpha() or code[0] == '_') and ':' in code:
				cur_label = Line(i+1, code, comment, text, code)
			# Remove indentation from code, if any
			code = code.lstrip()
			# Record the line's properties
			context = cur_label.code if cur_label else ''
			cur_line = Line(i+1, code, comment, text, context)
			# Check the condition for the current state
			condition = conditions[state]
			allow_rewind = type(condition) == tuple
			if allow_rewind:
				rewind_count, condition = condition
			skip = comment.lower().startswith(SUPPRESS + ' ' + pattern_name.lower())
			if condition(cur_line, prev_lines) and not skip:
				# The condition was met; advance to the next state
				prev_lines.append(cur_line)
				state += 1
				if state == len(conditions):
					# All the conditions were met; print the result and reset the state
					count += 1
					if not printed_this and len(patterns) > 1:
						print('###', pattern_name, '###')
					if cur_label:
						prev_lines.insert(0, cur_label)
					for line in prev_lines:
						print(filename, line.num, line.text, sep=':')
					printed = True
					printed_this = True
					prev_lines = []
					state = 0
			elif allow_rewind and not skip:
				# The condition was not met; go back to a previous condition
				i -= 1
				state -= rewind_count
			else:
				# The condition was not met; reset the state
				i -= state
				prev_lines = []
				state = 0
			i += 1
	# Print a blank line between different files
	if printed:
		print()

# Print the total count
print('Found', count, 'instances.')

exit(count)
