+++
title = "Footgun #1 - There Are No Tests"
date = 2024-10-04T13:01:56+03:00
[cover]
  image = "10_footguns/10_footguns_01_there_are_no_tests_cover.png"
+++
(this post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

This is a "warm-up footgun" to the blog post series.

The easiest way to shoot yourself in the foot, testing-wise, is to have no tests at all.

In my experience, writing any tests often helps us - even if these tests are not well-written, and even if they're just a drop in the sea.

There are a few reasons I noticed, why moving from no tests at all to even one test for some area of the code is useful.

### Code changes around hotspots
Code changes are not uniformly distributed.

If we have a signifcantly-sized code base and we look 6 months to the past, we will see that changes tend to happen in the same places. We don't change all types of features all the time and all types of infrastructure all the time.   
Features tend to evolve iteratively, and bugs that are introduced are statistically fixed in the following weeks or months.

So chances are - if you've changed an area of the code today, you will change it again in the next month.

For automated tests, what this means is that adding tests for the code we're working on now tends to have a much larger impact than we might assume, because they are likely to protect us in the next few weeks.

### Zero to one
As with many, many considerations in any kind of project - making the first move is an uncomfortable "awkwardness" - we don't exactly know how to do it.

But once we have a single test, we have an initial "paved road", and we can keep improving in iterative steps, which is far easier.

### If you never start, it's 100% you'll stay at zero
Maybe the first test you're writing will be the last.  
But maybe it won't, and it'll lead to way to having a much better developer experience.

If you never write the first test, you will definitely not write tests number 2, 3 and 20.

### My own experience
I can't back this up with anything besides "I've seen this enough, that's the way it is" - but I can tell you that I almost never regretted writing the first few tests for a piece of code.

In almost all cases, it did help me improve the code design and prevent bugs.

# Conclusion
Start with something easy and simple, as long as you start :)

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/02_untested_tests">next post: Untested Tests &gt;&gt;</a>
</div>
{{< /inline >}}
