# Drawing App

## Student Information

Name: Huakun Xu

UW netid: huxu

CSE netid (if any): huxu

email: huxu@uw.edu

## Resources Used

Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

Zack Crouse, Tung Thanh Hoang, and Arda Egrioglu. (Final project groupmates)

## Reflection Prompts

### shouldRepaint
Covariant tells us that the parameters are subtypes of CustomPainter. Override is needed because CustomPainter's shoudlRepaint method accepts a parameter of CustomPainter while we are accepting a DrawingPainter. The logic is to repaint the canvas whenever _drawing changes, any updates to the drawing are reflected visually. This method determines whether a repaint is necessary by comparing the _drawing of the current DrawingPainter with the _drawing of the old delegate.

### New Learnings

What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

Were the examples and explanations from lecture helpful? How could they be improved in the future to assist with this assignment?

I learned how to work with custom painter or rather a sub type of it.
Anytime, I need to make a mobile app that uses touch and drag this experience will help.
Spiderpainter kind of helped. Not sure about improvement.

## Challenges

What was hard about doing this assignment?
What did you learn from working through those challenges?

Figuring out how to implement the stroke part because in theory it made sense to me but in pratice it took forever.
I learned that bouncing off ideas with others is helpful sometimes.

### Mistakes

What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

A mistake I made was not understanding what I needed to do for the oval tool, in theory I understood it but I couldn't implement it for a while because I didn't understand how to make an oval which needed a rectangle...
I need to read the documentation of the stuff I use more carefully.

### Meta

How much time (in minutes or hours of active work) did you spend working on this assignment?

7 hours

What parts took the longest?

draw_area because understanding what each pan was supposed to do was difficult at times.

What could we do to make this assignment better in the future?

It is probably fine as is to be honest.
