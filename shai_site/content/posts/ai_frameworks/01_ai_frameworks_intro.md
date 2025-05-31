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

While this will be mostly a very technical series, the beginning will have a bit of high-level exploration of some 
limitations that human coding practices have.  
After that, we'll dive into concrete, low-level examples: showing how some important aspect of software building can be
made substantially easier for the AI by enforcing specific solutions.

It's likely that no individual concept will be too exotic - the approaches we'll explore are all existing industry 
techniques, taken from various fields.  
The point of the series is to examine the option of applying these ideas in an organized way to the general problem of
programming with AI.

I'll try to set up small POCs to show that things are realistic in places where it's more difficult to see (I'm not 
planning actual implementation of a framework or engine).

## TL;DR
There are a lot of pieces to this, and it'll take many weeks until I manage to release blog posts with details, so it's
worth it to give a very high level view of the approach here:

### Principles:
1. Code that AI creates is expected to be different than what a human team would create. AI and human teams have
different tradeoffs when it comes to productivity ROI.
1. The main "missing piece" that I'll discuss is the ability to have an internal AI feedback-loop (plan-do-verify) that
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

### Implementation.
I'll explore ways that these approaches can be used in a framework.  
The main technical requirement is to be able to "rule-out" as many bugs as possible, as quickly as possible. "Quick"
means that almost all "bugs" can be ruled-out in a few seconds.  
There will, of course, also be slower verifications like e2e tests - but bugs should almost always be caught earlier in
the process.

This has very strong implications on what can and can't be done.  
For instance:
1. Try to verify code without running it (as a test or otherwise). Examples:
    1. Static typing, of course. This can be taken further than most people are aware and AI is a good match for this.
    1. Heavy preference for pure functions where applicable.
1. Have simulators for almost all side-effects.
    1. AKA "fakes" in standard test-speak.
    1. Required because side-effects might be unsafe, unreliable and slow, but we must allow the AI to run code (either
    as a test or not) in a way that is safe-enough, reliable-enough and fast-enough.
1. Strong preference towards small building blocks that compose into larger components where possible. This helps to
have "divide and conquer" of bugs, leaving as few bugs as possible to the more complex, slower tests.
1. Lastly, of course - we need to actually use all of this to design and create test strategies that have a good ROI for
the AI. This point is the most vague, the most nuanced, but also possibly the most important. The reason this requires a
framework, is that this doesn't just "pop-up by itself" on arbitrary code bases.

Consider something like "the web application backend will have a data layer that
has a thin API which communicates in value-only objects that are not connected to the DB implementation and are unaware
of it. There is a suite of property-based tests employing stateful testing to verify all data access actions are 
coherent".
This is something that I think will be extremely common in robust AI coding. However, most developers are not even
familiar with a lot of this terminology, and most existing code bases have nothing like that implemented.


Frankly speaking, the reason that most code bases are not well tested is that testing is complicated and nuanced, and
most developers just don't have the knowledge of creating a make-sense testing approach to what they're building.


a
    1. Example: in a web application backend, we would typically want a data access layer that defines a
    thin-as-possible API, and that API would be brutally tested. SQL / ORM will only be found in that layer.
    For human teams - this is a well established design pattern, though by no means the common case. For AI, I believe,
    this should be the default.
1. Code can often be structured such that static analysis can rule out a lot of bugs. A very simple example is that in a
properly statically-typed language, if a function argument is an int - then it's an int. You don't need to test the case
that maybe it's a string. Static analysis (compilers, but not only) can go a long way if it's "baked-in" methodically,
which AI can do. With a framework that enforces such practices robustly, AI will indeed be able to rule out these kinds
of bugs in seconds.
levels of testing make a differenc (e.g. have a dedicated test layer for the data access layer and have that be rock-solid)

make things up of small things that are well tested;

1. There are other ways that bugs can be ruled out without needing to do runtime tests
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
