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

# Each line has three properties:
# - num (1, 2, 3, etc)
# - code (no indent or comment)
# - text (the whole line of text)
Line = namedtuple('Line', ['num', 'code', 'text'])

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
'Fancy nops': [
	# Bad: ld b, b (or other identical registers)
	# Good: nop (or omit)
	(lambda line1, prev: re.match(r'ld ([abcdehl]), \1', line1.code)),
],
'Inefficient HRAM load': [
	# Bad: ld a, [hFoo] (or [rFoo])
	# Good: ldh a, [hFoo]
	(lambda line1, prev: re.match(r'ld a, \[[hr][^l]', line1.code)),
],
'Inefficient HRAM store': [
	# Bad: ld [hFoo], a (or [rFoo])
	# Good: ldh [hFoo], a
	(lambda line1, prev: re.match(r'ld \[[hr][^l]', line1.code) and
		line1.code.endswith(', a')),
],
# 'a = 0': [
# 	# Bad: ld a, 0
# 	# Good: xor a (unless you need to preserve flags)
# 	(lambda line1, prev: re.match(r'ld a, [%\$]?0+$', line1.code)),
# ],
'a = ~a': [
	# Bad: xor $ff
	# Good: cpl
	(lambda line1, prev: re.match(r'xor (?:255|-1|\$[Ff][Ff]|%11111111)', line1.code)),
],
'a = N - a': [
	# Bad: ld b, a / ld a, N / sub b (or other intermediate registers)
	# Good: cpl / add N + 1
	(lambda line1, prev: re.match(r'ld [bcdehl], a', line1.code)),
	(lambda line2, prev: re.match(r'ld a, [^afbcdehl\[]', line2.code)),
	(lambda line3, prev: re.match(r'sub [bcdehl]', line3.code) and
		line3.code[4] == prev[0].code[3]),
],
'a = carry ? P : Q': [
	# Bad: ld a, P / jr c|nc, .ok / ld a, Q / .ok
	# Bad: ld a, P / jr c|nc, .ok / xor a / .ok
	# Good: solutions involving sbc a
	(lambda line1, prev: re.match(r'ld a, [^afbcdehl\[]', line1.code)),
	(lambda line2, prev: re.match(r'j[rp] n?c,', line2.code)),
	(lambda line3, prev: re.match(r'ld a, [^afbcdehl\[]', line3.code) or
		line3.code == 'xor a'),
	(lambda line4, prev: line4.code.rstrip(':') == prev[1].code.split(',')[1].strip()),
],
'a = a >> 3': [
	# Bad: srl a / srl a / srl a
	# Good: rrca / rrca / rrca / and %00011111
	(lambda line1, prev: line1.code == 'srl a'),
	(lambda line2, prev: line2.code == 'srl a'),
	(lambda line3, prev: line3.code == 'srl a'),
],
'hl|bc|de += a|N': [
	# Bad: add l|N / ld l, a / ld a, h|0 / adc 0|h / ld h, a (hl or bc or de)
	# Good: add l|N / ld l, a / adc h / sub l / ld h, a
	(lambda line1, prev: re.match(r'add (?:[lce]|[^afbdh\[])', line1.code)),
	(lambda line2, prev: re.match(r'ld [lce], a', line2.code) and
		(line2.code[3] == prev[0].code[4] or prev[0].code[4] not in 'lce')),
	(lambda line3, prev: re.match(r'ld a, (?:[hbd]|[%\$]?0+$)', line3.code) and
		(line3.code[6] not in 'hbd' or line3.code[6] == PAIRS[prev[1].code[3]])),
	(lambda line4, prev: re.match(r'adc (?:[hbd]|[%\$]?0+$)', line4.code) and
		(line4.code[4] not in 'hbd' or line4.code[4] == PAIRS[prev[1].code[3]])),
	(lambda line5, prev: re.match(r'ld [hbd], a', line5.code) and
		line5.code[3] == PAIRS[prev[1].code[3]]),
],
'hl|bc|de += a|N (with jump)': [
	# Okay: add l|N / ld l, a / jr nc, .noCarry / inc h / .noCarry
	# Good: add l|N / ld l, a / adc h / sub l / ld h, a
	(lambda line1, prev: re.match(r'add (?:[lce]|[^afbdh\[])', line1.code)),
	(lambda line2, prev: re.match(r'ld [lce], a', line2.code) and
		(line2.code[3] == prev[0].code[4] or prev[0].code[4] not in 'lce')),
	(lambda line3, prev: re.match(r'j[rp] nc,', line3.code)),
	(lambda line4, prev: re.match(r'inc [hbd]', line4.code) and
		line4.code[4] == PAIRS[prev[1].code[3]]),
	(lambda line5, prev: line5.code.rstrip(':') == prev[2].code.split(',')[1].strip()),
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
	# Good: ld hl, Foo+1 / ld a, [hld] / ld h, [hl] / ld l, a
	(lambda line1, prev: re.match(r'ld a, \[[^hbd]', line1.code)),
	(lambda line2, prev: re.match(r'ld [lh], a', line2.code)),
	(lambda line3, prev: re.match(r'ld a, \[[^hbd]', line3.code) and
		re.split(r'[^A-Za-z0-9_\.\$%]', line3.code[7:])[0] ==
			re.split(r'[^A-Za-z0-9_\.\$%]', prev[0].code[7:])[0]),
	(lambda line4, prev: re.match(r'ld [lh], a', line4.code) and
		line4.code[3] == PAIRS[prev[1].code[3]]),
],
'h,l|b,c|d,e = P,Q': [
	# Bad: ld b, P / ld c, Q
	# Good: lb bc, P, Q
	(lambda line1, prev: re.match(r'ld [hlbcde], [^afbcdehl\[]', line1.code)),
	(lambda line2, prev: re.match(r'ld [hlbcde], [^afbcdehl\[]', line2.code) and
		line2.code[3] == PAIRS[prev[0].code[3]]),
],
# '*hl = N': [
# 	# Bad: ld a, N / ld [hl], a (unless you need N in a too)
# 	# Good: ld [hl], N
# 	(lambda line1, prev: re.match(r'ld a, [^afbcdehl\[]', line1.code)),
# 	(lambda line2, prev: line2.code == 'ld [hl], a'),
# ],
'*hl++ or *hl--': [
	# Bad: ld a, [hl] / inc|dec a / ld [hl], a
	# Good: inc|dec [hl] (before ld a, [hl] if you need [hl] in a too)
	(lambda line1, prev: line1.code == 'ld a, [hl]'),
	(lambda line2, prev: line2.code in {'inc a', 'dec a'}),
	(lambda line3, prev: line3.code == 'ld [hl], a'),
],
'*hl++ = a or *hl-- = a': [
	# Bad: ld [hl], a / inc|dec hl
	# Good: ld [hli|hld], a
	(lambda line1, prev: line1.code == 'ld a, [hl]'),
	(lambda line2, prev: line2.code in {'inc hl', 'dec hl'}),
],
'a == 0': [
	# Bad: cp 0
	# Good: and|or a
	(lambda line1, prev: re.match(r'cp [%\$]?0+$', line1.code)),
],
'Tail call': [
	# Bad: call Foo / ret (unless Foo messes with the stack, e.g. JumpTable)
	# Good: jr|jp Foo
	(lambda line1, prev: line1.code.startswith('call ') and
		',' not in line1.code and line1.code != 'call JumpTable'),
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
	(lambda line1, prev: line1.code.startswith('call ') and
		',' not in line1.code),
	(lambda line2, prev: line2.code == 'ret'),
	(lambda line3, prev: line3.code.rstrip(':') == prev[0].code[4:].strip()),
],
'call hl': [
	# Bad: ld bc|de, Foo / push bc|de / jp hl / Foo: ...
	# Good: call _hl_ (defined in home as _hl_:: jp hl)
	(lambda line1, prev: re.match(r'ld (?:bc|de), [^hbd]', line1.code)),
	(lambda line2, prev: line2.code in {'push bc', 'push de'} and
		line2.code[5:7] == prev[0].code[3:5]),
	(lambda line3, prev: line3.code == 'jp hl'),
	(lambda line4, prev: line4.code.rstrip(':') == prev[0].code.split(',')[1].strip()),
],
'Pointless jumps': [
	# Bad: jr|jp Foo / Foo: ...
	# Good: fall through to Foo: ...
	(lambda line1, prev: (line1.code.startswith('jr ') or
			line1.code.startswith('jp ')) and
		',' not in line1.code),
	(lambda line2, prev: line2.code.rstrip(':') == prev[0].code[3:].strip()),
],
'Useless loads': [
	# Bad: ld P, Q / ld P, R (unless the lds have side effects)
	# Good: ld P, R
	(lambda line1, prev: (line1.code.startswith('ld ') or line1.code.startswith('ldh ')) and
		',' in line1.code and '[hli]' not in line1.code and '[hld]' not in line1.code),
	(lambda line2, prev: (line2.code.startswith('ld ') or line2.code.startswith('ldh ')) and
		',' in line2.code and '[hli]' not in line2.code and '[hld]' not in line2.code and
		line2.code.split(',')[0] == prev[0].code.split(',')[0]),
],
'Redundant loads': [
	# Bad: ld P, Q / ld Q, P (unless the lds have side effects)
	# Good: ld P, Q
	(lambda line1, prev: (line1.code.startswith('ld ') or line1.code.startswith('ldh ')) and
		',' in line1.code and '[hli]' not in line1.code and '[hld]' not in line1.code),
	(lambda line2, prev: (line2.code.startswith('ld ') or line2.code.startswith('ldh ')) and
		',' in line2.code and '[hli]' not in line2.code and '[hld]' not in line2.code and
		line2.code[2:].split(',')[0].strip() == prev[0].code.split(',')[1].strip() and
		line2.code.split(',')[1].strip() == prev[0].code[2:].split(',')[0].strip()),
],
'Inefficient prefix opcodes': [
	# Bad: rl|rlc|rr|rrc a (unless you need the z flag set for 0)
	# Good: rla|rlca|rra|rrca
	(lambda line1, prev: line1.code in {'rl a', 'rlc a', 'rr a', 'rrc a'}),
],
'Redundant and': [
	# Bad: and N / and|or a
	# Good: and N
	(lambda line1, prev: line1.code.startswith('and ')),
	(lambda line2, prev: line2.code in {'and a', 'or a'}),
],
'Redundant ret': [
	# Bad: ret z|nz|c|nc / ret
	# Bad: ret / ret z|nz|c|nc
	# Bad: ret z / ret nz
	# Good: ret
	(lambda line1, prev: line1.code == 'ret' or line1.code.startswith('ret ')),
	(lambda line2, prev: line2.code == 'ret' or line2.code.startswith('ret ') and
		(prev[0].code == 'ret' or line2.code.split()[-1].lstrip('n') == prev[0].code.split()[-1].lstrip('n'))),
],
}

# Count the total instances of the pattern
count = 0

# Check all the .asm files
for filename in iglob('**/*.asm', recursive=True):
	printed = False
	for pattern_name, conditions in patterns.items():
		with open(filename, 'r') as f:
			printed_this = False
			cur_label = None
			prev_lines = []
			state = 0
			# Read each file line by line
			for i, text in enumerate(f):
				text = text.rstrip()
				# Remove comments
				code = text.split(';')[0].rstrip()
				# Skip blank lines:
				if not code:
					continue
				# Save the most recent label for context
				if code[0].isalpha() and ':' in code:
					cur_label = Line(i+1, code, text)
					continue
				# Remove indentation from code, if any
				code = code.lstrip()
				# Record the line's properties
				cur_line = Line(i+1, code, text)
				# Check the condition for the current state
				condition = conditions[state]
				if condition(cur_line, prev_lines):
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
				else:
					# The condition was not met; reset the state
					prev_lines = []
					state = 0
	# Print a blank line between different files
	if printed:
		print()

# Print the total count
print('Found', count, 'instances.')
