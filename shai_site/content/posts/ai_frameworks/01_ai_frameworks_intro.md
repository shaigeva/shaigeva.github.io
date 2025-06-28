+++
title = "In Search of Production-Grade Maintainable AI-First Development: AI-First Design Patterns and Frameworks (blog post series)"
date = 2025-05-10T13:01:56+03:00
weight = 1
# draft = true
[cover]
  image = "ai_frameworks/robot_feedback_loop_matrix.png"
+++
(this is the first post in a series about creating production-grade maintainable AI-first projects, using AI-first
design patterns and frameworks)

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

However, for large code bases (which is the bulk of dev work today), the effect is far less impressive.  
Don't get me wrong - it's great, it's an amazing productivity boost, but it's not the same categorical change that we're
seeing on the smaller non-production-grade projects.

We all know that in most real-world non-small code bases, on most changes we make, AI just doesn't speed us up 10x right
now.  
In practice, while this does happen sometimes - at the moment it's only "here and there". It's not the general case.

## The easy path is to adjust the code to the AI (AI-first / AI-native / AI-driven)
I believe that huge improvements to productivity on large code bases are possible with the current generation of LLMs.  
More than 10x.

And I believe that part of what we need to do in order to get there is to build AI compatibility into the code-base from
the ground up (this approach is usually called AI-first / AI-native / AI-driven development).

The reason is that AI has different trade-offs than human teams in what is easy or hard when creating software.  
So if we want AI to 10x what it can do (and what we can do), the easiest way is to build the code in a way that fits the
AI's tradeoffs.

In other words, we need to have definitions that dictate aspects of the code and workflow, that are AI-friendly.
These can be very general and very simple (like "use meaningful variable names"), or very use-case specific, like how to
use a specific framework in a specific language.
So anything might be relevant - tech stack, packages, tooling, coding conventions, code design, testing conventions,
etc. etc.  

The central point here is that we will not "continue to write code like we do now plus add AI".  
The specifications,
design, coding practices, testing and workflows will change in a substantial way.  

## Design patterns
I'll refer to these aspects of the code as "design patterns".  
Why "design patterns"? Well, there's no real established terminology. Some of the
things I'll talk about are more "practices", some are more "coding conventions" and some can only be called "design
patterns". So I'm going with the term that I think is best at conveying "the way we do code is different,
it's not just how we prompt or the tools we use".

A major part of being productive with AI, I believe, will be mastering these.
How should we structure the code so AI can work with it well? 
What abstraction layers? What will the APIs between different components look like?
Which tests should we have, at which layers?

I'll talk about examples (and do some POCs) of such design patterns in this blog series.

## Frameworks
Individual design patterns are nice, and will be very beneficial.  

I believe, however, that the best way forward is what I think of as **AI-first frameworks**.

