+++
title = "AI-Native Development Frameworks (blog post series)"
date = 2025-05-10T13:01:56+03:00
weight = 1
[cover]
  image = "ai_frameworks/ai_feedback_loop_1-min.png"
+++
(this is the first post in a series about ai-native frameworks)

Like many others, I spent a lot of time thinking about AI and software development.

I belong to the camp that believes that AI is a total paradigm shift - it'll redefine the ecosystem and what it means to
create software, and it'll be the deepest change we have seen to date.  

My own "flavor" of thinking about this is to try, from an **engineering** perspective, to understand what that change
would look like.  
Figure out what are the technical "bottlenecks" and what would move the needle on them.  
Do the LLMs have to be essentially smarter for this to happen? Do we need to create some specific tooling?
Disallow use of some tooling? Maybe a specific workflow?

I've come to the conclusion that the way forward goes through something I think of as **AI-native frameworks****, and 
AI engines that use these frameworks to develop software.  

Very loosely, what I mean by a framework is "definitions that dictate important aspects of the code and workflow".  
This can include things like programming language, tooling, conventions.  
The central point here is that we will not continue to write code like we do now. The specifications, design, coding
practices, testing and workflows will change.  

The main reason I think they will change is that any way I look at it, our current methods will simply block the major
improvements that are coming.

This blog post series will start with explaining at high-level why I believe our current practices won't work for a
paradigm shift,
and then dive into concrete, low-level examples: showing how something would be difficult for AI on general, and how
we can make it substantially easier by enforcing specific solutions.  
I'll try to set up POCs to show that things are realistic in places where it's more difficult to see (I'm not planning
actual implementation of a framework or engine).

We'll talk about design, tests, error handling, system architecture, random algorithms, 
functional programming, simulations, craaaaazy types, RAGs and a bunch of other cool stuff.  

Since I've had these ideas running around in my head for while and at least for me they are interesting, I felt like
it's time to share.  
I hope you find this interesting as well and that it'll spark some discussion :)  
Ping me on social and let me know!


** There are other names we can call this except AI-native. I also have AI-driven and AI-first in mind. The term 
AI-native actually comes from Tessl. I like it so adopted it as the main way I think of it.

**Next post**: [Why AI frameworks?]({{< relref "02_why_ai_frameworks" >}}) (high level)

