+++
title = "AI Feedback Loop, With an Example"
date = 2025-05-09T13:01:56+03:00
draft = true
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this is the first post in a [series]({{< ref "/posts/ai_frameworks/01_ai_frameworks_intro.md" >}}) about creating
production-grade maintainable AI-first projects, using AI-first design patterns and frameworks)

In this post we'll discuss why an internal AI feedback loop is a good idea, and give a simple example for what it might
look like.

## A reality of imperfection

There's a fundamental truth about "making things": it's not going to be perfect.  
The specification might not be clear, some implicit assumption might be incorrect, and of course a simple mistake might
sneak in. Randomness will happen.

A more concrete way to think about it is that when a change to the code is made (either by a human or by an AI agent),
there's some chance that a mistake will happen. Let's use the term "bug rate".

Noting - I'll call all this randomness "mistakes", "bugs" or "errors", because for our purpose it usually doesn't matter
if the incorrectness is the result of an unclear requirement or a bug etc.

Humans have a non-zero bug rate, and so does AI.
When AI makes a change, sometimes it won't be what we need.  
What we want, is to improve productivity given that fact.


## The feedback loop
The way we generally deal with this "reality of imperfection" (regardless of AI) is to iterate. We all know this,
it's our day-to-day.
1. We plan - decide what to do next.
1. Then we do the thing.
1. We verify - get feedback (check if that thing is a step in the right direction).

Then we repeat until done.

When we use AI agents, it's the same thing: we ask the agent to do something and it returns a result. We verify that
result and move on to the next iteration - whether it's fixing the results or doing something new.

If the agent has a high bug rate (==its output has a lot of mistakes), we have more work to do.  
So we want to find a way to reduce the AI agent bug rate, given that LLMs have a non-zero bug rate.

The way to do that, is to give agents their own internal feedback loops.  
We want to give the agent ways to do some verifications on their output and auto-fix bugs before returning their output
to us.  
We don't expect bug rate to go to zero (== agent finds ALL mistakes) - but maybe it's possible to find MOST mistakes.

This idea is not news (agents today already do some verifications - they'll use a linter if available, run tests in
some cases).  
What I'm saying is that we want to make this one of the "stars of the show".

## Smaller is better
An important consideration, is that as a rule of thumb, smaller "things" tend to work better here.

