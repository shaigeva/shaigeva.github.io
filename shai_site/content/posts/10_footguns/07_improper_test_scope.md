+++
title = "Footgun #7 - Improper Test Scope"
date = 2025-05-16T10:16:56+03:00
[cover]
  image = "10_footguns/10_footguns_07_improper_test_scope.png"
+++


Let’s say our Book Store is a web service, and it uses a DB.

We’ll think about two alternative test suites - “behavior tests” and “implementation tests”
And try to imagine what our life will look like if we would have chosen one test suite or the other.

We’ll look at an almost identical test in both test suites.

The test verifies that if we edit the description of a book, then it has really been updated.
Pretty simple.


Both tests have the same flow -
Create a book
Edit the book
Get the updated description
Make the assertion.


The behavior test does everything through the external http API, IN THE SAME WAY things would be done in the actual system.


The implementation test does some of the things at a lower level:
It creates the book by directly creating a record in the database, and it also checks the updated description through the DB.

So the behavior test only looks at the WHAT -
It looks at things as they appear from outside.

The implementation test also knows about HOW.
It knows how the code will change the DB.

Now, checking the implementation like this will USUALLY be equivalent to the behavior - but not always.

But why does this matter to us?

Let’s look at a possible scenario: 
We’ve had this test suite for a while, maybe even years.
We’ve invested a lot in them, and we rely on them.



Now, we’re making a change to optimize the database.

We’re moving the description out of the Book table, and into a separate table.


However, we’re not deleting the old field yet - we’ll do that later after all the data has moved to the new table.

Now, we’re finished with everything else, 
and, it’s time to update the edit-book endpoint.



Now, what if we just forgot to update the edit-book endpoint?
Completely forgot.

It now changes the wrong field in the database so behavior-wise, it doesn’t do anything.
If this gets to production, then we created a major bug.




If we chose behavior tests -
The test only uses the external API.
The behavior test…


Does not care about implementation details.
So if the behavior is wrong, the test will fail, just like it should.

The regression bug was prevented.
Everything’s ok.



If we chose the implementation test -


The test looks directly at old description field in the DB.
When we run the test, the old description field will change, just like before, so the test will not fail.

The regression bug was not prevented.
And a major bug made it to production.

It’s not ok.



On the other side of this, what if we made the change correctly?
Edit book now changes the new table instead of the old field.
No bugs, everything’s fine.


If we chose the behavior test -
Everything behaves correctly, so the test will pass.
We don’t need to do anything.

If we chose the implementation test -
The old field is not updated any more, so
even though the code is correct, this test will fail.

The distinction here is that the failure reason is not that the code is not correct.
The test fails because it has become technically invalid.

So, we have extra work - we need to figure out whether the failure is real or technical.
And then we’ll need to update the test.
Also - because we changed the test, we now have less confidence in it. We need to learn to trust it again.


On large code bases, this can become a real pain.
You have to update the tests, even if the code change has no bugs, and sometimes even if the test has nothing to do with the feature you worked on.

You end up wasting hours and you hate the test suite. 



Summing up

Cohesive, behavior tests - are closer to reality

They are better at protecting us.
The create less redundant work
And we have higher confidence in them in the long run.





One more thing worth mentioning: we looked at an example of a small, incremental change.
But sometimes, we need to make BIG changes. SCARY changes.
It happens less often but when it happens it’s a big deal.

For example, in a lot of companies, at some point, the DB doesn’t deal with the scale well.
We have stability issues, and we need to make a big change - maybe move the data to a different type of database.
And that’s when tests are MOST important.

And if we went with behavior level tests - everything will be fine.
Those same tests that we’ve been running with for 3 years now - we don’t change them.
When they pass, we’re done.

But if we went with Implementation level tests - they all become technically invalid and they all fail.
We will need to port all of them to use the new database,
but more importantly: because we’re changing them - we’re not going to trust them enough.

This might make the difference between a project that takes a few weeks, and a company-level event that drags out for months while the product has stability issues.



So I cannot recommend enough.
Test behavior.
A cohesive whole.

## Conclusion
a

---
{{< inline >}}
<div style="text-align: center; display: block; width: 100%;">
<a href="/posts/10_footguns/06_testing_too_many_things">&lt;&lt; previous post: Testing Too Many Things</a>
|
<a href="/posts/10_footguns/08_test_doubles_everywhere">next post: Test Doubles Everywhere &gt;&gt;</a>
</div>
{{< /inline >}}
