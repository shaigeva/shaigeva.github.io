+++
title = "Why AI frameworks?"
date = 2025-05-09T13:01:56+03:00
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this post is part of a [series]({{< ref "/posts/ai_frameworks/ai_frameworks.md" >}}) about ai-native frameworks)

I'll focus here on the reason I think frameworks are the direction and what I think they will include.  

At a very high level, the rationale is this:
1. It makes sense to "aim our code for the AI", because it'll be the new norm.
1. With the current way we're making software, it's just not realistic to make a paradigm shift happen, because AI 
cannot have a feedback loop that's good enough to change code at an acceptable speed and self-heal enough issues.
1. Therefore, I believe the only way forward is to have frameworks that dictate some important aspects of the code, in order to give AI what it needs so it can do its job.

Let's dig in.

## An industrial revolution
Soon enough, the vast majority of code will be written by AI.  
So in a sense, this is a large automation movement.  
Things human craftsmen currently make will be handed over en masse to the machine.

Given that, it makes sense to think about the common case for software creation, which will soon be the automated
process.  
And as with other automations, the automation might involve a redesign.

The printing press is not a faster pen, and digital photography is not a "better film camera".  
They work differently, and create something a little different.  
And we should expect the same from automating software creation, even though the process is less mechanical.

## A reality of imperfection
There's a fundamental truth about "making things": it's not going to be perfect.
Three main reasons for this are
1. Mistakes: whoever makes something complex, often makes mistakes. Either in understanding what to do or in implementing. Randomness will happen.
2. Tradeoffs for multiple concerns: some things need to balance different concerns. Being better at one often means giving up something on the other.
3. Change: even if it's perfect today, it won't be perfect in a year. Requirements change, you have more data than you can handle, a package you're using has a security breach that requires upgrading, some 3rd party service you're working with is changing or shutting down, whatever.

We are imperfect humans in imperfect teams, building imperfect products in an imperfect reality.

And it is the same with AI.  
For all the same reasons, when AI makes a change, sometimes it won't be what we need. It's not going to be the same
imperfections a human creates, but it'll happen.

## The almighty feedback loop
The way to deal with this reality is to iterate. We all know this:
1. We plan - decide what to do next.
1. Then we do the thing.
1. We verify - get feedback (check if that thing is a step in the right direction).

Then, given that new information from the feedback - we go back to the beginning.
1. Plan
1. Do
1. Verify

And again and again...

For me, this feedback loop is the main mental model for thinking about software development processes, at every scale.   
(well, software development is a human activity, so human interaction and the human skillset are the most important
things, but in terms of the high level process, this is my thinking)

The business might iterate on product-market fit, product might iterate on UX details, a complex project would be built
in iterations. And so would an individual development task.  
You write some code (maybe all the code you think is needed), you test and fix and test again. Deploy to staging, deploy to prod, fix if something broke etc.

This is an essential part of dealing with imperfection or randomness. We don't have a solution that doesn't include an
auto-correcting feedback loop.

An important note on speed: the shorter a feedback loop is, the better. This matters A LOT. Any imperfection can send
you off in the wrong direction, so you want to get feedback as early as possible. True for low-level debugging as it is 
for product-market fit.  
There's no surprise there. It's a random process with some chance of going wrong each step and auto-correction. The
more iterations you can squeeze in at a given timeframe, the more chance you have at reaching the goal.

## AI and our feedback loops
Although not always discussed this way, what we're doing now with AI tools is integrating them into our own feedback
loop.  
And when you look at it from this angle, you can see that a lot of the techniques we use to improve the performance of
human+ai are just optimizing some part of our feedback loop - adding steps in the process for detailed planning,
breaking down to smaller tasks, making sure the correct context gets in so it's easier for the AI to "do" etc.

## AI's internal feedback loop today 
An observation I'm making here is that the AI has (or can have) its own feedback loop before it hands the latest change
over to us.

My own experience, and I'm sure many others' as well, is that the best outcome I get is if I set up an AI
assistant for a feedback loop like this:
1. Understand what to do next
1. Create something small
1. Write a new test + Run all relevant tests. If something breaks - the next action would be to fix it.

