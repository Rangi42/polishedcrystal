#!/usr/bin/env python3
"""Regression tests for the optimizer's CLI output and exit status."""

import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


SCRIPT = Path(__file__).with_name('optimize.py').resolve()


class OptimizeTests(unittest.TestCase):
	def setUp(self):
		self.temp = tempfile.TemporaryDirectory()
		self.addCleanup(self.temp.cleanup)
		self.root = Path(self.temp.name)

	def write(self, name, text):
		path = self.root / name
		path.parent.mkdir(parents=True, exist_ok=True)
		path.write_text(text, encoding='utf-8')
		return path

	def run_optimizer(self, *args):
		result = subprocess.run(
			[sys.executable, str(SCRIPT), *map(str, args)],
			cwd=self.root, capture_output=True, text=True, encoding='utf-8',
		)
		self.assertEqual(result.stderr, '')
		return result

	def test_default_output_and_finding_count(self):
		self.write('example.asm', 'Example:\n\tld b, b\n\tld c, c\n')
		result = self.run_optimizer('example.asm')
		self.assertEqual(result.returncode, 2)
		self.assertEqual(result.stdout,
			'### No-op ld ###\n'
			'example.asm:1:Example:\nexample.asm:2:\tld b, b\n'
			'example.asm:1:Example:\nexample.asm:3:\tld c, c\n'
			'\nFound 2 instances.\n')

	def test_annotation_points_to_instruction_not_context_label(self):
		path = self.write('example.asm', 'Example:\n\n; comment\n\tld b, b\n')
		result = self.run_optimizer('--github-actions', path)
		self.assertEqual(result.returncode, 1)
		filename = path.as_posix().replace(':', '%3A')
		self.assertEqual(result.stdout,
			f'::error file={filename},line=4,endLine=4::No-op ld%0A\tld b, b\n'
			'Found 1 instances.\n')

	def test_multiline_match_spans_original_line_numbers(self):
		self.write('example.asm',
			'Example:\n\tld a, [wFoo]\n; comment\n\n\tinc a\n\tld [wFoo], a\n')
		result = self.run_optimizer('--github-actions', 'example.asm')
		self.assertEqual(result.returncode, 1)
		self.assertIn(',line=2,endLine=6::Inefficient WRAM increment/decrement'
			'%0A\tld a, [wFoo]%0A\tinc a%0A\tld [wFoo], a\n', result.stdout)
		self.assertTrue(result.stdout.endswith('Found 1 instances.\n'))

	def test_no_findings_in_both_modes(self):
		self.write('empty.asm', '; only a comment\n')
		self.write('clean.asm', 'Example:\n\txor a\n')
		for flags in ((), ('--github-actions',)):
			with self.subTest(flags=flags):
				result = self.run_optimizer(*flags)
				self.assertEqual(result.returncode, 0)
				self.assertEqual(result.stdout, 'Found 0 instances.\n')

	def test_recursive_default_path_and_suppression(self):
		self.write('nested/example.asm', 'Example:\n\tld b, b\n')
		self.write('suppressed.asm', '\tld c, c ; no-optimize No-op ld\n')
		self.write('ignored.txt', '\tld d, d\n')
		result = self.run_optimizer('--github-actions')
		self.assertEqual(result.returncode, 1)
		self.assertEqual(result.stdout.count('::error file='), 1)
		self.assertIn('/nested/example.asm,line=2,endLine=2::', result.stdout)
		self.assertTrue(result.stdout.endswith('Found 1 instances.\n'))

	def test_multiple_file_arguments(self):
		self.write('one.asm', '\tld b, b\n')
		self.write('two.asm', '\tld c, c\n')
		result = self.run_optimizer('--github-actions', 'one.asm', 'two.asm')
		self.assertEqual(result.returncode, 1)
		self.assertEqual(result.stdout.count('::error file='), 2)
		self.assertTrue(result.stdout.endswith('Found 2 instances.\n'))

	def test_percent_and_command_like_source_are_escaped(self):
		self.write('odd%,name.asm', '\tld b, b ; 100%25 ::warning::example\n')
		result = self.run_optimizer('--github-actions', 'odd%,name.asm')
		self.assertEqual(result.returncode, 1)
		self.assertEqual(len(result.stdout.splitlines()), 2)
		self.assertIn('/odd%25%2Cname.asm,line=1,endLine=1::', result.stdout)
		self.assertIn('No-op ld%0A\tld b, b ; 100%2525 ::warning::example\n', result.stdout)

	@unittest.skipIf(os.name == 'nt', 'Windows disallows colons and newlines in filenames')
	def test_colon_cr_lf_in_filename_cannot_inject_commands(self):
		name = 'odd:%,\r\n::warning::name.asm'
		self.write(name, '\tld b, b\n')
		result = self.run_optimizer('--github-actions', name)
		self.assertEqual(result.returncode, 1)
		self.assertEqual(len(result.stdout.splitlines()), 2)
		self.assertIn('/odd%3A%25%2C%0D%0A%3A%3Awarning%3A%3Aname.asm,', result.stdout)

	def test_256_findings_still_fail_in_annotation_mode(self):
		self.write('many.asm', 'Example:\n\tld b, b\n' * 256)
		result = self.run_optimizer('--github-actions', 'many.asm')
		self.assertEqual(result.returncode, 1)
		self.assertEqual(result.stdout.count('::error file='), 256)
		self.assertTrue(result.stdout.endswith('Found 256 instances.\n'))


if __name__ == '__main__':
	unittest.main()
