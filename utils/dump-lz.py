#!/usr/bin/env python

from __future__ import print_function

import sys

# Control commands occupy bits 5-7.
# Bits 0-4 serve as the first parameter n for each command.
LZ_LITERAL   = 0x00 # n values for n bytes
LZ_ITERATE   = 0x01 # one value for n bytes
LZ_ALTERNATE = 0x02 # alternate two values for n bytes
LZ_BLANK     = 0x03 # zero for n bytes
# Repeater commands repeat any data that was just decompressed.
# They take an additional signed parameter s to mark a relative starting point.
# These wrap around (positive from the start, negative from the current position).
LZ_REPEAT    = 0x04 # n bytes starting from s
LZ_FLIP      = 0x05 # n bytes in reverse bit order starting from s
LZ_REVERSE   = 0x06 # n bytes backwards starting from s
# The long command is used when 5 bits aren't enough. Bits 2-4 contain a new control code.
# Bits 0-1 are appended to a new byte as 8-9, allowing a 10-bit parameter.
LZ_LONG      = 0x07 # n is now 10 bits for a new control code
# If 0xff is encountered instead of a command, decompression ends.
LZ_END       = 0xff # decompression ends

def get_byte(s, i):
	b = s[i]
	if type(b) == bytes:
		b = ord(b)
	return b

def describe(filename):
	with open(filename, 'rb') as f:
		data = f.read()
	filesize = len(data)

	print('Compressed: %d bytes' % filesize)

	address = marker = 0
	output = []
	while address < filesize:
		b = get_byte(data, address); address += 1

		if b == LZ_END:
			print('  END')
			break

		cmd = (b & 0b11100000) >> 5
		length = 0
		long = False
		if cmd == LZ_LONG:
			long = True
			cmd = (b & 0b00011100) >> 2
			length = (b & 0b00000011) * 0x100
			b = get_byte(data, address); address += 1
			length += b + 1
		else:
			length = (b & 0b00011111) + 1

		if cmd == LZ_LITERAL:
			qs = [get_byte(data, address+i) for i in range(length)]
			output.extend(qs)
			qs = ['$%02x' % q for q in qs]
			print('  LITERAL %d bytes: %s' % (length, ' '.join(qs)))
			address += length
			marker += length
		elif cmd == LZ_ITERATE:
			b = get_byte(data, address); address += 1
			output.extend([b] * length)
			print('  ITERATE $%02x for %d bytes' % (b, length))
			marker += length
		elif cmd == LZ_ALTERNATE:
			q0 = get_byte(data, address); address += 1
			q1 = get_byte(data, address); address += 1
			output.extend([q0, q1] * (length // 2))
			print('  ALTERNATE $%02x and $%02x %d times' % (q0, q1, length//2))
			marker += length
		elif cmd == LZ_BLANK:
			output.extend([0x00] * length)
			print('  BLANK %d bytes' % length)
			marker += length
		elif cmd in {LZ_REPEAT, LZ_FLIP, LZ_REVERSE}:
			b = get_byte(data, address); address += 1
			if b >= 0b10000000:
				offset = marker - (b & 0b01111111) - 1
			else:
				c = get_byte(data, address); address += 1
				offset = b * 0x100 + c
			names = {LZ_REPEAT: 'REPEAT', LZ_FLIP: 'FLIP', LZ_REVERSE: 'REVERSE'}
			name = names[cmd]
			if cmd == LZ_REPEAT:
				qs = [output[offset+i] for i in range(length)]
			elif cmd == LZ_REVERSE:
				qs = [output[offset-i] for i in range(length)]
			elif cmd == LZ_FLIP:
				qs = [output[offset+i] for i in range(length)]
				qs = [sum(((q >> i) & 1) << (7 - i) for i in range(8)) for q in qs]
			output.extend(qs)
			qs = ['$%02x' % q for q in qs]
			print('  %s %d bytes from offset $%04x (relative -%d): %s' % (name, length, offset,
				len(output) - len(qs) - offset, ' '.join(qs)))
			marker += length
		else:
			print('* ERROR: invalid command byte $%02x at $%04x' % (b, address))

	print('Decompressed: %d bytes' % marker)

def main():
	if len(sys.argv) < 2:
		print('Usage: %s FILE.lz' % sys.argv[0])
		print('       Describe the opcodes in an LZ file')
		sys.exit(1)
	filename = sys.argv[1]
	describe(filename)

if __name__ == '__main__':
	main()
