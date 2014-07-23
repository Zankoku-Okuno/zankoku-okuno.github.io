---
title: On Bootstrap
author: Zankoku Okuno
subject: computing
abstract: The strengths and weaknesses of Bootstrap are examined. In many ways, Bootstrap is an innovative and powerful collection of presentational tools. In everyday use however, it can be a hindrance to building sites for long-term use and maintenance by inducing coupling between semantics and presentation, between developers and designers, and between your service and Bootstrap.
---

Recently at work, a coworker and I were struggling with Bootstrap, mainly because we didn't know much of anything about it. Well, I decided that night to go home and learn about what I was doing. That's exactly what I did, but along the way, I ran into [a short criticism](http://ruby.bvision.com/blog/please-stop-embedding-bootstrap-classes-in-your-html) along the way. And that guy [wasn't alone](https://coderwall.com/p/wixovg), either. Two weeks later now, and I'm hunting through my browsing history to find it again. It stuck with me because it was right.

Where Bootstrap Fails
=====================

When I first began using Bootstrap, I noticed something, and it wasn't long before I put it into words: "If you're going to use Bootstrap, you need to really buy into it whole-cloth." If that insight doesn't make you think twice about using Bootstrap as advertised, I don't know what will.

The High-Level Argument
-----------------------

Of course, the experts went deeper into the issue than I initially did. Dan Tao has a [very well-written piece](https://coderwall.com/p/wixovg) that discusses Bootstrap as a technical debt, how to make the best of it. Over at [BVision](http://ruby.bvision.com/blog/please-stop-embedding-bootstrap-classes-in-your-html), writers immediately noticed the architectural flaws, and after they finish the old "separate presentation from markup" tune, they give some good examples of how to immediately start using Bootstrap right.

So, Bootstrap mixes presentation with markup. It induces technical debt. So what? Bootstrap is making my site pretty, and I don't detect any significant code smell. Well, I was with you not so long ago.

The Real-World Evidence
-----------------------

One thing I like is justified text. Maybe I'm old-fashioned, or maybe I've been reading too many beautiful LaTeX-typeset articles, but I wanted justified text on my site. I don't use CSS all that often, so I didn't immediately remember the property, or whether I needed some kind of compatibility workaround. I had the Bootstrap docs already open, so I took a quick look and found `class="text-justify"`.

As I customized stuff later, I found I needed to add justified text to a larger set of properties, so I took a look at the Bootstrap CSS, and low-and-behold, I found this gem:

```css
.text-justify {
  text-align: justify;
}
```

Need I even mention that there's no appreciable difference between `<p class="text-justify">` and `<p style="text-align:justify">`? Because there isn't an appreciable difference. If you didn't before, you now know what the code smells like. Everything wrong with `style` is just as wrong with so many Bootstrap classes. This is where I was well-and-truly convinced that Bootstrap as it is commonly used is a real problem.


Where Bootstrap Succeeds
========================

The thing about Bootstrap is that the smell it induces is not inherent. There are plenty of ways in which Bootstrap is very effective:

As a Quick Fix
--------------

The site is meant to be small. The site is a throwaway, as for a proof-of-concept. The investment of doing more CSS work won't pay off. These are all good reasons, though you have to be wary. Sites don't like to stay small, proofs-of-concept tend to evolve into production, and you might simply have judged the investment wrong.

And then sometimes, you're just throwing up a one- or two-page advertising drive for two weeks. Since you're already offering two-for-one pizzas, it's not worth wasting time and money to take the extra time and put a solid architecture together for something that's little more than a poster on the side of a wall.

Sometimes, the Debt Doesn't Matter
----------------------------------

Site generation tools: template engines and markdown compilers. When you're tools are configured to always spew out the appropriate presentational classes in exactly the appropriate places, there's no extra work for the humans. All you have to do is go to this one place in this one file and change a little something. This is perfectly DRY and maintainable.

Site generators are simply based in metaprogramming, which has a wonderful ability to clean up the source. Embedding presentation into _generated_ markup is usually just fine. It works out even better than Lisp macros, given that CSS and HTML scoping rules are so simple we need never worry about hygiene. You might worry about bandwidth if you're generating massive `style` attributes, but generating a few Bootstrap `class`es is not a big deal.

As a Great Read to Learn By
---------------------------

The guys over at Twitter have put in a lot of work to make their stylesheets effective cross-browser. Don't know how well rounded corners are supported? Copy the code from `bootstrap.css` and don't worry too hard. For myself, I didn't even realize the `@media (min-width: 137px)` syntax could be something that existed until I read the CSS.

Use the Source, Luke
--------------------

The actual Bootstrap source code is [LESS](http://lesscss.org/) code, and it has also been ported to [SASS](http://sass-lang.com/) if that's more your cup of tea. The best course of action for a strong website is to use what Bootstrap has already developed, but in mixin form. This way, you can have all the familiar Bootstrap presentation logic, but use only semantic markup. The articles I linked in the intro suggest this approach as well, and I leave it to them to show what this technique looks like.

There's a strong possibility I may go down this road even further. Likely, I will switch to [Stylus](http://learnboost.github.io/stylus/), and either find the stuff I need implemented in Stylus directly, or port the useful parts of Bootstrap over. If there's enough work involved, I may release it as μboot, or something.


In Conclusion
=============

Use Bootstrap, but go deeper.

Don't stop at what the official documentation or what the various tutorials tell you. Read the source, modify the source, and write your own source using their code.

Where you can't or won't go deeper, the semantics of your site will be polluted. Bots will struggle to index your site, coders and designers will involve each other in needless communicative overhead, and you will be locked-in to Bootstrap for good or ill.

Thankfully, the source is quite easy to understand.