+++
title = "Footgun #10 - Wrong Priorities"
date = 2025-05-16T10:19:56+03:00
[cover]
  image = "10_footguns/10_footguns_10_wrong_priorities.png"
draft = true
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)


Footgun 10: wrong priorities


We saw a bunch of different practices,
and how they will affect us by changing the properties of our tests.

The bug funnel is all about performance.
"Testing implementation instead of behavior" us about maintainability and strength.

But how do we prioritize?


Now, the objective of tests is their strength.
We have tests so that they catch bugs.


The unintuitive thing is that this is not what we should prioritize when we work.

Start with making them maintainable,
Then make sure they are fast enough
And then make them strong


Here's the thing


Slow tests are weak, or at least they are EVENTUALLY weak.

Let's say that, as a team, we decided that we are not willing to have tests that run for more than 30 minutes.

If, at some point the tests reach 30 minutes...

It becomes very difficult to add more tests.

So after enough time, there will be a lot of code that's not tested well.

And the same thing happens with maintenance.
It's more subtle, but if tests are not maintainable, it costs more to have them, and we end up creating fewer tests.
So again, they will be eventually weak.



And, maintainability issues can also make it difficult to handle performance.
An example we saw is test isolation and parallelization.

In other words,
Maintainability is a necessary condition for performance, and both are necessary conditions for strength.

So make maintainability the priority.
Testing a single fact, code design and all the others.

When you have a choice to make - I suggest to go with the most maintainable option almost always.
Even at the cost of other things.
Because in the long run, that's how we get tests that let us move fast, and have confidence in our code.


## Conclusion

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/09_slow_tests">&lt;&lt; previous post: Slow Tests</a>
</div>
{{< /inline >}}
