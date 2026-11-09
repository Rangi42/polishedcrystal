#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import glob

for name in glob.iglob(f'**/*.asm', recursive=True):
	with open(name, 'r', encoding='utf-8') as f:
		data = f.read()
	if data.endswith('\n\n') or not data.endswith('\n'):
		data = data.rstrip('\n') + '\n'
		with open(name, 'w', encoding='utf-8') as f:
			f.write(data)
