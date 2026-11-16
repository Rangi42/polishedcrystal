#!/usr/bin/env python3
"""Optimize pokecrystal-style music .asm files in place.

The optimizer finds repeated runs of sound commands and factors them out into
subroutines (``sound_call``).  Only exact, contiguous runs of ordinary sound
commands are factored, so the sequence of commands executed by every channel is
unchanged.

Usage:
    python music_optimize.py FILE [FILE ...]

The files are modified in place.  A summary is printed to stderr.
"""

from __future__ import annotations

import argparse
import glob
import os
import re
import sys
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Sequence, Tuple

# Commands that transfer control.  They are never put inside a generated
# subroutine, and they delimit the regions that may be optimized.
CONTROL_COMMANDS = {
    "sound_call",
    "sound_jump",
    "sound_jump_if",
    "sound_loop",
    "sound_ret",
    "restart_channel",
    "new_song",
    "unknownmusic0xee",
}

MIN_PATTERN_LEN = 2

# A generated subroutine costs a label line, a final sound_ret, a blank line
# separating it from the previous definition, and the body itself.  Byte costs
# are computed from the real text in find_best_pattern.


# ---------------------------------------------------------------------------
# Line model


@dataclass
class Line:
    body: str
    eol: str
    kind: str = "command"
    name: str = ""
    label: str = ""
    removed: bool = False


def split_eol(text: str) -> Tuple[str, str]:
    if text.endswith("\r\n"):
        return text[:-2], "\r\n"
    if text.endswith("\n"):
        return text[:-1], "\n"
    if text.endswith("\r"):
        return text[:-1], "\r"
    return text, ""


def classify(body: str) -> Tuple[str, str, str]:
    stripped = body.strip()
    if not stripped:
        return "blank", "", ""
    if stripped.startswith(";"):
        return "comment", "", ""
    m = re.match(r"^\s*(\S+):\s*(?:;.*)?$", body)
    if m:
        return "label", "", m.group(1)
    parts = stripped.split(None, 1)
    return "command", parts[0], ""


def normalize(body: str) -> str:
    return " ".join(body.split())


def control_target(body: str) -> Optional[str]:
    """Label referenced by a jump/loop command, if it has one."""
    parts = body.strip().split(None, 1)
    if len(parts) < 2 or parts[0] not in (
        "sound_jump",
        "sound_jump_if",
        "sound_loop",
    ):
        return None
    target = parts[1].split(",")[-1].strip()
    return target or None


def parse_file(path: str) -> Tuple[List[Line], str]:
    with open(path, "r", encoding="utf-8", errors="surrogateescape", newline="") as f:
        text = f.read()
    raw_lines = text.splitlines(keepends=True)
    lines: List[Line] = []
    for raw in raw_lines:
        body, eol = split_eol(raw)
        kind, name, label = classify(body)
        lines.append(Line(body, eol, kind, name, label))
    crlf = sum(1 for ln in lines if ln.eol == "\r\n")
    lf = sum(1 for ln in lines if ln.eol == "\n")
    default_eol = "\r\n" if crlf > lf else "\n"
    return lines, default_eol


# ---------------------------------------------------------------------------
# Music structure