- Changes in small code bases have lower bug rates than changes in large code bases.
- Small changes have lower bug rates than large changes.
- A feedback loop with wany small iterations with some verification after each, works much better than few very large
iterations (you wouldn't write code for 5 days without ever running it or even getting IDE warnings, right?).

Intuitively, we should be aiming for the same thing with AI - small, contained changes with good verification after
each iteration.

## A feedback loop example
When I'm able to set up an effective internal AI feedback loop (which is not often unfortunately) - that's when I'm
able to get the most of AI agents.

Now, although this might be trivial to some devs that have dived deep into AI-assisted coding, I feel that for many
people, the concept of an "internal AI feedback loop that auto-heals errors" is pretty abstract.
So - let's look at an example.  
It's a small project (python API service) that's set up for a feedback loop (I went with Cursor, since it's the most
common ATM).

What we want to see here is the feedback loop "in action" - we give a task to the AI agent, and we want to see how it
validates and auto-corrects itself before proceeding.

### A note about complexity of the project:  
I think of it as simple, but not trivial.
This is a small project with fairly simple (and un-optimized) Cursor setup.  
Existing vibe coding tools already one-off projects which are far more impressive.  
The objective here is not to show something that's difficult for existing tools, but rather to show what a feedback loop
when changing existing code might look like.  
Later posts will have projects which are more complex both logically and technically.

### What's the project?
I initially wanted to go with a super-trivial example like a simple todo list, but with current AI models, I was
concerned they just won't make enough mistakes with something so simple, and without mistakes you can't show a feedback
loop.  

So I went with a "bigger todo list" - a backend API for a task management service, where we have tasks and projects with
filtering etc.  
I also created a frontend so it's easier to play with the backend, but we'll focus on the backend for now.

The project is set up with technical layers and test suites that are enough to make this size of project fairly stable.  
The AI agent has configuration (Cursor rules) that allow it to maintain these: it knows the archituctural layers, it 
knows which tests suites are the most important, it understands it must run tests and other validations like linting
and type checking after each code change.  
There is also a "taskmaster" setup so the agent can break down tasks into smaller tasks and work on them one by one,
which restricts task size (and hence makes us have less blundering).

I'm providing some details about the service here. These are useful

The repository can be found at:

A few details about the service:  
Domain:
- We have projects.
- Project contain tasks (each task always has a single project associated with it).
- Tasks can be completed or deleted.
- Projects can be archived or deleted (if they are empty).
- Tasks can be filtered.

Technical:
This is a rough diagram of the application layers and the layers that the central test suites target:


 (if you're not a Python person - no problem. Understanding all the details is not the main thing here. Read
through, you'll get the gist):
- Python
- FastAPI framework
- DB is locally running SQLite (this is only a demo project)
- No auth (again, just a simple demo)
- Code design:
  - There are fairly standard app layers:
    - Top-level application object
    - API handlers
    - DAL (data access layer)
  - Interfaces:
    - HTTP API structure is defined using data structures (pydantic data models).
    - The interface to the DAL also works only with data structures (no ORM / SQL happens outside the DAL).
- Test design:
  - The DAL has tests: `/tests/dal`. Mostly `/tests/dal/repository.py`.
    - These tests only use the DAL interface, meaning they only create and access data through the DAL, they
    don't directly touch the DB.
  - There are service-level tests: `/tests/api`.
    - They test the HTTP API using a "TestClient", which is a utility provided by the
  web framework we're using to allow us to simulate http requests to the service - so we "send http requests" to a
  "running server" inside a test process, but there's no actual server running and the requsets are really just function
  calls. This is a fairly standard utility in many backend frameworks.
    - These tests only operate at the HTTP API level - data is created by calling HTTP endpoints, for example, it's not
    directly inserted into the DB.
  - There are a bunch of other tests, but they're less interesting ATM and the feedback loop will actually be just fine
  without most of them.

Here's a rough



Here's a short video (no sound) to show what 



The idea is not to discuss any specific technique, 

I'm giving an example of a project that's very small, 


In this post I'll focus on the reason I think frameworks are the direction and what I think they will include,
where following posts will dive deeper into the technical details.  
The objective here is not to "convince" (that would not fit in a blog post :) ), but to lay out the main points.

At a very high level, the rationale is this:
1. It makes sense to "aim our coding for the AI", because it'll be the new norm.
1. With the current way we're making software, it's just not realistic to make a paradigm shift happen, because AI 
cannot have a feedback loop that's good enough to change code at an acceptable speed and self-heal enough issues.
1. Therefore, I believe the best forward is to have frameworks that dictate some important aspects of the code and
workflow, in order to give AI what it needs so it can do its job.

Let's dig in.

## An industrial revolution
Soon enough, the vast majority of code will be written by AI.  
So in a sense, this is a large automation movement.  
Things human craftsmen currently make will be handed over en masse to the machine.

Given that, it makes sense to think about the common case for software creation, which will soon be the automated
process.  
And as with other automations, the automation might involve a redesign.

The printing press is not a faster pen. An assembly line is not a faster human craftsman.
They create in a different way, and their outcome is a little different.  
And we should expect the same from automating software creation.





## The size of an iteration
The shorter a feedback loop is, the better.  
Any mistake can send you off in the wrong direction, so you want to get feedback as early as possible.

A simple example that can help visualize why this is important would be to imagine writing code for an entire week
without ever running it, compiling it or getting warnings from the IDE.  
We all know that the result is going to be pretty nasty. No serious developer will choose to work like this.

This matters A LOT (personally, "iteration size" is the main "metric" I look at for improving productivity).

## AI and our feedback loops
Although not always discussed this way, a lot of what we're doing now with AI tools is integrating them into our own
feedback loop.  
And when you look at it from this angle, you can see that a lot of the techniques we use to improve the performance of
human+ai are just optimizing some part of our feedback loop - adding steps in the process for detailed planning,
breaking down to smaller tasks, making sure the correct context gets in so it's easier for the AI to "do" etc.

## AI's internal feedback loop today 
An observation I'm making here is that the AI has (or can have) its own feedback loop before it hands the latest change
over to us.

My own experience, and I'm sure many others' as well, is that the best outcome I get is if I set up an AI assistant for
a feedback loop. Each step looks like this:
1. Understand what to do next
1. Create something small
1. Verify. For example, write a new test + Run all relevant tests. If something breaks - the next action would be to fix it.

I let this run automatically in a loop until either all tests are green, it gives up or it starts going crazy.  
This is possible, for example with Cursor, for some time now. In fact, Cursor will try to self-heal what it can out of
the box - stuff like lint errors.

This works extremely well. The AI having its own internal self-healing feedback loop, backed by the right tests to make
me feel safe-enough that nothing breaks, is a different category of productivity.  
Some bugs still get through to me. I test, but it's kind of "skipping to the end of the process" - I would also do the
same tests if I wrote the code, and find similar bugs.

When I can set it up, it's just great. But... for most of my work, I can't.

## AI's internal feedback loop tomorrow
When I distill the situation as far as I can, this is what remains.  
1. An LLM will statistically do the wrong thing sometimes.
1. Large, standard codebases and systems are FAR too complex for these "imperfections" to be rare.
1. So if we want to avoid most of these bugs reaching a human - we must allow the AI to self-correct using a feedback loop.

A feedback loop is therefore sort-of a "constant" in this "movement to AI". A requirement that must be satistified for 
large, ongoing projects.  

It follows that at least for complex projects (though I would say for almost all projects), our best bet is to adopt
coding practices that work well with such a feedback loop.

These kinds of coding practices are what I call AI-first frameworks.

## What are some limiting factors?
So, why don't we have such feedback loops for our projects today?  
Why don't we just tell the AI "here's a project with a million lines of code. Add a small feature", and then it would do
changes and verify them itself?

If you're following the trend on social media, you can see that improvements happen all the time, both in tools and how
to use them.  

But if we look from the perspective of the plan-do-verify stages, we can see that almost everything falls between 
"plan" and "do".

There are definitely improvements in "verify" (and companies that emphasize quality*), but for the "general project"
there really is no big news. AI assistants will generate code and if you ask they'll generate some tests. But there's no
tool that you can throw on your project that would make changes and make sure nothing broke.

So 


Twitter is full of tips and tricks on rule files and project documentation, workflows that break down work
into small steps etc.



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
processes, but the more hairy issues involve things like like relying on some external thing for which it's tricky to 
simulate failure modes.
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

NOTE: maybe say something like
If you want to make sure that an endpoint is read only, you can do ad-hoc static analysis to try to make sure that there
is no code path where an sql query that changes data runs, you can write thousands of tests covering many possible
scenarios for what might have been in the DB to begin with etc.  
You can also use some permissions framework and only give that endpoint read-only access to the DB. 
Then, in order to test that "endpoint_x doesn't write to the DB" we just need to make sure that we use the permission
framework and that the endpoint was indeed assigned read-only permissions.  
It's not a very common approach today, but it's easy to see how it eliminates categories of bugs very easily and very
reliably.


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


* About companies that emphasize quality - I'm biased, as I worked there in the past, but if you're interested you might
want to have a look at Qodo.

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/ai_frameworks/01_ai_frameworks_intro">&lt;&lt; previous post: AI-First Development Frameworks (intro)</a>
|
next post: (coming soon) &gt;&gt;
</div>
{{< /inline >}}
