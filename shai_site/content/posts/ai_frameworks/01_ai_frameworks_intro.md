+++
title = "Moving past vibe-coding? In Search of real-world AI-First Development: AI-First Design Patterns and Frameworks (blog post series)"
date = 2025-06-20T13:01:56+03:00
weight = 1
[cover]
  image = "ai_frameworks/robot_feedback_loop_matrix.png"
+++
(first post in a series)

Like many others, I spent a lot of time thinking about AI and software development.

I belong to the camp that believes that AI is a total paradigm shift - it'll redefine the ecosystem and what it means to
create software, and it'll be the deepest change we have seen to date.  

My own "flavor" of thinking about this is to try, from an **engineering / implementation** perspective, to understand 
what that change could look like.  
This blog series will dig into this and share my thoughts and conclusions from experimentation.  
I'll talk about both:
- What can we already do today? Concrete, pragmatic practices we can use right now to make ourselves faster.
- And more theoretically: What would need to be different in how we work so in the future (few years?), everything will indeed be different and
much more productive?

My hope is that these posts will help enthusiastic devs boost their productivity, and to contribute to the general
conversation around AI and coding.

In this intro post, I'm describing the general concept, with some high-level examples (most of the series will be
low-level and technical).

## Creating maintainable software
By now (2025-06), the term vibe coding has been with us for a few months, and tools / platforms have been here for quite
a bit more.  
AI coding assistants already help us in many ways, including creating impressive projects
to a level that would seem science fiction just a few years ago.  
We're seeing fast and significant improvement in many areas of dev work.

However, the effect is far less impressive for what is the bulk of dev work today - ongoing work on large code bases.  
Don't get me wrong - it's great, it's an amazing productivity boost, but it's not the same categorical change that we're
seeing when vibe coding smaller non-production-grade projects.

We all know that in most real-world non-small code bases, on most changes we make, AI just doesn't speed us up 10x right
now.  
In practice, while this does happen sometimes - at the moment it's only "here and there". It's not the general case.

## The easy path is to adjust the code to the AI (AI-first / AI-native / AI-driven)
I believe that huge improvements to productivity on large code bases are possible with the current generation of LLMs.  
More than 10x.

And I believe that part of what we need to do in order to get there in the long run is to build AI compatibility into
the code-base from the ground up (this approach is usually called AI-first / AI-native / AI-driven development).  
For the shorter-term, this can be "done in pieces" - make a certain part, or certain aspect of the code base be
"AI-friendly".

Why? Well, AI has different trade-offs than human teams in what is easy or hard when creating software.  
So if we want AI to 10x what it can do (and what we can do), the easiest way is to build the code in a way that fits the
AI's tradeoffs.

In other words, we need to have definitions that dictate aspects of the code and workflow, which are AI-friendly.  
These can be very general and very simple (like "use meaningful variable names"), or very use-case specific, like how to
use a specific framework in a specific language.

So anything might be relevant - workflow, specifications, tech stack, packages, tooling, coding conventions,
code design, testing techniques, etc. etc.  
The central point here is that we will not "continue to write code like we do now plus add AI", but that we'll see
substantial changes to all of these.

## Design patterns
I'll refer to these aspects of the code and workflow as "design patterns".  
I'm using this term because there's no real established terminology. Some of the
things I'll talk about are more "practices", some are more "coding conventions" and some can only be called "design
patterns". So I'm going with the term that I think is best at conveying that: 
1. The way we do code is different, it's not just how we prompt or the tools we use".
1. It's a **design** approach. It's part of the design of our code, our architecture, our workflow.

A key part of being productive with AI, I believe, is to master these.  
How should we structure the code so AI can work with it well? 
What abstraction layers? What will the APIs between different components look like?
Which tests should we have, at which layers?

I'll talk about examples (and do some POCs) of such design patterns in this series.

It's worth mentioning that most (or all) concepts are not going to be too exotic - the approaches we'll explore are
variations of established industry techniques.  
An experienced developer will be familiar with many of them.  
The point here is less to invent new ideas, and more to examine the option of applying what already exists in a
systematic way to the general problem of programming with AI.

## Frameworks
Individual design patterns are nice, and will be very beneficial for those that learn them.  

I believe, however, that the best way forward is what I think of as **AI-first frameworks**.

