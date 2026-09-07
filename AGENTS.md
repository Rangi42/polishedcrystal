These points are guidance/instructions for contributors, including AI agents, to follow when working in the polishedcrystal repository.

* You must review https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code for optimization patterns that are applicable any code changes and apply them as necessary.
* You must run `utils/optimize.py` to find common peephole optimizations to resolve or add a `; no-optimize` comment.
* You must use the `jmp` macro instead of `jp`, with the exception of `jp hl`. `jmp` will warn when a `jp` may become a `jr`.
* You must look at a new or modified function/routine's call sites and consider whether they actually need to `push`/`pop` to preserve registers.
* You should generally try to avoid shifting RAM that affects save data that would necessiate a save patch. If it is unavoidable, you should document that a save patch will be required in the PR description.
