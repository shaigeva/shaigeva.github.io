+++
title = "Why AI frameworks?"
date = 2025-05-09T13:01:56+03:00
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this post is part of a [series]({{< ref "/posts/ai_frameworks/ai_frameworks.md" >}}) about ai-native frameworks)

I'll focus here on the reason I think frameworks are the direction and what I think they will include.  

At a very high level, the rationale is this:
1. With the current way we're making software, it's just not realistic to make a paradigm shift happen, because AI 
cannot have a feedback loop that's good enough to change code at an acceptable speed and self-heal enough issues.
1. I believe there are solutions that will make it possible, with the current generation of LLMs, or close to it.

Let's dig in.

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
This is possible, for example with Cursor, for some time now.  

A note here: like with human feedback loops, speed matters. If every small change takes 15 minutes, then it's slow
enough that the human can't manage it, and it'd usually be better for the human to do it themselves.  

This works extremely well. The AI having its own internal self-healing feedback loop, backed by the right tests to make
me feel safe-enough that nothing breaks, is a different category of productivity.  
Some bugs still get through to me. I test, but it's kind of "skipping to the end of the process" - I would also do the
same tests if I wrote the code, and find similar bugs.

When I can set it up, it's just great. But... for most of my work, I can't.

## AI's internal feedback loop tomorrow
So when I distill the situation as far as I can, this is what remains.  
1. AI will statistically make mistakes at any given step it does.  
1. Large codebases and systems are FAR too large for these "imperfections" to be rare.
1. We must allow the AI to self-correct using a feedback loop, to minimize these.

Any coding the AI does and doesn't have a good feedback loop - we will have to understand every small part of it and
test it thoroughly.  
This has a "glass ceiling" of diminishing returns since even if the AI becomes far better at coding than it is today,
the changes will be so large that it'll be that much more difficult for us to reason about them and test them.  

Therefore: any coding that we want AI to do consistently, has to be backed by a strong feedback loop like this, where
it has the capability to consistently move forward, and it's rare-enough that it makes significant mistakes without us
knowing.  
It is also important that it'll very, very rare that unexpected and unrelated things break. If you add a button and a
serious security issue appears - that's not an AI workflow that backs a paradigm shift.

So the feedback loop is sort-of a "constant" in this "movement to AI". A requirement that must be satistified.  
There's no model strong enough, no shiny UX that will work without it, no brilliant prompt, no RAG pipeline that will
get just the right context.  
If it's too slow, if it can't prevent nasty surprises and can't auto-heal most issues before it hands us a result, there
are only incremental improvements to be had. Large increments, but still - it's limited.

## What are the limiting factors?
So, what's preventing such a feedback loop today?

Twitter is full of tips and tricks on rule files and project documentation, workflows that break planning out (and
also some tools for mananging plan execution, as composed of small steps).  
These help "plan" and "do", though far from enough.  

The way I see it, we have two significant bottlenecks.  
The first is understanding complex code well, incl. flow execution. I believe there are codebases where this works
pretty well, but certainly not consistently enough.
The second is the real limiting factor of the AI software movement - "verify".  

The tests.  
Well, mostly the tests - there are other verifications, for example automatically taking a one-time screenshot of a UI
component "before and after" is very much a verification, though it's not considered a "test" by most terminology. But
I'll include all verification in "tests" usually to be less verbose.


## The tests
When you change code, you check it somehow. Some of it with unit tests, some e2e tests that are only in CI, some you
test manually etc.  
Importantly, some of it you run in your head, with all the knowledge built from months or years dealing with the
business, system and code.

In order for the AI to produce code that is stable-enough, it needs to be able to "test out" the vast majority of issues
in the tight feedback loop (I would aim for seconds, though a minute might be possible).  
e2e tests in CI are fine, but if a lot of bugs "make it" to the CI - you'll often need to wait for deployment and CI to
run and feed back the error to your agent.  
That's too slow.  
If you have e2e tests that run locally and take 2 minutes and they often catch bugs - it'll still be too slow in most
scenarios. If you run the tests on each small change, a 2 minutes means complex tasks will take hours. If you run them
rarely, the chance of bugs happening in any run increases and so does the difficulty to debug. So catching bugs there
needs to be rare.


