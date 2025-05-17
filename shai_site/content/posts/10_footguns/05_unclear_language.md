+++
title = "Footgun #5 - Unclear Language"
date = 2024-10-18T20:15:56+03:00
[cover]
  image = "10_footguns/10_footguns_05_unclear_language.png"
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


Another problem that makes it more difficult to understand tests is unclear language.

Two guidelines that help me deal with this:
1. We want to use decisive language
1. We want the language to be specific and explicit


Suppose we have a book store and we're testing the functionality for editing a book.  
Let's see some examples of test phrasing:

---
{{< inline >}}
<div class="code-example">def test_<span class="highlight-red">edit_book</span>():
    ...
</div>
{{< /inline >}}

This is simply too general.  
There are so many things that might be tested, and this means almost nothing about what will get tested in practice.

---
{{< inline >}}
<div class="code-example">def test_edit_book_<span class="highlight-red">works_correctly</span>():
    ...
</div>
{{< /inline >}}

Adding things like "it works" or "it's correct" - most of the time, this is just bloat.  
It only makes the name bigger, but doesn't give us any extra information.

---
{{< inline >}}
<div class="code-example">def test_user_<span class="highlight-red">should_be_able_to</span>_edit_their_own_book():
    ...
</div>
{{< /inline >}}


That's much better - it's a lot more specific.  
The only problem here is the indecisive language.

Why "should"?  
Will this ever NOT be correct?

It's both bloated and confusing.  
So this as well - not optimal.

---
{{< inline >}}
<div class="code-example">def test_<span class="highlight-green">user_can_edit_their_own_book</span>():
    ...
</div>
{{< /inline >}}

That's much better in my opinion.  
It's decisive, explicit and specific.  
I suggest to aim towards this whenever possible.  

---

## Conclusion
When phrasing test names and descriptions, try to aim for decisive, specific and explicit language.

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/04_no_locality_of_behavior">&lt;&lt; previous post: No Locality of Behavior</a>
|
<a href="/posts/10_footguns/06_testing_too_many_things">next post: Testing Too Many Things &gt;&gt;</a>
</div>
{{< /inline >}}
