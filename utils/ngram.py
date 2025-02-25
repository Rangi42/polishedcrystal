#!/usr/bin/env python3
# Disclaimer: This is ChatGPT code!

import argparse
import subprocess
from collections import Counter

# Define tokens from the charmap
TOKENS = [
	"<START>", "<RAM>", "<WAIT>", "<ASM>", "<NUM>", "<PAUSE>", "<SOUND>", "<DAY>", "<FAR>",
	"<DONE>", "<PROMPT>", "<LNBRK>", "<NEXT>", "<LINE>", "<CONT>", "<PARA>", "<TARGET>",
	"<USER>", "<ENEMY>", "<CTXT>", "¯", "<MALE>", "<FEMALE>", "<STAR>", "<BALL>",
	"<HP1>", "<HP2>", "<NOHP>", "<FULLHP>", "<HPEND>", "◢", "—", "◣", "<NONO>",
	"<XP1>", "<XP2>", "<NOXP>", "<FULLXP>", "<XPEND>", " ", "A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
	"X", "Y", "Z", "(", ")", ".", ",", "?", "!", "a", "b", "c", "d", "e", "f", "g", "h",
	"i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y",
	"z", "“", "”", "-", ":", "♂", "♀", "'", "'d", "'l", "'m", "'r", "'s", "'t", "'v",
	"é", "É", "á", "ê", "í", "ó", "¿", "¡", "<PO>", "<KE>", "<PK>", "<MN>", "<ID>", "№",
	"<LV>", "<BOLDP>", "&", "♪", "♥", "×", "/", "%", "+", "<SHARP>", "0", "1", "2", "3",
	"4", "5", "6", "7", "8", "9", "¥", "…", "★", "▼", "▲", "◀", "▶", "▷", "↑", "↓", "′",
	"″", "<PHONE>", "<BLACK>", "┌", "─", "┐", "│", "┃", "└", "━", "┘", "#", "#mon", "<PLAYER>",
	"<RIVAL>", "<TRENDY>"
]

# Sort tokens by length descending so the tokenizer greedily matches the longest token first
TOKENS.sort(key=len, reverse=True)


def tokenize_line(line, tokens):
	"""
	Greedily match known tokens from left to right.
	If none match at a given position, fallback to a single character.
	"""
	result = []
	i = 0
	while i < len(line):
		matched = False
		for t in tokens:
			if line.startswith(t, i):
				result.append(t)
				i += len(t)
				matched = True
				break
		if not matched:
			result.append(line[i])
			i += 1
	return result


def detokenize_line(token_list):
	"""
	Convert a list of tokens back to a single string for further re-tokenization
	or final textual output. We just concatenate them with no separator.
	"""
	return "".join(token_list)


def get_repo_lines():
	"""
	Retrieve lines from grep+sed:
	  git grep -hP '^\t(?:text|next1|next|line|cont|para|done|prompt|page) +"(.+)"' \
	  | sed -E 's/^.[a-z0-9]+ +"(.+)"/\1/g'
	"""
	GREP_CMD = r"""
	git grep -hP '^\t(?:text|next1|next|line|cont|para|done|prompt|page) +"(.+)"' \
	| sed -E 's/^.[a-z0-9]+ +"(.+)"/\1/g'
	""".strip()
	output = subprocess.check_output(GREP_CMD, shell=True)
	lines = output.decode('utf-8').splitlines()
	return lines


def get_ngrams(token_list, n):
	"""
	Return a list of n-gram tuples from the token_list.
	E.g. if token_list = [T1, T2, T3, T4] and n=2,
	we get (T1,T2), (T2,T3), (T3,T4).
	"""
	return [tuple(token_list[i : i + n]) for i in range(len(token_list) - n + 1)]


def compute_savings(lines_tokenized, n):
	"""
	Count how often each n-gram of length n appears across all tokenized lines.
	Return a dict: { ngram_tuple: (count, saving_bytes) }
	  saving = (n - 1) * count
	Because if each n-gram (size n) is replaced by 1 byte, we save (n-1) per occurrence.
	"""
	counter = Counter()
	for tokens in lines_tokenized:
		for ngram in get_ngrams(tokens, n):
			counter[ngram] += 1

	result = {}
	for ngram, count in counter.items():
		saving = (n - 1) * count
		result[ngram] = (count, saving)
	return result

def replace_ngram_in_line(tokens, ngram, replacement_token):
	"""
	Replace every occurrence of `ngram` in `tokens` with a single `replacement_token`.
	This is similar to a "dictionary compression" step.
	"""
	new_tokens = []
	i = 0
	size = len(ngram)
	while i < len(tokens):
		if tuple(tokens[i : i + size]) == ngram:
			new_tokens.append(replacement_token)
			i += size
		else:
			new_tokens.append(tokens[i])
			i += 1
	return new_tokens


def is_nested_ngram(ngram_tuple):
	"""
	Returns True if this n-gram tuple contains any token starting with '<NGRAM_'.
	"""
	return any(tok.startswith("<NGRAM_") for tok in ngram_tuple)


def flatten_tokens(ngram_tuple, expansions):
	"""
	Convert an n-gram tuple into a human-readable string, recursively expanding
	any placeholder tokens like <NGRAM_...>.
	"""
	return "".join(expand_token(t, expansions) for t in ngram_tuple)


