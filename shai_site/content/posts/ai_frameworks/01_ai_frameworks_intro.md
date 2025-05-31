+++
title = "AI-First Development Frameworks (blog post series)"
date = 2025-05-10T13:01:56+03:00
weight = 1
# draft = true
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this is the first post in a series about ai-first frameworks)

Like many others, I spent a lot of time thinking about AI and software development.

I belong to the camp that believes that AI is a total paradigm shift - it'll redefine the ecosystem and what it means to
create software, and it'll be the deepest change we have seen to date.  

My own "flavor" of thinking about this is to try, from an **engineering / implementation** perspective, to understand what that change
would look like.  
Figure out what are the technical "bottlenecks" and what would move the needle on them.  
Are LLMs a limiting factor? Do they LLMs have to be essentially smarter than they are today for this to happen?  
Do we need to create some specific tooling?  
Disallow use of some tooling? Maybe a specific workflow?  

## Frameworks are the easy path
I've come to the conclusion that the way forward goes through something I think of as **AI-first frameworks****, and 
AI engines that use these frameworks to develop software.  

Very loosely, what I mean by a framework is "definitions that dictate important aspects of the code and workflow".  
This can include things like programming language, tooling, conventions.  
The central point here is that we will not continue to write code like we do now. The specifications, design, coding
practices, testing and workflows will change.  
And I think that change will be substantial.

The main reason I think this needs to happen is that any way I look at it, our current methods will simply make it very
hard to implement some of the most important improvements that are coming.  
The easiest way to make AI much more productive is to build the software in a way that "fits" the AI from the ground up.

## A blog series about AI-coding implementation
In this series of posts, I will try to show in detail why I believe this and what kind of changes I think we can expect.

While this will be mostly a very technical series, the beginning will have a bit of high-level exploration of some limitations that human coding practices have.  
After that, we'll dive into concrete, low-level examples: showing how some important aspect of software building can be made substantially easier for the AI by enforcing specific solutions.

It's likely that no individual concept will be too exotic - the approaches we'll explore are all existing industry techniques, taken from various fields.  
The point of the series is to examine the option of applying these ideas in an organized way to the general problem of programming with AI.

I'll try to set up small POCs to show that things are realistic in places where it's more difficult to see (I'm not planning
actual implementation of a framework or engine).

## TL;DR
There are a lot of pieces to this, and it'll take many weeks until I manage to release blog posts with details, so it's
worth it to give a very high level view of the approach here:

Principles:
1. Code that AI creates is expected to be different than what a human team would create. AI and human teams have
different tradeoffs in "what's easy" and "what's hard".
1. The main "missing piece" in my opinion is the ability to have an internal AI feedback-loop (plan-do-verify) that
allows the AI to self-heal most errors.
1. I will argue that "plan" and "do" can be greatly improved by enforcing some standards - things like "attach English
documentation to many things" or "use static typing more robustly in specific ways". That is, however, the smaller part
of the series.
1. The main focus will be on "verify" - allowing the AI to check the changes it makes.
1. I will argue that "adding on quality" on artibrary code bases is very difficult compared to an approach that
structures the code base specifically so that AI will be able to verify it.
1. And I'll give a bunch of examples of practices to showcase this.
1. My hope is that these will help at least a little in adding this critical perspective to the AI-implemetation
discussion.

Implementation. I'll explore ways that these approaches can be used in a framework:
1. The main technical requirement is to be able to "rule-out" as many bugs as possible, as quickly as possible. "Quick"
means that almost all "bugs" can be ruled-out in a few seconds. This has very strong implications on what can
and can't be done.
1. The best way to rule out a bug quickly is often to create the code in a way that it's impossible for the bug to
happen, and so we would not need to run the code (as a test or otherwise).
  1. Example for intuition - if something is single threaded, you don't need to test for concurrent data races at
  runtime. It's not a thing.
  1. Static typing, of course. A very simple example is that in a properly statically-typed language, if a function
  argument is an int - then it's an int. You don't need to test the case that maybe it's a string. Input to the system
  from the outside world might be incorrect - but the only place we can have such a bug is the parser, and the rest of
  the code base doesn't need to be tested for this. This can be taken further than most people are aware.
  1. Pure functions are another example - if a function has no side effects (depends only on its input and also can't
  change its input), then it can't have bugs that are related to external state, only in its implementation and in how
  we call it.
1. The AI must be able to run the code (either as a test or not) in a way that is safe-enough, reliable-enough and
fast-enough.
  1. And we must take into account that a lot of code has side-effects which might be unsafe, unrelieable and slow.
  1. This really leaves us with only one option, which is to have simulators for almost all side-effects.
1. Code can often be structured such that static analysis can rule out a lot of bugs. A very simple example is that in a
properly statically-typed language, if a function argument is an int - then it's an int. You don't need to test the case
that maybe it's a string. Static analysis (compilers, but not only) can go a long way if it's "baked-in" methodically,
which AI can do. With a framework that enforces such practices robustly, AI will indeed be able to rule out these kinds
of bugs in seconds.
1. There are other ways that bugs can be ruled out without needing to to runtime tests
1. Software design has a strong impact on what kind of bugs are possible and at which areas of the code. If something is
single threaded, you don't need to test for concurrent data races in runtime. It's not a thing.
1. 

We'll talk about design, tests, simulations, error handling, system architecture, random algorithms, 
functional programming, craaaaazy types, RAGs and a bunch of other cool stuff.  

Since I've had these ideas running around in my head for while and at least for me they are interesting, I felt like
it's time to share.  
I hope you find this interesting as well and that it'll spark some discussion :)  
Ping me on social and let me know!


** There are other names we can call this except AI-first. Other options might be AI-driven or AI-native (the term 
AI-native comes from Tessl, and is a close second to AI-first IMO).

**Next post**: [Why AI frameworks?]({{< relref "02_why_ai_frameworks" >}}) (high level)

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/ai_frameworks/02_why_ai_frameworks">next post: Why AI Frameworks &gt;&gt;</a>
</div>
{{< /inline >}}
