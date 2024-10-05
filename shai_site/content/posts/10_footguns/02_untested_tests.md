+++
title = "Footgun #2 - untested tests"
date = 2024-10-05T17:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_02_untested_tests_cover.png"
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

Sometimes our tests lie to us.

We have a test that was supposed to protect us from some bug, but that bug happened after all.

Of course, what happened was that we made a mistake, and the test didn't really verify what we thought it does.

As it turns out - when we write a test, it's a good idea to spend a little effort to verify the test actually works.  
To make sure that if the bug happens, the test does indeed fail.

### How to avoid this
My suggestion -  
When you write a test, for every assertion you write, make a small change:

1. Either change the code a little and introduce the bug.
1. Or change the test a little bit, so it verifies something a little different.

This way you will be able to see if the test would have failed in the way you expect it to, and you'll be able to count on it.