Very loosely, what I mean by a framework is a "combo" of these design patterns plus relevant tooling.  
It can be something like
- A Python backend service
- Enforces type annotations (Python generally allows, but doesn't require, static types. So a framework could
require it).
- Using a spceific backend library (e.g. Python's FastAPI)
- Has pre-defined layers of abstraction. E.g. "there is a DAL (data access layer), and all its APIs only receive and
return immutable data structures".
- There are pre-defined layers where tests are written, and they have specific technical requirements. E.g. "the DAL
must have a robust test suite for testing every single workflow. That test suite only uses the DAL API (can't use SQL or
an ORM directly)".
- etc. etc. (there will probably be dozens of these, incl. specific commands to how we run some tools, AI agent rule
files and whatever's needed to enforce the specification)

These frameworks will create a "cohesive whole" that an AI agent can work with effectively.  
For example, definitions in the spirit of what I gave above (but, of course, much more explicit and robust) would force
the AI agent to create a well-defined set of all possible interactions with the database and have tests that thoroughly
cover them.  

But why do we need these "frameworks"?  
I think that having each team hand-craft their own AI-compatible practices for their code base is kind of like having each
backend team develop their own web framework from low-level http libraries, just because "we want it to be tailored to
our use case".  
It can be done, but we all understand it's not a good idea. It's very expensive and the result will suck most of the
time.  
I think it'll be much better if the industry will "think of it" a little bit like we think of web development today:
there will be common (open source?) frameworks / tool-sets created by experts, and most teams will use a
combination of a few standard options, plus customization where actually needed.

## TL;DR
There are a lot of pieces to this, and it'll take a while until I manage to release blog posts covering everything I
have in mind, so it's worth it to give a very high level view of the approach here:

### Principles
The most significant mental models here are the feedback loop and the bug funnel.

The bug funnel (it's not really just bugs - also features etc., but "bug funnel" is easy to think about) is the concept
that when code is written (by a human or AI), it sometimes contains things that are not desirable.  
As that code "moves forward in the software lifecycle" (compilers, linters, various tests, review, etc. etc.), some of
these bugs are discovered at every step and get filtered out.  
Bugs that are discovered earlier in the "funnel" are cheaper than bugs found later.  
In other words, it's a very good idea to "shift-left" bugs in the bug funnel.

The feedback loop is what we all know - planning, doing, verifying and then doing it again and again until we're done.  
A fast and effective feedback loop has always been one of the most significant things in the process of creating
software, and AI assistants will magnify that by orders of magnitude.  
Our main objective is to make the human feedback loop "better" (faster, easier, more effective).  
And the main way that we'll help the human feedback loop is by giving the AI agents their own internal feedback loop.
We'll work very hard to enable the agent to plan, make changes and then verify them itself and auto-heal them. So that
it'll give the result to a human only after it's done and "filtered out" all the bugs it can.


In other words, the "star of the show" is going to be the ability to create fast feedback loops that are effective at
both creating new things and shifting-left bugs in the bug funnel.

My main focus will be on the verification part - allowing the AI to check the changes it makes.  
We'll explore a bunch of directions like linting, static typing approaches, ideas like
automatic screenshots and LLM automatic reviews. And mostly - A LOT of code design and testing techniques.

### Practices / techniques
As mentioned, our main technical objective will be a fast AI-internal feedback loop that "rule-out" as many "bugs" as 
possible, as quickly as possible.  
"Quick" means that almost all "bugs" can be ruled-out in a few seconds by the AI without human intervention.  
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
    1. I will be talking a lot about this, since bringing this down to reality is a challenge.
1. Very strong preference towards small building blocks that compose into larger components where possible (stronger
than would be appropriate for many human teams). This helps to have "divide and conquer" of bugs, leaving as
few bugs as possible to the more complex, slower tests.
1. Lastly, of course - we need to actually use all of this to design and create coding+testing strategies that have a
good ROI. This point is the most vague, the most nuanced, but also probably the most important because it's
necessary, and I think it's pretty difficult.

---

I've had these ideas running around in my head for while and at least for me they are interesting, so I felt like
it's time to share.  

I hope you find this useful, or at least interesting.  
Ping me on social ([twitter / x](https://x.com/shai_ge), [linkedin](https://www.linkedin.com/in/shai-geva-bb51404/)) and let me know!

---

In the next post (coming in a week, I hope), I'll give an example of what an internal AI feedback loop looks like on a small project, and start looking at some of the more basic techniques.
