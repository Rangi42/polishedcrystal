#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Search all .asm files for N code lines in a row that match some conditions.
"""

from collections import namedtuple
from glob import iglob

# Regular expressions are useful for text processing
import re

# Each line has three properties:
# - num (1, 2, 3, etc)
# - code (no indent or comment)
# - text (the whole line of text)
Line = namedtuple('Line', ['num', 'code', 'text'])

# A set of named patterns of suboptimal code
# Make lists of N conditions to check in N lines
# prev_lines[-1] is the previous line, prev_lines[-2] is before that one, etc
# For details on how to optimize these patterns:
# https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code
patterns = {
'Tail call': [
	# Bad: call Foo / ret
	# Good: jp Foo (or 'jr Foo' if Foo is close by)
	(lambda line1, prev_lines: line1.code.startswith('call ')
		and ',' not in line1.code),
	(lambda line2, prev_lines: line2.code == 'ret'),
],
'Tail predef': [
	# Bad: predef Foo / ret
	# Good: predef_jump Foo
	(lambda line1, prev_lines: line1.code.startswith('predef ')),
	(lambda line2, prev_lines: line2.code == 'ret'),
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
						if not printed_this:
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
