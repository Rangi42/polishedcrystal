#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Based on GBDirStat by SuperDisk
<https://gist.github.com/SuperDisk/fd518f746501a78b7cd0a599c93cc119>
"""

import re
import sys

import pandas
import plotly.express as plotly_express

default_filename = 'polishedcrystal-debug-3.0.0-beta.map'

def get_map_records(filename):
	cur_bank = None
	cur_section = None
	cur_label = None
	cur_offset = 0
	with open(filename, 'r', encoding='utf8') as file:
		for line in file:
			line = line.rstrip()
			if (m := re.match(r'^\w+ bank #(\d+):', line)):
				cur_bank = int(m.group(1))
			elif (m := re.match(r'^ +SECTION: \$([0-9a-f]+)-.+ \["(.+)"\]$', line)):
				cur_offset = int(m.group(1), 16)
				cur_section = m.group(2)
			elif (m := re.match(r'^ +\$([0-9a-f]+) = ([A-Za-z_@#.]+)$', line)):
				offset = int(m.group(1), 16)
				label = m.group(2)
				if offset == cur_offset:
					continue
				yield dict(
					bank = f'BANK ${cur_bank:02X}',
					section = cur_section,
					label = cur_label,
					size = offset - cur_offset,
				)
				cur_label = label
				cur_offset = offset

def make_treemap(filename):
	records = get_map_records(filename)
	dataframe = pandas.DataFrame(records)
	figure = plotly_express.treemap(
		dataframe,
		path = [plotly_express.Constant('ROM'), 'bank', 'section', 'label'],
		values = 'size',
		color_continuous_scale = 'RdBu',
	)
	figure.update_layout(margin=dict(t=50, l=25, r=25, b=25))
	return figure

def main():
	if len(sys.argv) > 2:
		print(f'Usage: {sys.argv[0]} [file={default_filename}]', file=sys.stderr)
		sys.exit(1)
	filename = sys.argv[1] if len(sys.argv) == 2 else default_filename
	treemap = make_treemap(filename)
	treemap.show()

if __name__ == '__main__':
	main()
