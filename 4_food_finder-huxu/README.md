# Food Finder

## Student Information
Name: Huakun Xu

CSE netid: huxu

email: huxu@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
 - Aesthetically
 - How are you nudging people toward patios on sunny days?

 I wanted the app to show the food place, distance and an icon if patio or not. Then click on it for more information. I wanted the app to change colors based on the weather condition. When it is sunny, food places with patios should be moved up.

Where in your repo can we find the sketches that you made?
Assets.

If your final design changed from your initial sketches please explain what changed and why.
I originally wanted to use a custom scroll view (idea from section) but decided to use grid view instead (when I started coding) because it felt less like what Ben did and I felt like clicking on boxes seemed more intuitive than rectangles. I also originally had a tab on the bottom to switch manually switch colors based on what weather color the user liked better. But that felt redundant and could have made some problems if the weather changed so I decided against it when I went to implementing (after reading the specs for the views part).

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

https://pub.dev/packages/geolocator (Geolocator code copied as per spec for PostionProvider)
https://pad.riseup.net/p/bjLZPwQGUnzvbpFwtfna (Copied over venues as per spec, thanks classmates)

## Reflection Prompts

### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

I learned a lot about grid views and how frusating getting position data to work is. If I make any mobile app in the future, I will likely need to track location data in some capacity to make a profit and this will help with that.

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

Getting the location stuff to work properly (still not sure I got it right). I learned that working with constantly changing and updating data is rough and I need to take things slowly when working with it. I can't think of any improvements off the top of my head.

### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

I kept finding myself forgetting I adjusted something in one part of the code, so I would forget to change everything connected to it. I did that a lot in the views and just sat there for 10 minutes thinking I misread the documentation for something. I also forgot to add some imports when adjusting stuff because I am so used to it showing an issue and fixing it in a click but like 3 times in this project it didn't work like that and I can to figure out the missing import and manually add it. I will slowly read through my code more throughly when I have a mistake because I have made so many simple mistakes this project it's not funny.

### Optional Challenges
Tell us about what you did, learned, and struggled with while tackling some of the optional challenges.