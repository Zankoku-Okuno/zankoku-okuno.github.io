---
title: Geneva Code Conventions
---

NOTE: This document is under active development. Feel free to suggest more on [github](https://github.com/Zankoku-Okuno/zankoku-okuno.github.io/issues).

It seems, from a quick google, that the general assumption is that coding conventions are language-specific. This is a bit silly. Sure, there are definitely spots where the language has some consequences, but the most useful conventions are cross-language. Therefore, I propose the Geneva Inter-Language Code Conventions.

I've consciously made these points concise to the point of snark. If you can't see behind the words, you don't have the ability to apply these guidelines.

Sometimes, a language will not have the features to support these conventions. Sometimes, it's because the feature isn't needed, but sometimes it's because the language design has a bug. Use these guidelines during language design to avoid sadness.

Miscellany
==========
* A language is mostly idioms.
* Spaces just look right, without reconfiguring your editor.
* It's quicker to edit in one place than two.
* The best code is no code.
* Every mistake that can be made, will be made.

Choosing Names
==============
* Don't introduce names that are only used once.
* Don't name things after their namespace.

Sectioning Code
===============
* Don't let a line go beyond a single screen width.
* If you can't fit an expression on one line, introduce a one-use name.
* If a function can't fit in one screen, break it up.
* If you can't fit a module in 1024 lines, break it up.
* Most of your code should be well below these size limits.

Documentation
=============
* Delete all circular definitions.
* Don't document the language.
* If you can't describe some part of the interface, it shouldn't be there.
* If you don't document the architecture, no one will understand it.
* If you don't provide examples, no one will use it.
* If you rely only on API documentation generators, you'll miss out on most of the documentation.

Architecture
============
* If it doesn't compose safely, it's a problem.

Environment
===========
* If it's not version controlled, it never existed.
* If it can't build from scratch, no one will contribute.