def expand_token(tok, expansions):
	"""
	Recursively expand a single token if it's one of our <NGRAM_...> placeholders.
	"""
	if tok in expansions:
		return expansions[tok]
	else:
		return tok


def iterative_ngram_selection(lines_tokenized, max_n, analyze_lower_n, top_k, expansions):
	"""
	- lines_tokenized: list of lines, each a list of tokens
	- max_n: maximum n-gram size to consider
	- analyze_lower_n: if True, also consider 1..(n-1) grams each iteration
	- top_k: how many n-grams to select (iteratively)
	- expansions: dict to store expansions for new placeholder tokens

	Returns:
	  chosen: list of chosen n-grams in the order they were selected
			  each item is (ngram_tuple, n, freq, saving)
	  lines_tokenized: final tokenized lines (after all replacements)
	"""
	chosen = []
	placeholder_id = 0  # Unique ID to generate new placeholder tokens

	for _ in range(top_k):
		best_ngram = None
		best_saving = 0
		best_freq = 0
		best_nval = 0

		# Build the range of n-values to consider:
		if analyze_lower_n:
			n_range = range(1, max_n + 1)
		else:
			n_range = [max_n]

		# 1) Find the best single n-gram among all n in n_range
		for nval in n_range:
			ngram_dict = compute_savings(lines_tokenized, nval)
			for ngram, (freq, saving) in ngram_dict.items():
				if saving > best_saving:
					best_saving = saving
					best_freq = freq
					best_ngram = ngram
					best_nval = nval

		# If no n-gram yields any saving, we’re done
		if best_saving <= 0 or not best_ngram:
			break

		# 2) We found a winning n-gram for this iteration
		chosen.append((best_ngram, best_nval, best_freq, best_saving))

		# 3) Create a unique placeholder token, e.g. <NGRAM_42>
		placeholder_id += 1
		placeholder_token = f"<NGRAM_{placeholder_id}>"

		# 4) Store a flattened expansion for this new placeholder
		expansions[placeholder_token] = flatten_tokens(best_ngram, expansions)

		# 5) Perform the replacement in every line
		for i in range(len(lines_tokenized)):
			lines_tokenized[i] = replace_ngram_in_line(lines_tokenized[i], best_ngram, placeholder_token)

	return chosen, lines_tokenized


def main():
	parser = argparse.ArgumentParser(
		description="Find top n-grams (token-based) iteratively, with optional flattening and nested sorting."
	)
	parser.add_argument("--max-n", type=int, default=5,
						help="Maximum size of n-grams to consider (default: 3).")
	parser.add_argument("--analyze-lower-n", action="store_true",
						help="Also include 1..(n-1) grams in each iteration.")
	parser.add_argument("--top-k", type=int, default=10,
						help="How many n-grams to select (iteratively).")
	parser.add_argument("--flatten-output", action="store_true",
						help="If given, print each final chosen n-gram as the expanded substring instead of the placeholder tokens.")
	parser.add_argument("--nested-last", action="store_true",
						help="If given, sort chosen n-grams so that those containing <NGRAM_...> placeholders appear last.")
	args = parser.parse_args()

	max_n = args.max_n
	analyze_lower_n = args.analyze_lower_n
	top_k = args.top_k
	flatten_output = args.flatten_output
	nested_last = args.nested_last

	print(f"Analyzing n-grams up to n={max_n}, "
		  f"{'including' if analyze_lower_n else 'NOT including'} lower n, "
		  f"selecting top {top_k} iteratively.\n")

	# 1. Gather raw text lines via git grep + sed
	lines = get_repo_lines()

	# 2. Tokenize each line
	lines_tokenized = [tokenize_line(ln, TOKENS) for ln in lines]

	# expansions dict will store placeholders -> flattened expansions
	expansions = {}

	# 3. Iteratively select and replace n-grams
	chosen, final_lines_tokenized = iterative_ngram_selection(
		lines_tokenized, max_n, analyze_lower_n, top_k, expansions
	)

	# 4. If we found nothing, exit
	if not chosen:
		print("No n-grams yielded any positive savings.")
		return

	if nested_last:
		 # Define a helper function to check if an n-gram contains placeholders like <NGRAM_...>.
		def is_pure_ngram(ngram_tuple):
			# An n-gram is "pure" if none of its tokens start with "<NGRAM_".
			return not any(tok.startswith("<NGRAM_") for tok in ngram_tuple)

		# Sort n-grams so that:
		# 1. Pure n-grams (without placeholders) come first.
		# 2. Nested n-grams (with placeholders) come last.
		# 3. Preserve the original order for ties within each group.
		# Achieved by a stable sort, where `is_pure_ngram(...)` evaluates to `True` for pure n-grams.
		chosen.sort(key=lambda x: is_pure_ngram(x[0]), reverse=True)

	print("Chosen n-grams (in final order):")
	total_saved = 0

	for (ngram_tuple, nval, freq, saving) in chosen:
		total_saved += saving
		if flatten_output:
			# Expand the n-gram into its original text
			ngram_str = flatten_tokens(ngram_tuple, expansions)
		else:
			# Show the raw tokens joined together
			ngram_str = "".join(ngram_tuple)

		print(f"  - ngram={ngram_str!r} (length={nval}), freq={freq}, saving={saving} bytes")

	print(f"\nTotal bytes saved (before dictionary overhead): {total_saved}\n")


if __name__ == "__main__":
	main()
