+++
title = "Footgun #8 - Test Doubles Everywhere"
date = 2025-05-16T10:17:56+03:00
[cover]
  image = "10_footguns/10_footguns_08_test_doubles_everywhere.png"
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)


Footgun 8 - test doubles everywhere
Sometimes, in a test, we switch a part of the system, a dependency, with an alternative implementation.

These are called test doubles. Things like stubs, mocks and fakes.

The main reason we use them is performance - if the real thing is too slow to run a lot of tests, we switch it with a fast test double.

Test doubles can be useful, but…


Test doubles are a re-implementation.
They know the implementation details of the thing they're replacing.
Different types of test doubles do it differently, but this is what they do.




The main problem this causes is correctness.
The test double might not behave exactly like the real thing, and that makes the tests less accurate, less correct.

And as times goes by,

the real thing might be slowly changed,

but the test double would stay the same, so it would drift further and further from reality.

And, of course, this can hurt your foot.

This is actually a flavor of the implementation vs. behavior problem.

There are some differences, but essentially, it's the same category of issues - tests that use test doubles are not as good at catching bugs, and sometimes they fail even though the code is correct, causing all that extra work.

So, test doubles - use, with caution.


The question is - how do we avoid the pitfalls?
And I'll suggest a couple of ideas


First - code design.
So important.

Try to design so you can test a lot of functionality effectively, with fast unit tests, that don't need test doubles.
Not ALWAYS possible, but a lot of times it is.


Another thing is to choose which test double you're working with.
And I suggest to mostly use fakes.

A fake behaves like your dependency, but fast.

For example, a fake database table can be an in-memory list of tuples, where each tuple is a row.
In tests - it behaves the same way.


We can make a fake more realiable by writing some tests, not for the code - but for the fake itself.

For example, we can run the same operations against the fake and the real thing and verify we get the same results.

It'll never be 100% the same - we make tradeoffs in how much we are willing to invest in testing the fake.


Sometimes, a reliable fake already exists.
For example, if you're using SQLite - Python actually has a built-in, in-memory implementation.

So google it, maybe you'll get lucky.


An interesting thing you can do with fakes, is to run exactly the same test - once with a fake, and once with the real thing.



For example, maybe we have 10 tests, and that's too much to run against the real thing.


So we run all 10 with the fake.


And then, we choose the 2 most important ones, and we run them ALSO with the real thing.
And this gives us some real world certainty.


The essence of the idea is to use test doubles, but selectively verify their correctness until we get an acceptable tradeoff.


Another way to "use test doubles and verify" is by caching recordings.
We can record HTTP requests, DB actions, or anything else.



For example, at CodiumAI,
We have an HTTP service that calls another HTTP service - an AI layer that does code analysis and generation.


So, in our tests, we record and save the HTTP interactions between the main server and the AI server.


Locally, we run the tests against the recordings, so they are very fast.


But - we also verify.
In the cloud, we also run the tests against the real thing to make sure they are still valid.





## Conclusion

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/07_improper_test_scope">&lt;&lt; previous post: Improper Test Scope</a>
|
<a href="/posts/10_footguns/09_slow_tests">next post: Slow Tests &gt;&gt;</a>
</div>
{{< /inline >}}
