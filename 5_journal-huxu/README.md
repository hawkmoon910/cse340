# Journal

## Student Information
Name: Huakun Xu

CSE netid: huxu

email: huxu@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
 - Aesthetically
 - Data

I wanted to make a workout journal to keep track of how much you are working out and what you are doing. The app is mostly white. It is supposed to use user input for data but some parts it does and other parts it doesn't as it can't save properly.

Where in your repo can we find the design sketches that you made? 
The newly made sketches folder.

If your final design changed from your initial sketches please explain what changed and why.
Didn't add top left home icon because I didn't get around to it, might do that for resubmission. Didn't get the exercise log in the way I wanted to like a list, I just didn't get around to doing it. Edit: scrapped the home icon and exercise log, replaced exercise log with three exercises.

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

https://docs.hivedb.dev/#/advanced/encrypted_box
https://api.flutter.dev/flutter/material/TextFormField-class.html

## Reflection Prompts

### Journal Purpose
This is a workout journal app designed to help people intereseted in fitness and athletes track their training progress, set goals, and optimize their performance. This app provides a platform to log your workouts, monitor your fitness journey, and stay motivated.

### Journal Data Design
String for workout type, 3 strings for 3 exercises, duration of exercise, String for notes/additional comments, timestamp for create and edit time, and String for the date MM/DD/YYYY.

### JournalEntry Constructors
The three constructors work together to create, initialize, and modify Journal Entries. This is very flexible and convenient for managing the journal entries.

### Journal Getters
Copying the list alone is sufficient because the list being copied contains references to JournalEntry objects, not the actual objects.

### Journal Provider
Another approach to ensure consistency is to directly expose the _journal instance from the provider but encapsulating it with a getter method that returns a copy of the _journal. This way, consumers can access the journal but cannot modify it directly. The provider would internally manage changes to the _journal and notify listeners accordingly.
Pros: Simplified implementation without the need for proxy methods and direct access to the original journal for consumers.
Cons: Consumers need to remember to use the getter method to access the journal to ensure consistency and there is a risk of accidental modification of the original journal if consumers access it directly.

### Robustness
Issues that can cause a user to lose journal data could be loss of encryption key, curruption of storage, and not backup data like icloud.
Implement a backup and restore data feature and an encryption key recovery system.

### Part 2 Reflection
I learned how to make data more secure and to keep data from previous state. Not sure if I was successful but I tried. I want to learn more about cyber security because it is very important to be safe on the web, so you don't get you information stolen. Figuring out how the do the encrypting for part 2 and finding out how to do the timestamp stuff.
I would give myself a 70 because my app apparently can't save which is a big issue but I think I did enough of the work and the assesibility stuff to get a 70.

### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

I learned more about how keyboard inputs work. This might be important in the future because all devices we use have some sort of keyboard.

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

Getting allEntries to work properly without using mock data. I learned that I need to work more with provider and consumer because I spent close to an hour trying to figure out what was wrong when I realized I wasn't even looking at the right dart file... More instructions or maybe more psuedocode as I got lost many times.

### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

I definitely messed something up with the updating or cloning because whenever I save or back out of an entry it clones itself... I just need to code better or at least understand the spec better?

### Meta
How much time (in minutes or hours of active work) did you spend working on this assignment? What parts took the longest?
What could we do to make this assignment better in the future?

10-12 hours. I should have spent more time and I usually would but this week has been rough... The views took the longest. More instructions and/or psuedocode.