@dataclass
class MusicFile:
    lines: List[Line]
    default_eol: str
    channel_labels: List[str] = field(default_factory=list)
    label_index: Dict[str, int] = field(default_factory=dict)

    def find_channels(self) -> None:
        labels: List[str] = []
        for line in self.lines:
            if line.kind != "command":
                continue
            m = re.match(r"^channel\s+\d+\s*,\s*(\S+)\s*$", line.body.strip())
            if m:
                labels.append(m.group(1))
        self.channel_labels = labels
        for i, line in enumerate(self.lines):
            if line.kind == "label":
                self.label_index.setdefault(line.label, i)

    def channel_ranges(self) -> List[Tuple[str, int, int]]:
        starts = []
        for name in self.channel_labels:
            idx = self.label_index.get(name)
            if idx is not None:
                starts.append((name, idx))
        starts.sort(key=lambda x: x[1])
        result = []
        for i, (name, start) in enumerate(starts):
            end = starts[i + 1][1] if i + 1 < len(starts) else len(self.lines)
            result.append((name, start, end))
        return result

    def called_label_names(self) -> set:
        called = set()
        for line in self.lines:
            if line.kind != "command" or line.name != "sound_call":
                continue
            m = re.match(r"^sound_call\s+(\S+)", line.body.strip())
            if m:
                called.add(m.group(1))
        return called

    def protected_lines(self) -> set:
        """Lines that must not be a source of new sound_calls.

        The pokecrystal engine only stores a single return address, so calls
        cannot be nested.  Code reached through a sound_call therefore cannot
        itself be replaced by a sound_call.  Any labels reachable from that
        code by jumps or loops are protected as well.
        """
        protected = set()
        work: List[str] = list(self.called_label_names())
        visited = set()
        while work:
            label = work.pop()
            if label in visited:
                continue
            visited.add(label)
            start = self.label_index.get(label)
            if start is None:
                continue

            end = len(self.lines)
            for i in range(start + 1, len(self.lines)):
                ln = self.lines[i]
                if ln.kind == "label" and ln.label in self.channel_labels:
                    end = i
                    break
                if ln.kind == "command" and ln.name == "sound_ret":
                    end = i + 1
                    break
            protected.update(range(start, end))

            for i in range(start, end):
                ln = self.lines[i]
                if ln.kind != "command":
                    continue
                target = control_target(ln.body)
                if target is not None:
                    work.append(target)
        return protected

    def build_regions(
        self, start: int, end: int, protected: set
    ) -> Tuple[List[List[int]], List[List[str]]]:
        """Return contiguous optimizable regions and their normalized tokens."""
        regions: List[List[int]] = []
        tokens: List[List[str]] = []
        current_i: List[int] = []
        current_t: List[str] = []

        def flush() -> None:
            nonlocal current_i, current_t
            if current_i:
                regions.append(current_i)
                tokens.append(current_t)
            current_i = []
            current_t = []

        for i in range(start, end):
            ln = self.lines[i]
            kind, name, _label = classify(ln.body)
            if (
                ln.removed
                or i in protected
                or kind != "command"
                or name in CONTROL_COMMANDS
            ):
                flush()
                continue
            current_i.append(i)
            current_t.append(normalize(ln.body))
        flush()
        return regions, tokens


# ---------------------------------------------------------------------------
# Suffix array / LCP


def suffix_array(seq: Sequence[int]) -> List[int]:
    n = len(seq)
    if n == 0:
        return []
    sa = list(range(n))
    rank = list(seq)
    tmp = [0] * n
    k = 1
    while True:
        sa.sort(key=lambda i: (rank[i], rank[i + k] if i + k < n else -1))
        tmp[sa[0]] = 0
        for j in range(1, n):
            a = sa[j - 1]
            b = sa[j]
            ka = rank[a + k] if a + k < n else -1
            kb = rank[b + k] if b + k < n else -1
            tmp[b] = tmp[a] + (1 if (rank[a], ka) != (rank[b], kb) else 0)
        rank, tmp = tmp, rank
        if rank[sa[-1]] == n - 1:
            break
        k *= 2
    return sa


def lcp_array(seq: Sequence[int], sa: Sequence[int]) -> List[int]:
    n = len(seq)
    rank = [0] * n
    for i, p in enumerate(sa):
        rank[p] = i
    lcp = [0] * n
    h = 0
    for i in range(n):
        r = rank[i]
        if r == 0:
            continue
        j = sa[r - 1]
        while i + h < n and j + h < n and seq[i + h] == seq[j + h]:
            h += 1
        lcp[r] = h
        if h:
            h -= 1
    return lcp


@dataclass
class Candidate:
    length: int
    occurrences: List[Tuple[int, int]]  # (region index, offset)
    score: int
    tokens: List[str]


