#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Find unreferenced labels from a list.
Usage: utils/unreferenced.py labels.txt > unreferenced.txt
"""

from __future__ import print_function

import sys
import glob
import subprocess

def find_unreferenced_labels(labelfile):
	with open(labelfile, 'r') as f:
		for line in f:
			label = line.strip()
			if line and not is_referenced(label):
				print(label)

def is_referenced(label):
	args = ['grep', '-r', '--include=*.asm', label] + glob.glob('*')
	grep = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	grep_stdout, grep_stderr = grep.communicate()
	return grep_stdout.count(label) > 1

def main():
	if len(sys.argv) < 2:
		print('Usage: %s labels.txt' % sys.argv[0])
		print('       Find unreferenced labels from a list')
		sys.exit(1)

	labelfile = sys.argv[1]
	find_unreferenced_labels(labelfile)

if __name__ == '__main__':
	main()
