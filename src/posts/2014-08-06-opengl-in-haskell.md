---
title: OpenGL in Haskell
author: Zankoku Okuno
subject: computing
abstract: In university, I did some graphics programming in C/C++. I've been wanting to do some more, but have moved to Haskell, where the availability of tutorials is slim. Compounding that is the fact that I never truly understood OpenGL in the first place, I've been largely out in the cold lately. In response, I've decided to learn to use Haskell for OpenGL programming by porting tutorials.
---

At this point, I'm just experimenting: trying to get things to work, re-ordering thing until they break that sort of thing.
I've found that my iteration time is much shorter in Haskell than it was in C++, probably because Haskell control flow is so much more straightforward.
Even so, having to do science just to figure out how OpenGL works is well below sub-standard.

How I am Learning OpenGL
------------------------

In my attempt to re-learn OpenGL, I've found some serious flaws in how these tutorials get written:

* They teach the direct draw interface.
  This was deprecated in 3.0; I think it's removed in 4.0.
  It should not be used for new code, so I will not learn it, and I will not teach it, according to the fundamental principles of our father, The Great Deprecator.
* They quickly get mired in jargon and/or magic.
  A name like "vertex attribute array" is totally opaque. I'm still not sure I get it.
  Everyone says "use this magic code" or "it's a jargonjargonjargon". Why?
  As far as I can tell, nothing about the data/execution model is really that complicated.

Having just spewed out a bunch of harsh, these tutorials are still the best we've got.
I can't even enumerate all the pieces of the puzzle I've found out there[^1], but here are most of them, in no particular order:

* [OnlyGraphics](http://onlygraphix.com/category/3d/)
* [An Intro to Modern OpenGL](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Table-of-Contents.html)
* [Modern OpenGL with Haskell](http://www.arcadianvisions.com/blog/?p=224)
* [Postmodern Haskell and OpenGL: Introducing vinyl-gl](http://www.arcadianvisions.com/blog/?p=388)
* [Haskell OpenGL animation done right](http://dmytrish.wordpress.com/2013/01/12/haskell-opengl-animation-done-right/)
* [OpenGL in Haskell: GLFW-b Boilerplate](http://www.tapdancinggoats.com/opengl-in-haskell-glfw-b-boilerplate.htm)
* [OpenGL Common Mistakes](https://www.opengl.org/wiki/Common_Mistakes)
* [Rendering Pipeline Overview](http://www.opengl.org/wiki/Rendering_Pipeline_Overview)
* [haskell-OpenGL-examples](https://github.com/bergey/haskell-OpenGL-examples)
* [Tutorials for modern OpenGL](http://www.opengl-tutorial.org/)
* [Swiftless OpenGL 4 Tutorials](http://www.swiftless.com/opengl4tuts.html)
* [Using Vertex Array Objects](http://www.lastrayofhope.co.uk/2011/07/30/using-vertex-array-objects/)

[^1]: No, really. Thanks to a mis-designed UI, I lost a ton of tabs.

How I want to Teach OpenGL
--------------------------

As a programmer, I am intimately familiar with the idea of bytes of data stored in memory and instructions operating on that data.
That is how a computer fundamentally works, and OpenGL is not much different.
With OpenGL, or any other library providing access to a graphics card, there are simply two computers, each with memory and an instruction set.
The only "trick" is getting the two to communicate.

There's no trick to the communication either.
We JIT compile a program (shader).
We can allocate memory (buffers) and load our data in.
We describe the format of the data (attribute arrays?).
We kick off our program passing our data in; some of this data is simple values, others are drawn from buffers, which may have a fairly complex format.

Is that really any more difficult than `./cube --eye 1,2,3 <texture.tiff`?
From what I understand now, this metaphor continues to hold up, even as you optimize your rendering code.
There's no reason to make the student learn a bunch of new terms until the concepts are there,
and there's no reason to act like the student cares about the details like an professional would.

When we first started programming, we started with simple programs that were unfit for production. Remember the times when you wouldn't worry about the `IOException` that would crash your program just because of a missing file? That was the correct way to start learning: simplified. Only later would you learn what made it tick. OpenGL really is a whole new programming experience, and it should start roughly where we started programming.

