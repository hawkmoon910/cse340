# Reflection

### Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them:
1. Properties of People: Vision: App passes color contrast guidelines and the pie charts are colorful and isn't hard to determine different slices.
2. Properties of People: Motor Control (e.g. Fitts’s Law): The dropdown menu is easy to navigate and is an infinite edge.
3. Stateless & stateful widgets: There are three views two of which are stateful (TransactionView and DashboardView) and a stateless one (FinancialStatementView).
4. Accessing sensors (force, GPS, etc.): Position provider to get current position.
5. Querying web services: Tax API in account provider that uses location to tell us tax rate in current location.
6. Secure data persistence: Hive secure storage is used in main.

### Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?
We originally wanted to separate expense and income transactions and have a pop up every transaction to choose one or the other. We also intended to have a toggle for expense and income piee charts. We decided to have both pie charts showing and to make transactions include both expense and income. We did this to make the app simpler and less clunky. The pie charts thing was because originally dashboard was a stateless widget but then we changed it later on and for the sake of time we decided against changing it. Also having both at the same time still looks fine.

### Discuss how doing this project challenged and/or deepened your understanding of these topics.

Implementing the tax checker that called on the Washington State tax api to get the user's local tax rate deepened my understanding of how multiple providers can work together. With out app we have a position provider that gets the user's location every 30 seconds and a tax provider which is updated by the tax checker. This was a similar setup to the Weather App. So in this case the tax provider depended on the data of the position provider which was all handled by the tax checker that would call on the position provider for location data before calling the API. Also while working with these providers we learned about how the providers are actually not created when the program starts but actually when the first consumer of the that provider is made.

### Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app


### Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.
1. https://stackoverflow.com/questions/53359109/dart-how-to-truncate-string-and-add-ellipsis-after-character-number
https://dor.wa.gov/wa-sales-tax-rate-lookup-url-interface
https://pub.dev/packages/fl_chart
2. https://stackoverflow.com/questions/53294148/recreate-flutters-ios-and-android-folder-with-swift-and-kotlin
3. https://stackoverflow.com/questions/53294148/recreate-flutters-ios-and-android-folder-with-swift-and-kotlin
4. https://dor.wa.gov/wa-sales-tax-rate-lookup-url-interface

## Finally: thinking about CSE 340 as a whole

### What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?

There were a few answers to this question among our group. We all agreed that learning a new framework in general is very 
useful to know in the case that we want to develop an Android or IOS app. Also we though that learning the structure of 
UIs in general and how they work with state was very useful. For example learning how all UIs are tree structures of widgets 
and how these UIs use providers to update in the event that any state is changed was useful to breakdown and understand the 
inner workings of apps that we use everyday. We think that this and learning the workflow of using git in a group will be 
the most useful in the future because we will most likely need to use git in the future and if we ever go into mobile app
development we will most likely use functional reactive programming. 

### If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?

The pieces of advice we would give future students is as follows:
1. Use the flutter debugger, it is very useful to see what is causing your issue visually instead of searching through your code for hours.
2. Use the showSemanticsDebugger feature of the material app to debug the semantics of your app. If you set this parameter of a material app to true then when you use a screen reader, the app shows all the alt text the screen reader can see. It makes it very easy to debug any semantics.
3. Read the Specs and Docs! This was very useful to use when we unknowningly did not fully complete a part of the homework or got stuck on a part of the homework when the solution was in the docs for flutter.