def find_best_pattern(
    regions: List[List[int]],
    tokens: List[List[str]],
    line_bytes: List[int],
    stripped_bytes: List[int],
    indent_bytes: List[int],
    label: str,
    eol_len: int,
) -> Optional[Candidate]:
    """Find the repeated run with the largest net byte saving."""
    if not regions:
        return None

    ids: Dict[str, int] = {}
    seq: List[int] = []
    token_positions: Dict[int, Tuple[int, int]] = {}
    next_id = 0
    next_sep = -1
    for r, toks in enumerate(tokens):
        if not toks:
            continue
        for off, tok in enumerate(toks):
            ident = ids.get(tok)
            if ident is None:
                ident = next_id
                ids[tok] = ident
                next_id += 1
            token_positions[len(seq)] = (r, off)
            seq.append(ident)
        seq.append(next_sep)
        next_sep -= 1

    n = len(seq)
    if n < 2:
        return None

    sa = suffix_array(seq)
    lcp = lcp_array(seq, sa)

    # Maximal suffix-array interval for each LCP value: nearest strictly
    # smaller LCP on the left and right.
    prev_less = [0] * n
    stack: List[int] = []
    for i in range(1, n):
        v = lcp[i]
        while stack and lcp[stack[-1]] >= v:
            stack.pop()
        prev_less[i] = stack[-1] if stack else 0
        stack.append(i)

    next_less = [n] * n
    stack = []
    for i in range(n - 1, 0, -1):
        v = lcp[i]
        while stack and lcp[stack[-1]] >= v:
            stack.pop()
        next_less[i] = stack[-1] if stack else n
        stack.append(i)

    best: Optional[Candidate] = None
    seen = set()

    for i in range(1, n):
        length = lcp[i]
        if length < MIN_PATTERN_LEN:
            continue
        p = prev_less[i]
        q = next_less[i]
        key = (p, q, length)
        if key in seen:
            continue
        seen.add(key)

        by_region: Dict[int, List[int]] = {}
        ok = True
        for start in sa[p:q]:
            pos = token_positions.get(start)
            if pos is None:
                ok = False
                break
            by_region.setdefault(pos[0], []).append(pos[1])
        if not ok:
            continue

        # Maximum number of non-overlapping occurrences.  All intervals have
        # equal length, so choosing by earliest start is optimal.
        chosen: List[Tuple[int, int]] = []
        for r, offs in by_region.items():
            offs.sort()
            last_end = -1
            for off in offs:
                if off >= last_end:
                    chosen.append((r, off))
                    last_end = off + length
        if len(chosen) < 2:
            continue

        # Byte-accurate score.
        r0, off0 = chosen[0]
        first_idxs = regions[r0][off0 : off0 + length]
        first_indent = indent_bytes[first_idxs[0]]
        label_b = len(label.encode("utf-8"))
        call_cost = first_indent + len(b"sound_call ") + label_b + eol_len

        # Cost of the appended definition (label, body, sound_ret, blank line).
        def_cost = label_b + 1 + eol_len
        for j in first_idxs:
            def_cost += first_indent + stripped_bytes[j] + eol_len
        def_cost += first_indent + len(b"sound_ret") + eol_len + eol_len

        saved = 0
        for r, off in chosen:
            idxs = regions[r][off : off + length]
            for j in idxs:
                saved += line_bytes[j]
            saved -= call_cost

        score = saved - def_cost
        if score <= 0:
            continue

        if best is None or (score, length, len(chosen)) > (
            best.score,
            best.length,
            len(best.occurrences),
        ):
            pattern_tokens = tokens[r0][off0 : off0 + length]
            best = Candidate(length, chosen, score, pattern_tokens)

    return best


# ---------------------------------------------------------------------------
# Definitions and suffix sharing


@dataclass(eq=False)
class Definition:
    name: str
    body_tokens: List[str]
    body_lines: List[str]
    indent: str
    channel: str
    child: Optional["Definition"] = None
    parent: Optional["Definition"] = None


def chain_definitions(defs: List[Definition]) -> List[List[Definition]]:
    """Group definitions into fall-through chains sharing common suffixes.

    If one definition's body is a suffix of another's, the longer definition
    can end by falling through into the shorter one.  This removes duplicate
    copies of the shared suffix without nesting sound_calls.
    """
    by_channel: Dict[str, List[Definition]] = {}
    for d in defs:
        by_channel.setdefault(d.channel, []).append(d)

    for group in by_channel.values():
        # Longest first so each definition gets the longest available suffix.
        ordered = sorted(group, key=lambda d: len(d.body_tokens), reverse=True)
        for d in ordered:
            best: Optional[Definition] = None
            best_len = 0
            for other in group:
                if other is d or other.parent is not None:
                    continue
                l = len(other.body_tokens)
                if l <= best_len or l >= len(d.body_tokens):
                    continue
                if d.body_tokens[-l:] == other.body_tokens:
                    best = other
                    best_len = l
            if best is not None:
                d.child = best
                best.parent = d

    # Build chains.  A definition is a head if nothing falls through into it.
    chains: List[List[Definition]] = []
    seen = set()
    for d in defs:
        if d in seen or d.parent is not None:
            continue
        chain: List[Definition] = []
        cur: Optional[Definition] = d
        while cur is not None and cur not in seen:
            seen.add(cur)
            chain.append(cur)
            cur = cur.child
        chains.append(chain)
    # Any definitions left over (should not happen) become their own chains.
    for d in defs:
        if d not in seen:
            chains.append([d])
            seen.add(d)
    return chains


