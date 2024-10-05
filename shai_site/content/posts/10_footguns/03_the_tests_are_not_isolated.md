+++
title = "Footgun #3 - The Tests Are Not Isolated"
date = 2024-10-05T20:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_03_the_tests_are_not_isolated.png"
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

Writing tests that are not isolated is a sure way to create unnecessary work for ourselves.

By "tests that are not isolated", I mean tests that sometimes have a different outcome (failing / passing) if we run only a subset of them, if we run them in a different order or if we run them in parallel.

Now, if you have 30 tests, and test number 24 fails because of something that happened in tests 8 and 15...  
Debugging is not going to be a pleasant experience, right?

This gets really bad.

And I suggest just not getting into it.  
Make sure there's nothing common between the tests - whether it's in-memory objects, rows in the database, doesn't matter.  
Make sure everything's separated.

