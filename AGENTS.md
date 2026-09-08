These points are guidance/instructions for contributors, including AI agents, to follow when working in the polishedcrystal repository.

* Consult https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code for optimization patterns that are applicable any code changes and apply them as necessary.
* Run `utils/optimize.py` to find common peephole optimizations to resolve or add a `; no-optimize` comment. (This script checks for many of the patterns defined in the Optimizing-assembly-code wiki, but not all.)
* Always use the `jmp` macro instead of `jp`, with the exception of `jp hl`. `jmp` will warn when a `jp` should become a `jr`. (Do not change `jmp` to `jr` if the jump is going from one `SECTION` to another, and the linker only placed them close together by coincidence.)
* Review any new or modified function/routine's call sites and consider whether they actually need to `push`/`pop` to preserve registers. (It's easy/common to overdo this `push`/`pop` behavior.)
* Try to avoid shifting RAM that affects save data, since that would necessiate a "save patch" to update save files for the next release. If shifting RAM is unavoidable, you should explain that a save patch will be required in the PR description.