And I let this run automatically in a loop until either all tests are green, it gives up or it starts going crazy.  
This is possible, for example with Cursor, for some time now. In fact, Cursor will try to self-heal what it can out of the box - stuff like lint errors.

A note here: like with human feedback loops, speed matters. If every small change takes 15 minutes, then it's slow
enough that the human can't manage it, and it'd often be better for the human to do it themselves.  

This works extremely well. The AI having its own internal self-healing feedback loop, backed by the right tests to make
me feel safe-enough that nothing breaks, is a different category of productivity.  
Some bugs still get through to me. I test, but it's kind of "skipping to the end of the process" - I would also do the
same tests if I wrote the code, and find similar bugs.

When I can set it up, it's just great. But... for most of my work, I can't.

## AI's internal feedback loop tomorrow
So when I distill the situation as far as I can, this is what remains.  
1. AI will statistically make mistakes at any given step it does.  
1. Large, standard codebases and systems are FAR too complex for these "imperfections" to be rare.
1. We must allow the AI to self-correct using a feedback loop, to minimize these.

Any coding the AI does and which doesn't have a good feedback loop - a human will have to understand every small part of it and
test it thoroughly.  
This has a "glass ceiling" of diminishing returns since even when the AI becomes far better at coding than it is today,
the changes will be so large that it'll be that much more difficult for a human to reason about them and test them.  

Therefore: any coding that we want AI to do consistently, has to be backed by a strong feedback loop like this, where
it has the capability to consistently move forward, and it's rare-enough that it makes significant mistakes without us
knowing.  
It is also important that it'll be very, very rare that unexpected and unrelated things break. If you add a button and a
serious security issue appears - that's not an AI workflow that backs a paradigm shift.

So the feedback loop is sort-of a "constant" in this "movement to AI". A requirement that must be satistified.  
There's no model strong enough, no shiny UX that will work without it, no brilliant prompt, no RAG pipeline that will
get just the right context.  
If it's too slow, if it can't prevent nasty surprises and can't auto-heal most issues before it hands us a result, there
are only incremental improvements to be had. Large increments, but still - it's limited.

## What are the limiting factors?
So, what's preventing such a feedback loop today?

Twitter is full of tips and tricks on rule files and project documentation, workflows that break out planning into
different steps (and also some tools for mananging plan execution, as composed of small steps).  
These help "plan" and "do", though far from enough.  

The way I see it, we have two significant bottlenecks:  
First: understanding complex code well, incl. flow execution. I believe there are codebases where this works
pretty well, but certainly not consistently enough.  
And second: the real limiting factor of the AI software movement - "verify".  

The tests.  
Well, mostly the tests - there are other verifications.  
For example, automatically taking a one-time screenshot of a UI component "before and after" and comparing is very much
a verification, though it's not considered a "test" by common terminology. But
I'll usually include all verification in "tests" to be a little less verbose.


## The tests
I'm proficient with tests. I have given testing a lot of attention for two decades, I give talks about tests, I had
successes and failures and I have an "arsenal" of effective techniques.

Because of that, I know it's not realistic to add good tests to most code bases. At least, good tests that will be fast
enough.  
**Code is usually not testable if it's not designed to be testable.**

Some common issues are
1. Logical complexity, where some component does a lot of stuff and it's difficult to isolate what you want to test
in a way that's both reliable and simple enough. Especially for complex flows that include multiple steps and many
components with non-trivial state changes.
1. Technical complexity, where it's difficult to set up things. A simple example would be data samples for complex
processes, but the more hairy issues involve things like like relying on some external thing for which it's tricky to simulate failure modes.
1. Side-effects, where the code interacts with the outside world in some way.