# ---------------------------------------------------------------------------
# Driver


def optimize_file(path: str, verbose: bool = False) -> Tuple[int, int]:
    mf = MusicFile(*parse_file(path))
    mf.find_channels()
    if not mf.channel_labels:
        return (0, 0)

    # Appending ditties at EOF is only safe if execution cannot fall through
    # the end of the file into them.
    last = None
    for ln in mf.lines:
        if ln.kind in ("command", "label"):
            last = ln
    if last is None:
        return (0, 0)
    kind, name, _ = classify(last.body)
    if kind != "command" or name not in ("sound_ret", "sound_jump"):
        return (0, 0)

    protected = mf.protected_lines()
    definitions: List[Definition] = []
    used_labels = set(mf.label_index.keys())
    next_ditty: Dict[str, int] = {}
    eol_len = len(mf.default_eol.encode("utf-8"))
    line_bytes = [
        len(ln.body.encode("utf-8", "surrogateescape")) + len(ln.eol)
        for ln in mf.lines
    ]
    stripped_bytes = [
        len(ln.body.strip().encode("utf-8", "surrogateescape")) for ln in mf.lines
    ]
    indent_bytes = [
        len(ln.body[: len(ln.body) - len(ln.body.lstrip())].encode("utf-8"))
        for ln in mf.lines
    ]

    for channel, cstart, cend in mf.channel_ranges():
        extractions = 0
        while True:
            regions, tokens = mf.build_regions(cstart, cend, protected)
            est_label = f"{channel}_ditty{next_ditty.get(channel, 1)}"
            cand = find_best_pattern(
                regions,
                tokens,
                line_bytes,
                stripped_bytes,
                indent_bytes,
                est_label,
                eol_len,
            )
            if cand is None:
                break
            extractions += 1
            if extractions > 10000:
                raise RuntimeError(f"{path}: pattern extraction did not converge")

            n = next_ditty.get(channel, 1)
            while True:
                label = f"{channel}_ditty{n}"
                n += 1
                if label not in used_labels:
                    break
            next_ditty[channel] = n
            used_labels.add(label)

            first_r, first_off = cand.occurrences[0]
            first_line_idxs = regions[first_r][first_off : first_off + cand.length]
            first_line = mf.lines[first_line_idxs[0]]
            indent = first_line.body[: len(first_line.body) - len(first_line.body.lstrip())] or "\t"
            body_lines = [mf.lines[j].body.strip() for j in first_line_idxs]
            definitions.append(
                Definition(label, cand.tokens, body_lines, indent, channel)
            )

            for r, off in cand.occurrences:
                line_idxs = regions[r][off : off + cand.length]
                first = mf.lines[line_idxs[0]]
                prefix = first.body[: len(first.body) - len(first.body.lstrip())]
                first.body = prefix + f"sound_call {label}"
                first.name = "sound_call"
                for j in line_idxs[1:]:
                    mf.lines[j].removed = True

            if verbose:
                print(
                    f"  {os.path.basename(path)}: {label} <- {cand.length} commands x "
                    f"{len(cand.occurrences)} ({cand.score} bytes saved)",
                    file=sys.stderr,
                )

    # Collapse runs of identical adjacent calls into sound_loop loops.  A loop
    # is only worthwhile for four or more calls (label + call + sound_loop).
    # The engine has a single loop flag/counter per channel, so a generated
    # loop must never be placed inside the body of an existing sound_loop.
    loop_body_lines = set()
    for i, ln in enumerate(mf.lines):
        if ln.removed:
            continue
        body = ln.body.strip()
        m = re.match(r"^sound_loop\s+\d+\s*,\s*(\S+)$", body)
        if not m:
            continue
        target = mf.label_index.get(m.group(1))
        if target is not None and target < i and not mf.lines[target].removed:
            loop_body_lines.update(range(target, i))

    next_loop: Dict[str, int] = {}
    definition_names = {d.name for d in definitions}
    for channel, cstart, cend in mf.channel_ranges():
        i = cstart
        while i < cend:
            ln = mf.lines[i]
            if (
                ln.removed
                or ln.kind != "command"
                or ln.name != "sound_call"
                or i in protected
                or i in loop_body_lines
            ):
                i += 1
                continue
            m = re.match(r"^sound_call\s+(\S+)$", ln.body.strip())
            if not m:
                i += 1
                continue
            target = m.group(1)
            # Only call the generated ditties, whose bodies consist purely of
            # ordinary commands.  An arbitrary pre-existing subroutine could
            # itself use sound_loop, and the engine cannot nest loops.
            if target not in definition_names:
                i += 1
                continue
            run: List[int] = [i]
            j = i + 1
            while j < cend:
                nx = mf.lines[j]
                if nx.removed:
                    # Deleted lines vanish from the output, so the retained
                    # calls on either side become adjacent.
                    j += 1
                    continue
                if (
                    nx.kind != "command"
                    or nx.name != "sound_call"
                    or j in protected
                    or j in loop_body_lines
                    or nx.body.strip() != f"sound_call {target}"
                ):
                    break
                run.append(j)
                j += 1
            if 4 <= len(run) <= 255:
                n = next_loop.get(channel, 1)
                while True:
                    label = f"{channel}_loop_opt{n}"
                    n += 1
                    if label not in used_labels:
                        break
                next_loop[channel] = n
                used_labels.add(label)

                indent = mf.lines[run[0]].body[
                    : len(mf.lines[run[0]].body) - len(mf.lines[run[0]].body.lstrip())
                ] or "\t"
                # Reuse the first three lines of the run for the new block.
                mf.lines[run[0]].body = label + ":"
                mf.lines[run[0]].kind = "label"
                mf.lines[run[0]].label = label
                mf.lines[run[0]].name = ""
                mf.lines[run[1]].body = indent + f"sound_call {target}"
                mf.lines[run[2]].body = indent + f"sound_loop {len(run)}, {label}"
                mf.lines[run[2]].name = "sound_loop"
                for k in run[3:]:
                    mf.lines[k].removed = True
            i = j

    chains = chain_definitions(definitions)
    write_output(path, mf, chains)

    return (len(definitions), sum(1 for d in definitions for _ in d.body_lines))


