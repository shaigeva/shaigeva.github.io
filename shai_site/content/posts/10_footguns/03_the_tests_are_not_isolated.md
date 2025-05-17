+++
title = "Footgun #3 - The Tests Are Not Isolated"
date = 2024-10-08T20:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_03_the_tests_are_not_isolated.png"
+++

(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

Writing tests that are not isolated is a sure way to create unnecessary work for ourselves.

By "tests that are not isolated", I mean tests that sometimes have a different outcome (failing / passing) if we run
only a subset of them, if we run them in a different order or if we run them in parallel.

## Why is this a problem?

Let's say we have 30 tests, and test 24 passes if we run it individually but fails if we run the entire test suite.

If the test was isolated, then there are only a limited number of things that can go wrong. The things that the test
actually executes will almost certainly be the cause of the failure.

But now, of course, the reason for failure is not what test 24 checks, and not what any of the other tests checks
either. The failure is caused by an implicit interaction between test 24 and, say, test 8.

This is difficult to debug, of course, because we would first need to play detective and find that it's test 8 that's
causing the problem (which might take a LOT of effort, especially if the tests are e2e tests that run slowly or only in
CI), and then track the combined flow of the tests to find the problematic interaction.

But it's worse than this - what often happens is that we run the entire test suite, either locally or in CI, and test
24 fails - so we start analyzing it as if test 24 fails individually. We don't even consider that it's a
combined failure, and sometimes we waste hours chasing irrelevant clues, just to get to the point that we notice the
test passes if its executed separately.  
So the fact that we have "individual tests" is actually a misleading illusion that only distracts us from the
unfortunate truth - we have one gigantic test with inter-connected sub-sections.

If e2e tests run in parallel and sometimes run in different order, which makes this cross-test-failure flaky, we get the
perfect storm and we might spend days of work on this.

And, lastly, the situation could actually be worse - it might be that test 24 SHOULD fail, but it passes because of test
8, hiding a bug.

## What are the causes behind this?

There are rare cases like technical limitations (e.g. external service rate limits), but in the vast majority of cases -
it's shared mutable state.

A typical scenario for unit tests would be a global in-memory object, and for end-to-end tests maybe a row in a
database.  
Test 8 would change that shared thing, and test 24 would therefore have a different state when it starts to execute,
leading to the failure.  
Sharing a resource that's immutable (or never changes in practice) is not a problem - if it never changes, then it's
the same whether or not it's accessed by multiple "consumers".

I've also seen more subtle cases of shared mutable state, for example tests that would rely on an email being sent
through an actual email-sending service, and multiple tests checked for the same email.

## What can we do?

First of all, because in my experience this is so often a very painful problem - I suggest to avoid this from the
start, even if it means extra work or delaying writing some tests if can't make them isolated at the moment.  
**DO NOT** create a suite of non-isolated e2e tests that use long-living mutating database entities. This is very very
likely to cause a crisis down the road.

Because the problem is usually shared mutable state, we mostly just need to avoid that specific issue.

Unit tests can use the same in-memory objects, but they have to be immutable, or at least never changed by convention.  
If this is not an option - either create the object in every test or have some original which you clone at the beginning
of the tests.

The trickier part are higher-level tests that use expensive resources like a database, where full initializations might
cause the tests to be too slow.  
If it's not too expensive - initialize the entire thing, of course.  
Otherwise - make sure to clean up - delete created resources and revert the database / file system / etc. to its
original state before continuing.

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/02_untested_tests">&lt;&lt; previous post: Untested Tests</a>
|
<a href="/posts/10_footguns/04_no_locality_of_behavior">next post: No Locality of Behavior &gt;&gt;</a>
</div>
{{< /inline >}}
