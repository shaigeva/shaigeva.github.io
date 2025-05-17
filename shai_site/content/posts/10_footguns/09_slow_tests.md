+++
title = "Footgun #9 - Slow Tests"
date = 2025-05-16T10:18:56+03:00
[cover]
  image = "10_footguns/10_footguns_09_slow_tests.png"
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)


Footgun 9: Slow tests

Yeah, slow tests are not fun.

I'll talk about two ways in which they are not fun.

The first way is what I like to think of as the bottleneck and the time bomb.


The bottleneck here is where the tests take so long to run, that we have a long queue of tasks waiting to be merged to the main branch.



What kind of numbers are we're talking about here?

Assume we have, say, 10 work-hours each day.


with tests that take 5 minutes.

So, that's 12 merges per hour,

Which is 120 merges a day before the tests slow us down.

For most teams, that virtually never happens, so a 5-minute test suite -

not a bottleneck.


On the other extreme, and it usually won't get to that but just so it's easy to imagine - 

if the test suite takes 2 HOURS,


Then we can only merge 5 tasks to main each day.


Whenever we want to wrap up a bunch of tasks quickly, maybe before a major version, the merge queue length becomes days.
If the tests sometimes fail, then this can happen on any random day.

It just doesn't work.

The team will probably just stop waiting for the tests to pass before merging, and spend a lot of time with the tests being broken.

Now, we can SURVIVE this way.
But it's a lot of extra work and it's really not what we want.


And really, even with less extreme numbers,

From what I see:

With a 30 minutes test suite



The same things happen.
They happen less, but they happen.


And, a few years ago I was actually part of a team where this happened.

When the tests took 20 minutes, I understood it's a time bomb and eventually things were going to get bad.

But I didn't have this clear phrasing of exactly how the slowness would be a problem. The bottleneck.


Another problem there was that the tests were also flaky and we always needed to fix them,
so it wasn't clear to most people that slowness was the more urgent problem.



After a while, we were getting all these problems every few weeks.
Multi-day merge queues, everything was stuck.
Real crisis mode.


It only became ok after we did an expensive project and made the tests run in parallel.
Tests would still break sometimes, but the queue got back to zero fast enough so it was not a crisis.

The question is - what do we do about this?



We don't want premature optimization, so what we need on day 1 is to make sure that WHEN we want to optimize, it's not going to be a very expensive project.


And specifically, it should be possible to run the tests in parallel because that's going to be the go-to solution.

The only thing we need for that, is to remember the footgun about isolated tests.
If the tests don't affect each other, they can run in parallel.

My advice is to consider this as a must-have.


Another way that slow tests can hurt us is by making our feedback loop longer.


The feedback loop is how fast we learn about bugs and understand what happened.
And I'm talking about any type of bug here - anything from a typo to complex concurrency issues.

The feedback loop is very important,
And anything that makes it shorter is very good.
Even a squiggly red line in the IDE.


I usually aim for a setup where most of the time, I'm working in watch-mode, so the tests re-run every time a file changes, and I run a sub-set of the tests that finishes within 2 or 3 seconds.

Being on the fast side is great.
For example, if a test fails just a few seconds after I wrote the code - I instantly understand what's going on.



With a 10-minute tests suite in CI - the commit with a failing test contains a lot of code.
Plus my brain will do a context switch and go catch up on slack.
So when I try to understand what's going on with the failing test - it's a lot more work.



Now, some tests HAVE to be slow.
But, we can still have pretty fast feedback loop.

What helps me here is that instead of asking
"How long does it take for the tests to run"
I'm asking
"How long does it take to catch a bug"


And I'm visualizing this using the "bug funnel".

All possible theoretical bugs come in, and some of them get filtered out on every stage.

And the key observation here is that what matters to the feedback loop is that we catch MOST bugs quickly.
We will have a good experience if the feedback loop is USUALLY fast.


Let's say we start out with a bug funnel that looks like this.
We only have long-running integration tests, and we only run them in CI.



So if we create 10 bugs - we need to wait and debug the CI 10 times.




If we start adding fast unit tests, then pretty quickly the bug funnel will look more like this.
We don't wait 10 times for the long-running CI anymore. Only for, say, 2 of the bugs.

For the rest of the bugs, so most of the time - we'll have a much faster feedback loop.



And try to run at least some of the tests in watch-mode!
You will have a 2-second feedback loop, even if it's not for everything.


And, as we discussed - you can also use test doubles, that's why they exist.

By the way, local recordings have a very good tradeoff here - you should try it.


## Conclusion

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/08_test_doubles_everywhere">&lt;&lt; previous post: Test Doubles Everywhere</a>
|
<a href="/posts/10_footguns/10_wrong_priorities">next post: Wrong Priorities &gt;&gt;</a>
</div>
{{< /inline >}}