Now, I'm proficient with tests. I have given testing a lot of attention for two decades, I give talks about tests, I had
successes and failures and I have an "arsenal" of effective techniques.

Because of that, I know it's not realistic to add good tests to most code bases. At least, good tests that will be fast
enough.  
**CODE IS USUALLY NOT TESTABLE IF IT IS NOT DESIGNED TO BE TESTABLE.**

If you have enough experience with code that you felt "if this passes tests, I'm sending it to prod", you know you're
not getting getting that from a few dozen e2e tests for a system with a hundred thousand lines of code.  
Stable code usually means small-ish independent standalone components, each with dozens or hundreds of lines of
test-code.

Some common issues are
1. Logical complexity, where some component does a lot of stuff and it's difficult to isolate what you want to test
in a way that's both reliable and simple enough. Especially for complex flows that include multiple steps and many
components.
1. Technical complexity, where it's difficult to set up things. A simple example would be data samples for complex
processes, but the more hairy issues involve things like like relying on some external thing that's not easy to control.
1. Side-effects, where the code interacts with the outside world in some way.

Systems composed of many small services with different technical setups, different dependencies (maybe even different
languages) are specifically a very tough nut to crack.  
It is very hard to set up anything "generic" that can test something like that well.


There are solutions, but they require specific design patterns and tooling.  

There are also approaches that can semi-methodically take an existing codebase and fix some of the issues - but it won't
be all issues, it'll often be laber-intensive, and the result won't be as good as designed well from the ground up.  
It'll often not be good enough.


Try to consider adding fast, reliable tests to a CRUD API service that has one database with a lot of multi-step
processes and a couple of 3rd party http services it calls.  
I know how to approach this myself, and I can write an AI agent that will help guide a developer with how to set it
up, but it'll probably be labor-intensive (weeks? months?) and the result will be 

, if
it wasn't designed for that.  
There are thousands of calls to the ORM in the service
If you dealt a lot with testing, you'd have some good directions for how to do it if you start building it now.

I'll note this: If you haven't spent a lot of time testing real enterprise software, what I'm writing here might not
convince you.  
I plan that one of the posts in the series will be a deep-dive into this point, showing how the common testing
techniques that can be bolted-on code are just not good enough.

For now, you can get an intuition that it's very hard by considering how far most teams are in practice from giving AI
a way to run fast tests that will get rid of most bugs:
1. If you ask the standard cloud-service team, for example, how can they test to make their system rock-solid, they
don't know. They'll say something like "we had bad experience with too much unit tests, these days we do some unit tests
for the small stuff and end-to-end on the major flows. The developer that writes the code manually tests stuff that
don't fit in the test and we get by just fine".
1. 

For example, for side-effects, you can just try to run a test and add mocks that will return what you think makes sense
when the test fails, until you get the test to pass. But mocks are usually a horrible techniques. They assume more than
necessary when you write them, they drift from reality as the world changes, and they break every time you change an
API. They are tests of implementation, when we need to test behavior.  


In many teams, even if they have a lot of tests, there is still a lot of the code is only really tested by firing up the
system in staging, clicking on buttons and seeing what happens.  
There's no setup to automate this. And it would be too slow if there was.  
And A LOT of the more complex interactions, such as complex business processes involving multiple stages over many days
and a bunch of external services - these are only tested in the brain of the developer. "Yeah, I'm pretty sure that's
not going to affect that thing".  

Even if we automate this completely, it'll be too slow.  

If you try hard enough, there are ways to successfully deal with most issues - but the code needs to be designed for
that.

Let's say you have a service in a distributed system, as one does.  


But 


But for a paradigm shift, we need to almost always have very good tests.

