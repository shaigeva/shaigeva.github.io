+++
title = "Footgun #6 - Testing Too Many Things"
date = 2025-05-16T10:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_06_testing_too_many_things.png"
+++

{{< inline >}}
<style>
.code-example {
  background-color: #2E2E33;
  padding: 10px;
  margin-bottom:10px;
  border-radius: 5px;
  font-family: monospace;
  white-space: pre;
  color: #d5d5d6;
  font-size: .78em;
  line-height: 1.5;
}
.highlight-red {
  color: red;
}
.highlight-green {
  color: green;
}
</style>
{{< /inline >}}

(this mini-post is part of a [series]({{< ref "/posts/10_footguns/ten_footguns" >}}) about good testing practices)

Just like with product code, if we put too many things in the same place we get a mess.

My rule of thumb is to try hard to test a single fact about the behavior of the code.
And it helps if I use these specific words mentally.

SINGLE. FACT. About the BEHAVIOR.


## Example
Let's continue with our example from the previous post, and say we have a book store and we're testing the edit book functionality.

For example, that's a single fact about the behavior the code:
{{< inline >}}
<div class="code-example">test_<span class="highlight-green">user_can_edit_their_own_book</span></div>
{{< /inline >}}

And, this is not a single fact, it's too general:
{{< inline >}}
<div class="code-example">test_<span class="highlight-red">edit_book</span></div>
{{< /inline >}}



#### How do they compare?
- Easy to understand?
  - Single fact test: It's clear what the test checks. It's clear that it only checks that.
  - General test: we'll need to read and understand all the test code to know.
- Easy to debug?
  - Single fact test: If it fails, it's clear what functionality stopped working. And because it's small, it'll be easy
  to debug it.
  - General test: if it fails, anything related to edit book might have failed. We'll need to dig in. And it does a lot
  of things, so debugging might be a lot of work.


![Comparison between single fact and general tests](/10_footguns/10_footguns_06_testing_too_many_things_comparison.png)


## Conclusion
Try to have each test case will test a SINGLE FACT about the BEHAVIOR of the code.

This makes a huge difference and it's worth it to invest a lot into this.

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/05_unclear_language">&lt;&lt; previous post: Unclear Language</a>
|
<a href="/posts/10_footguns/07_improper_test_scope">next post: Improper Test Scope &gt;&gt;</a>
</div>
{{< /inline >}}
