#!/usr/bin/env python3
"""Check item-giving macro bytecode and reject implicit full-Bag handling.

Run from any directory with rgbasm and rgblink on PATH:
    python3 utils/test_item_give_macros.py
"""

from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
PRELUDE = '''INCLUDE "macros/const.asm"
INCLUDE "macros/data.asm"
INCLUDE "macros/scripts/events.asm"
SECTION "Test", ROM0[$100]
'''


class ItemGiveMacrosTest(unittest.TestCase):
    def assemble(self, source, *, valid=True):
        with tempfile.TemporaryDirectory() as directory:
            base = Path(directory) / 'test'
            base.with_suffix('.asm').write_text(PRELUDE + source)
            result = subprocess.run(
                ['rgbasm', '-Weverything', '-Werror', '-o', str(base.with_suffix('.o')),
                 str(base.with_suffix('.asm'))],
                cwd=ROOT, capture_output=True, text=True,
            )
            if not valid:
                self.assertNotEqual(result.returncode, 0, source)
                return
            self.assertEqual(result.returncode, 0, result.stderr)
            subprocess.run(
                ['rgblink', '-o', str(base.with_suffix('.gb')),
                 str(base.with_suffix('.o'))],
                cwd=ROOT, check=True, capture_output=True,
            )
            return base.with_suffix('.gb').read_bytes()

    def test_existing_failure_commands_preserve_bytecode(self):
        for macro in ('giveitem', 'verbosegiveitem'):
            for command in ('iffalse .Full', 'iffalsefwd .Full',
                            'iffalse_endtext', 'iffalse_jumpopenedtext .Full',
                            'iftruefwd .Full', 'iftrue .Full'):
                for quantity in (None, 0, 1, 5, 99):
                    with self.subTest(macro=macro, command=command, quantity=quantity):
                        suffix = '' if quantity is None else f', {quantity}'
                        actual = self.assemble(
                            f'Test:\n\t{macro} 1, {command}{suffix}\n.Full:\n\tend\n')
                        expected = self.assemble(
                            f'Test:\n\tdb {macro}_command, 1, {1 if quantity is None else quantity}\n'
                            f'\t{command}\n.Full:\n\tend\n')
                        self.assertEqual(actual, expected)

    def test_variable_quantity_preserves_bytecode(self):
        actual = self.assemble('verbosegiveitemvar 1, 2, iffalse_endtext\n')
        expected = self.assemble('db verbosegiveitemvar_command, 1, 2\niffalse_endtext\n')
        self.assertEqual(actual, expected)

    def test_explicit_opt_out_emits_no_branch(self):
        for macro in ('giveitem', 'verbosegiveitem'):
            with self.subTest(macro=macro):
                self.assertEqual(
                    self.assemble(f'{macro} 1, 0, 99\n'),
                    self.assemble(f'db {macro}_command, 1, 99\n'),
                )
        self.assertEqual(
            self.assemble('verbosegiveitemvar 1, 2, 0\n'),
            self.assemble('db verbosegiveitemvar_command, 1, 2\n'),
        )

    def test_missing_empty_or_invalid_failure_commands_are_rejected(self):
        for macro in ('giveitem', 'verbosegiveitem'):
            for args in ('', '1', '1,', '1, , 5', '1, 5', '1, end',
                         '1, sjump .Full', '1, iffalse_endtext, 5, 6'):
                with self.subTest(macro=macro, args=args):
                    self.assemble(f'{macro} {args}\n.Full:\nend\n', valid=False)
        for args in ('1, 2', '1, 2,', '1, 2, end', '1, 2, iffalse_endtext, 3'):
            with self.subTest(macro='verbosegiveitemvar', args=args):
                self.assemble(f'verbosegiveitemvar {args}\n', valid=False)


if __name__ == '__main__':
    unittest.main()
