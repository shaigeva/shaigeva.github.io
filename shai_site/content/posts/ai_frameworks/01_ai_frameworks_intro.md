+++
title = "In Search of Production-Grade Maintainable AI-First Development: AI-First frameworks (blog post series)"
date = 2025-05-10T13:01:56+03:00
weight = 1
# draft = true
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this is the first post in a series about creating production-grade maintainable AI-first projects, using AI-first frameworks)

Like many others, I spent a lot of time thinking about AI and software development.

I belong to the camp that believes that AI is a total paradigm shift - it'll redefine the ecosystem and what it means to
create software, and it'll be the deepest change we have seen to date.  

My own "flavor" of thinking about this is to try, from an **engineering / implementation** perspective, to understand 
what that change could look like.  
Figure out what are the technical "bottlenecks" and what would move the needle on them.  
Are LLMs a limiting factor? Do the LLMs have to be essentially smarter than they are today for this to happen?  
Do we need to create some specific tooling?  
Disallow use of some tooling? Maybe a specific workflow?  

## Creating maintainable software
I think it's clear by now (2025-06), that coding agents can help us in many ways, including creating impressive projects
to a level that would seem science fiction just a few years ago.  
We're seeing fast and significant improvement in many areas of dev work.

One of the main areas that still didn't see a major breakthrough is coding in large codebases, which is the bulk of
dev work today.  
I'm sure there are exceptions here and there, but as a general rule, you still can't tell you AI tool to add a feature
to a million-line code base, and it'll do most of the work.  
In practice this just doesn't work ATM.

## Frameworks are the easy path
I've come to the conclusion that the way forward goes through something I think of as **AI-first frameworks**, and 
AI agents that use these frameworks to develop software.  

Very loosely, what I mean by a framework is "definitions that dictate important aspects of the code and workflow".  
This can include things like tech stack, packages, tooling, coding conventions, code design, testing conventions, etc. etc.  
The central point here is that we will not continue to write code like we do now. The specifications, design, coding
practices, testing and workflows will change.  
And I think that change will be substantial.

The main reason I believe this will happen is that any way I look at it, the current common practices will simply make
it very hard to implement some of the most important improvements that are coming.  
The easiest way to make AI much more productive is to build the software in a way that "fits" the AI from the ground up.

Having each team develop their own AI-compatible practices for their code base is kind of like having each backend team
develop their own web framework from low-level http libraries.  
It can be done, but we all understand it's not a good idea. It's very expensive and will likely not turn out well. A
model where there are common (open source?)
frameworks / tools, and most teams just use a combination of a few standard options, is probably much better.  

## A blog series about AI-coding implementation
In this series of posts, I will try to show in detail why I believe this and what kind of changes I think we can expect.

There will be a bit of high-level exploration, but mostly - we'll dive into concrete, low-level examples: discussing
specific ideas / practices that can make AI more productive if they are enforced.
 
Most (or all) concepts are not going to be too exotic - the approaches we'll explore are all existing industry 
techniques, taken from various fields.  
An experienced developer will be familiar with many of them.  
The point here is not to invent crazy new ideas, but to examine the option of applying what already exists in an
organized way to the general problem of programming with AI.

I'll try to set up small POCs to show that things are realistic in places where it's more difficult to see (I'm not 
planning full implementation of a framework or agent).

## TL;DR
There are a lot of pieces to this, and it'll take many weeks until I manage to release blog posts covering everything I
have in mind, so it's worth it to give a very high level view of the approach here:

### Principles:
1. Code that AI creates is expected to be different than what a human team would create. AI agents and human teams have
different tradeoffs when it comes to productivity ROI.
1. The central notion that I'll discuss is the ability to have an internal AI feedback loop (plan-do-verify) that allows
the AI to self-heal most errors.
1. I will argue that "plan" and "do" can be greatly improved by enforcing some standards - things like "attach English
documentation to many things" or "use static typing more robustly in specific ways". That is, however, the smaller part
of the series.
1. The main focus will be on "verify" - allowing the AI to check the changes it makes.
1. I will argue that "adding on quality" on artibrary code bases is very difficult compared to an approach that
structures the code base specifically so that AI will be able to verify it.
1. And I'll give a bunch of examples of practices that make an effective feedback loop far easier, and some arguments to
show why this is more difficult in arbitrary code bases.
1. My hope is that these blog posts will help a little in making this critical perspective a central part of the
AI-implemetation discussion.

### Implementation.
I'll explore ways that these approaches can be used in a framework.  
The main technical requirement is to be able to "rule-out" as many "bugs" as possible, as quickly as possible. "Quick"
means that almost all "bugs" can be ruled-out in a few seconds by the AI without human intervention.  
There will, of course, also be slower verifications like e2e tests - but most bugs should be caught by the faster tests,
earlier in the process.

This has very strong implications on what practices are expected to be effective.  
For instance:
1. We need a setup where the AI agent can run code to check what it does (sometimes the entire program, sometiems only
tests). Having an LLM just "review" written code just ain't gonna cut it.
1. But - we should try hard to verify things about the code even without running it (as a test or otherwise). Examples:
    1. Static typing, of course. This can be taken further than most people are aware and AI is a good match for this.
    1. Preference for pure functions where applicable.
1. Have simulators for most side-effects, especially those that we don't directly control.
    1. AKA "fakes" in standard test-speak.
    1. Required because side-effects might be unsafe, unreliable, uncontrollable and slow, but we must allow the AI to
    run code (either as a test or not) in a way that is safe-enough, reliable-enough, controllable-enough and
    fast-enough.
    1. This is an almost logical necessity, even though it's not "part of the conversation" now at all (I'm not sure
    I've ever seen it mentioned in the AI-building conversation, actually). Without this, everything's going to be much
    harder.
    1. I will be talking a lot about this, since bringing this down to reality is expected to be a challenge.
1. Very strong preference towards small building blocks that compose into larger components where possible (stronger
than would be appropriated for most human teams). This helps to have "divide and conquer" of bugs, leaving as
few bugs as possible to the more complex, slower tests.
1. Lastly, of course - we need to actually use all of this to design and create coding+testing strategies that have a
good ROI for the AI. This point is the most vague, the most nuanced, but also probably the most important because it's
necessary, and I think it's pretty difficult.

---

I've had these ideas running around in my head for while and at least for me they are interesting, so I felt like
it's time to share.  
I hope you find this interesting as well and that it'll spark some discussion :)  
Ping me on social and let me know!


**Next post**: [First feedback loop example?]({{< relref "02_first_feedback_loop_example" >}}) (high level)

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/ai_frameworks/02_first_feedback_loop_example">next post: First feedback loop example &gt;&gt;</a>
</div>
{{< /inline >}}
