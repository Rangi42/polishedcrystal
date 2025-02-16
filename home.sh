#!/usr/bin/env bash

# 1) Grab all labels defined in home/*.asm
# 2) For each label, check how many times (and where) it appears outside home.
# 3) Also check how many times it appears in home.
# 4) If it is referenced exactly once outside home and 0 times in home, print the label + file.

for f in $(git grep -hP '^([A-Za-z_][A-Za-z_0-9]+):+' home/*.asm \
         | sed 's/:.*//g' \
         | sort); do

  # Collect references outside home
  files_outside_home=$(git grep -lP "^\s+[a-z_]+( n?[zc],)? $f" -- ':!home/**')
  count_outside_home=$(echo "$files_outside_home" | wc -l)

  # Collect references in home
  count_in_home=$(git grep -lP "^\s+[a-z_]+( n?[zc],)? $f" home | wc -l)

  # If exactly 1 non-home reference and 0 home references
  if [[ "$count_outside_home" -eq 1 && "$count_in_home" -eq 0 ]]; then
    # Print the label and the single file referencing it
    echo "$f -> $files_outside_home"
  fi
done

