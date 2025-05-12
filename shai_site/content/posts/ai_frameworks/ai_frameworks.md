+++
title = "AI-Native Development Frameworks (blog post series)"
date = 2025-05-10T13:01:56+03:00
weight = 1
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
Like many others, I spent a lot of time thinking about AI and software development.

I belong to the camp that believes that AI is a total paradigm shift - it'll redefine the ecosystem and what it means to
create software, and it'll be the deepest change we have seen to date.  

My own "flavor" of thinking about this is to try, from an **engineering** perspective, to understand what that that change
would look like.  
Figure out what are the technical "bottlenecks" and what would move the needle on them.  
Do the LLMs have to be essentially smarter? Do we need to create some specific tooling? Disallow use of some tooling?
Maybe a specific workflow?

I've come to the conclusion that the way forward goes through something I think of as **AI-native frameworks** (or AI-drive,
or AI-first), and AI engines that use these frameworks to develop software.

Very loosely, what I mean by a framework is "definitions of the shape of the codebase". Kind-of like React or Python's
Django are frameworks - language, tooling, conventions.  
The central point here is that we will not continue to write code like we do now. The design, coding practices, testing
and workflows will change.  
Aside from the fact that I think a change has better UX, the main reason I think they will change is that any way I look
at it, our current methods will simply block the major improvements that are coming.

This blog post series will be a little non-standard.  
There will be posts that discuss high-level ideas, but most of it will
be dedicated to analyzing the situation and pointing out some lower-level technical directions.  
The plan is to do a discussion of technical ideas, and a few POCs to demonstrate things are realistic in places where
it's more difficult to see (not planning implementation of a framework or engine ATM).  
We'll talk about design, tests, system architecture, source-controlled caches, random algorithms, functional
programming, simulations, craaaaazy types, RAGs and a bunch of other cool stuff.

Since I've had these ideas running around in my mind for while and at least for me they are interesting, I felt like
it's time to share.  
I hope you find this interesting as well and that it'll spark some discussion :)  
Ping me on social and let me know!

Posts (well, first post right now):
1. [Why AI frameworks?]({{< relref "01_why_ai_frameworks" >}}) (high level)
