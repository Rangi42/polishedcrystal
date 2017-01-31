#!/usr/bin/env python

"""Convert a .pal file to a .html file for viewing."""

from __future__ import print_function

import sys
import os.path

def process(filepath):
	with open(filepath, 'r') as f:
		dir, filename = os.path.split(filepath)
		basename, ext = filename.rsplit('.', 1)
		if ext.lower() != 'pal':
			print('error: must input a .pal file', file=sys.stderr)
			sys.exit(2)
		content = convert_to_html(f.read())
		outname = basename + '.html'
		outpath = os.path.join(dir, outname)
		with open(outpath, 'w') as g:
			g.write(content)

def convert_to_html(content):
	html = ('<!DOCTYPE html>\n<body style="background: #101010;">\n'
		'<table border="1" cellpadding="10" cellspacing="0">\n<tr>\n<td>\n')
	n = 0
	for line in content.split('\n'):
		line = line.split(';')[0].lstrip()
		if line.startswith('RGB'):
			rgb = tuple(int(c, 10) * 8 for c in line[3:].split(','))
			html += ('<span style="background: rgb(%d, %d, %d);">&nbsp;&nbsp;'
				'&nbsp;&nbsp;&nbsp;</span>\n' % rgb)
			n += 1
			if not n % (4 * 8):
				html += '</td>\n<td>\n'
			elif not n % 4:
				html += '<br>\n'
	html += '</td>\n</tr>\n</table>\n</body>\n</html>\n'
	html = html.replace('<td>\n</td>\n', '')
	return html

def main():
	if len(sys.argv) < 2:
		print('Usage: %s foo.pal', file=sys.stderr)
		print('       Convert foo.pal file to foo.html file for viewing', file=sys.stderr)
		sys.exit(1)
	process(sys.argv[1])

if __name__ == '__main__':
	main()