Consider something like this: we have an arbitrary microservice architecture with 50 repos, where some services are written in typescript, some are written in python without type hints, and the team has even braved Rust on one of them. We mostly use Postgres with redis, but some workflows use s3. 5 3rd party APIs handle a few concerns like payments, opening support tickets or similar. We might not even have a trivial way to set up "new clean test" on a local machine. Now, the AI made a significant change to a shared python library that deals with the DB.  
When you call the typescript web service, which will then call 15 different services, how easy will it be for the us to trust that all read-only transactions stay read-only and that the latest change doesn't accidentally override a value in some obscure sequence of events where Stripe returns 502 once every 3 weeks?
We can't run all the options. It might not even be possible to technically test all failure modes for all 3rd party services that we use. And would it not run for 30 years if we tried?  
And since we're not testing it out, what will we do? Do you trust any model that tells you "I've seen all the context, there's no sequence of events that triggers a dormant bug from 2 years ago and breaks this"?  
We need to trust it, or this doesn't work.

Now, there are solutions, but they require specific design patterns and tooling.  

I'll finish this point here, because this is already a very long post.  
If what I wrote here has not convinced you - let's mark this as a debt to be explained, and one of the planned posts in
the series will take a deep-dive into this point.  

For now, let's assume that adding good, fast tests to an arbitrary code base is very hard.  
Hard enough that to make the paradigm shift it's easier to switch coding styles than it is to create tools that can deal
with the old code style.

## Security
I'd be remiss if I didn't mention security.  
Even for something as simple as testing locally - the disk on our machine typically has a `.env` file with secrets.  
Automatically running a unit test that was created automatically, on code that was created automatically might leak that.  

So if we want to be able to just let the AI do its thing with minimal supervision, it might be a good idea to have some guardrails.

## Frameworks
It therefore seems that the most make-sense way forward, is to build AI-compatibility into every part of software
creation - design, coding, workflows, security etc.

If tests on a general codebase are hard, let's have a design that guarantees our codebases can be tested.  
If we need to avoid leaking information, we probably need to address that.

It's difficult enough to solve these issues if we "own" the tech stack and design, and can freely run
any part of the code that we want.  
If we don't, it just becomes exponentially more difficult.

We need to understand what AI needs, and give it that, instead of trying to have it "just work" on whatever arbitrary
code base we happen to have.

This is what I think of as an AI-native framework.  
It would take a certain use case (hopefully relatively broad) and design some of the of the aspects of the project to
make them AI-compatible.

I don't know what would be the granularity of these frameworks
- Maybe it'll be a single idea like testing at a certain layer in an http web server and you would compose a bunch of 
these together
- Maybe it'll be "FastAPI + Postgres + React has at least these layers and tests that look like these"
- Maybe it'll be much more generic than that.
- Maybe the only frameworks we see will be part of paid platforms that also contain the AI engines that use the frameworks. You could satisfy a lot of these requirements by having something like Wix and have custom-generated-code hook into different parts of the system. I don't think this is where it's going, but maybe.

What I am sure of is that frameworks will set up software projects so that AI engines can have effective feedback
loops.  
They will include at least some strict design and testing guidelines, and will probably include ways to document and declare a
spec for parts of the software.  

I do believe the successful ones will probably be technology-specific, at least to some degree.  
There are things we can do with some technologies that we can't do with others, and they matter.  
For example, we don't have static types in javascript (put aside jsdoc for a sec), but we do have them in typescript. This
changes some tradeoffs of what's easy for the AI to self-heal and what is not.  

I believe some of the conventions we see in these frameworks will be very similar to what some teams already do.  
But some will not. It is easier for a machine to do some things that are difficult for us and vice versa.  
For example, the way it makes sense for an AI to use types is typescript is not the same in my opinion as the common
conventios. I'll dig into this quite a bit later on.  

Some tooling will almost certainly be very different from today.  
I don't think we'll have Python code generation at scale without at least something like a sandbox be part of common
frameworks. Maybe even the ability to easily configure file access, limitations on network calling etc.

## Wrapping up
I hope I managed to make the case that it'll very difficult to have industrial-strength code generation at scale for arbitrary code bases.  
And that we must therefore explore frameworks that would allow us to control enough of the structure of the code
that would allow the AI to have an effective internal feedback loop.

In the next post, we'll start exploring an example of what a simple framework might look like.
