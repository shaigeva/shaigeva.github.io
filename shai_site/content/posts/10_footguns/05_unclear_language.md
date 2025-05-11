+++
title = "Footgun #5 - Unclear Language"
date = 2024-10-18T20:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_05_unclear_language.png"
+++

(this mini-post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

One testing problem that doesn't get enough attention in my opinion is tests that don't have locality of behavior.

By that I mean cases where a test is broken down into different parts in a way that makes understanding more difficult.

This is important in every type of code, and tests are no exception.

## Example: non-local data
Consider this test:
```python
def test_something():
    data = Path(PATH_TO_DATA_FILE).read_text()
    assert calc_something(data) == 4.5
```

The data that the test uses is in a different file, so in order to understand the test we will need to locate that file
and open it.  
Even if the data was in the same file, but a different place - it would still be an issue.

Now, sometimes we don't have a choice, and it's the only way to do it.  
But sometimes we do.

For example, if we can find a data example that's small enough, we can do something like this:

```python
def test_something():
    data = “””
{
    <JSON data>
}
“””
    assert calc_something(data) == 4.5
```

This is exactly the same test, but the data is local so it's going to be much easier to understand at a glance, without
"breaking the flow".

## It's easier in tests than in production code
One of the main problems with achieving locality of behavior is that it conflicts with DRY ("don't repeat yourself").

What's the problem with code duplication in production code?

You'll often hear people talking about the "economics" - if you repeat a piece of code 3 times, then if you need to change that logic, you would need to do that work 3 times.  
However, this is actually a secondary consideration, especially if the number of repetitions is not high (let's say 5 or less).  
The real issue with repeating yourself is that duplication is an implicit dependency.  
If you repeat the same logic in 3 different places, there's a risk that if the logic needs to change, you would not notice one of these places, which would cause that "usage" to be deprecated and incosistent with the rest of the code - which will result in bugs and maintainability overhead, of course.

The nice thing about tests here is that this consideration is weaker, because of several factors.
1. When we change code that has a test and make it behave differently, the relevant tests will usually break, so we will have something that points out to the duplicated "usages". Where in production code - we only get that benefit if that piece of code has relevant tests - which might be very far from "always".
1. If the tests are focused and verify only a single fact, the number of times that we have duplication will be lower. And it's far easier to write a test (at least a test that's not end-to-end) that "checks one thing" than it is to write code that "does a single thing", because if a piece of code does multiple things - you can just write multiple tests that run it separately, and each of them would test one thing.
1. And, finally, if the mistake does happen in test-code and we forget to update a "usage" - it'll render the test "wrong", but it won't actually cause a bug. Making a test wrong is bad, but it's not as bad as a production bug, unless it affects a lot of tests.

Of course, duplication is still something to consider - if there's complex setup, or something that's not complex but repeats many times - it's probably worth it to extract functionality.  
The point is that in production code, the right time to extract functionality is often after two or three usages - but in tests the balance allows for more.

## Conclusion
Be aware that tests which are "non-local" are far more difficult to maintain, and make a conscious effort to find ways to reduce the problem.
