Definitions (static, dynamic, strong, weak)

Those for static typing will say that the compiler helps them spot flaws; those against will say that the compiler simply annoys the programmer.

Where Dynamic Typing Excels
---------------------------

Where Static Typing Excels
--------------------------

The performance benefits of static typing have not been properly shown. Yes, statically typed languages are generally faster than dynamic languages, but I think the choice of typing is not the real issue. Work in Scheme compilers have shown that the overhead of dynamic typing is really not a big deal in the era of cheap compute power. Switching to a static langauge just for the performance benefits is usually premature optimization.

My Conclusions
--------------

Of course, any conclusions I draw will be based on my personal experience.

The fact is that programmers are constantly thinking about types. This input is a number, or a function, or a string, and so on. Even "this argument must have a field called `foo`" is a type: a refinement type to be specific. When a language is dynamically typed, the static type analysis can be nothing more than trivial.

The type checker is an additional tool, like the optimizer. Where the optimizer lets us shove many of the worries of memory usage off onto the compiler, the type checker lets us shove many of the worries of whether our program fits together onto the compiler.