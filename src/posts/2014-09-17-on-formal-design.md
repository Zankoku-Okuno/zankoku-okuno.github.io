---
title: On Formal Design
author: Zankoku Okuno
subject: computing
abstract: Here's a quick metaphor mapping language design and structural engineering. As a bonus, I've got a couple consequences.
---

Computation is like getting from one side of a river to another.
On your side is a text string; on the other is the result.
There is a bridge built of abstract syntax and architected by semantics.
Parsing is the act of stepping on the bridge; execution is the act of crossing it.

When designing a bridge, the choice of material limits the choices of structure and vice-versa.
It is the same when designing a language.
For this reason, when a good language designer looks at an abstract syntax or a semantics for a sensible language, they can also see most of the other.

What I am astonished by are languages where the semantics are unknown.
Would you cross a bridge architected without a design?
Could it bear your weight?
Modern architects have formal tools to analyze the properties of bridges.
But without a design, no one could say with certainty how much weight the bridge could bear.

When programmers start doing unexpected things in a program, or when sysadmins start deploying a program in unexpected places, will the system hold up?
Without a formal semantics, without a design, no one could say with certainty.
Modern language designers have formal tools, but there seems to be some reluctance to use them.
I do not enjoy using such rickety languages in production code.