Very loosely, what I mean by a framework is a "combo" of these design patterns plus relevant tooling.  
It can be something like
- A Python backend service
- Enforces type annotations (Python generally allows, but doesn't require, type annotations. So a framework could
require it).
- Using a spceific backend library (e.g. Python's FastAPI)
- Has pre-defined layers of abstraction E.g. "there is a DAL (data access layer), and all its APIs only receive and
return immutable data structures".
- There are pre-defined layers where tests are written, and they have specific technical requirements. E.g. "the DAL
must have a robust test suite for testing every single workflow. That test suite only uses the DAL API (can't use SQL or
an ORM directly)".
- etc. etc. (there will probably be dozens of these, incl. specific commands to how we run some tools, AI agent rule
files and whatever's needed to enforce the specification)

These frameworks will create a "cohesive whole" that an AI agent can work with effectively.  
For example, definitions in the spirit of what I gave above (but, of course, much more robust) would force the AI agent
to create a well-defined set of all possible interactions with the database and have tests that thoroughly cover them.  

But why do we need these "frameworks"?  
Well, having each team develop their own AI-compatible practices for their code base is kind of like having each backend
team develop their own web framework from low-level http libraries, just because "we want it to be tailored to our use
case".  
It can be done, but we all understand it's not a good idea. It's very expensive and the result will suck most of the
time.  
I think it'll be much better if the industry will "think of it" a little bit like we think of web development today:
there will be common (open source?) frameworks / tool-sets created by experts, and most teams will just use a
combination of a few standard options.

## A blog series about AI-coding implementation
In this series of posts, I will try to show in detail why I believe all of this and what kind of changes I think we can
expect.

There will be a bit of high-level exploration, but mostly - we'll dive into concrete, low-level examples: discussing
specific ideas / practices that can make AI more productive if they are enforced.
 
Most (or all) concepts are not going to be too exotic - the approaches we'll explore are existing industry 
techniques.  
An experienced developer will be familiar with many of them.  
The point here is not to invent crazy new ideas, but to examine the option of applying what already exists in a
systematic way to the general problem of programming with AI.

I'll try to set up small POCs to show that things are realistic in places where it's more difficult to see. These will
mostly showcase some idea or a design pattern (I'm not planning full implementation of a framework or agent).

## TL;DR
There are a lot of pieces to this, and it'll take a while until I manage to release blog posts covering everything I
have in mind, so it's worth it to give a very high level view of the approach here:

### Principles
1. Code that AI creates is expected to be different than what a human team would create. AI agents and human teams have
different tradeoffs when it comes to productivity ROI.
1. The central notion that I'll discuss is the ability to have an internal AI feedback loop (plan-do-verify) that allows
the AI to self-heal most errors.
1. I will argue that "plan" and "do" can be greatly improved by enforcing some standards - things like "attach English
documentation to many things" or "use static typing more robustly in specific ways". That is, however, the smaller part
of the series.
1. The main focus will be on "verify" - allowing the AI to check the changes it makes.
1. I will argue that "adding on quality" to artibrary code bases is very difficult compared to an approach that
structures the code base specifically so that AI will be able to verify it.
1. And I'll give a bunch of examples of practices that make an effective feedback loop far easier, and some arguments to
show why this is more difficult if we don't have these practices.

### Implementation
I'll explore ways that these approaches can be applied using design patterns or a framework.  
The main technical requirement I'll address is to be able to "rule-out" as many "bugs" as possible, as quickly as possible. "Quick"
means that almost all "bugs" can be ruled-out in a few seconds by the AI without human intervention.  
There will, of course, also be slower verifications like e2e tests - but most bugs should be caught by the faster tests,
earlier in the process.

This has very strong implications on what practices are expected to be effective.  
For instance:
1. We need a setup that allows the AI agent to run code to check the changes it makes (sometimes the entire program,
sometiems only tests). Having an LLM just "review" written code just ain't gonna cut it.
1. But - we should try hard to verify things about the code even without running it (as a test or otherwise). Examples:
    1. Static typing, of course. This can be taken further than most people are aware and AI is a good match for this.
    1. Preference for pure functions where applicable.
1. Have simulators for most side-effects, especially those that we don't directly control.
    1. A simulator is a simplified implementation of some part of a real thing, that has a very similar behavior.
    For example, a DB table can be a list of in-memory tuples plus some wrappers.
    1. AKA "fakes" in standard test-speak.
    1. Required because side-effects might be unsafe, unreliable, uncontrollable and slow, but we must allow the AI to
    run code (either as a test or not) in a way that is safe-enough, reliable-enough, controllable-enough and
    fast-enough.
    1. This is an almost logical necessity, even though it's not "part of the conversation" now at all (I'm not sure
    I've ever seen it mentioned in the AI-building conversation, actually). Without this, everything's going to be much
    harder.
    1. I will be talking a lot about this, since bringing this down to reality is expected to be a challenge.
1. Very strong preference towards small building blocks that compose into larger components where possible (stronger
than would be appropriate for many human teams). This helps to have "divide and conquer" of bugs, leaving as
few bugs as possible to the more complex, slower tests.
1. Lastly, of course - we need to actually use all of this to design and create coding+testing strategies that have a
good ROI for the AI. This point is the most vague, the most nuanced, but also probably the most important because it's
necessary, and I think it's pretty difficult.

---

I've had these ideas running around in my head for while and at least for me they are interesting, so I felt like
it's time to share.  

I hope you find this interesting as well and that these blog posts will help a little in making this critical
perspective a central part of the AI-implemetation discussion.
Ping me on social ([twitter / x](https://x.com/shai_ge), [linkedin](https://www.linkedin.com/in/shai-geva-bb51404/)) and let me know!

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/ai_frameworks/02_ai_feedback_loop_example">next post: AI feedback loop example &gt;&gt;</a>
</div>
{{< /inline >}}
