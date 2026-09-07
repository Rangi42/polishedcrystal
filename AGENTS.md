The following are additional guidance/instructions for AI agents to follow when working in the polishedcrystal repository.

* Agents must review https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code for optimization patterns that are applicable any code changes and apply them as necessary.
* Agents must run utils/optimize.py to find common peephole optimizations to resolve or apply a `; no-optimize` comment.
* Agents must use the `jmp` macro instead of `jp` with the exception of `jp hl`. `jmp` will warn when a `jp` may become a `jr`.
* Agents must look at a new or modified function/routine's call sites and consider whether they actually need to push/pop to preserve registers.
* Agents should generally try to avoid shifting ram that affects save data that would necessiate a save patch. If it is unavoidable, the agent should document that a save patch will be required in the PR description.