def write_output(path: str, mf: MusicFile, chains: List[List[Definition]]) -> None:
    out: List[str] = []
    for ln in mf.lines:
        if not ln.removed:
            out.append(ln.body + ln.eol)

    if chains:
        # Make sure the existing content ends with a newline.
        if out and not out[-1].endswith(("\n", "\r")):
            out[-1] += mf.default_eol
        if out and out[-1].strip():
            out.append(mf.default_eol)

        for ci, chain in enumerate(chains):
            if ci > 0:
                out.append(mf.default_eol)
            for di, d in enumerate(chain):
                out.append(d.name + ":" + mf.default_eol)
                if d.child is None:
                    body = d.body_lines
                else:
                    body = d.body_lines[: len(d.body_lines) - len(d.child.body_lines)]
                for text in body:
                    out.append(d.indent + text + mf.default_eol)
                if d.child is None:
                    out.append(d.indent + "sound_ret" + mf.default_eol)

    with open(path, "w", encoding="utf-8", errors="surrogateescape", newline="") as f:
        f.write("".join(out))


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Optimize pokecrystal music files in place.")
    parser.add_argument(
        "files",
        nargs="+",
        help="music .asm files to optimize in place (wildcards are expanded)",
    )
    parser.add_argument(
        "-v", "--verbose", action="store_true", help="report each extracted subroutine"
    )
    args = parser.parse_args(argv)

    paths: List[str] = []
    for pattern in args.files:
        matches = glob.glob(pattern)
        paths.extend(matches if matches else [pattern])
    seen: set = set()
    unique_paths: List[str] = []
    for p in paths:
        if p not in seen:
            seen.add(p)
            unique_paths.append(p)
    paths = unique_paths

    for path in paths:
        if not os.path.isfile(path):
            print(f"error: not a file: {path}", file=sys.stderr)
            return 2
        before = os.path.getsize(path)
        count, _ = optimize_file(path, verbose=args.verbose)
        after = os.path.getsize(path)
        print(
            f"{os.path.basename(path)}: {count} subroutine(s), "
            f"{before} -> {after} bytes",
            file=sys.stderr,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
