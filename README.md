# Employee Directory

## Build tools & versions used

- Language: Swift 5
- XCode v13.2.1
- iOS 15.2
- CocoaPods
- KingFisher

## Steps to run the app

### From Github
1. Clone project
2. Open project in terminal
3. Run `pod install` (ensure CocoaPods is installed on your device)
4. Run `open EmployeeDirectory.xcworkspace`
5. Press Run or `ctrl + r`

### From zip file
1. Unzip project
2. Open a terminal and navigate to the project directory level where this readme is also found
3. Run `open EmployeeDirectory.xcworkspace`
4. Once Xcode opens and indexes the project, choose simulator type (ex. iPhone 13 pro)
5. Run `ctrl + r`

## What areas of the app did you focus on?

I focused on the architecture and user experience.

## What was the reason for your focus? What problems were you trying to solve?

I wanted to incorporate modern design principles and ensure the code was scalable. For the table architecture, I used a UITableViewController instead of adding a table to a UIController because it is the more modern apporach to implementing a table view.

In terms of the user experience, I wanted to ensure the app would be intuitive, so I made design choices such as enabling a refresh with a pull-down opposed to a button. Users commonly interact with pull-down refreshes on social media apps.

## How long did you spend on this project?

5 hours

## Did you make any trade-offs for this project? What would you have done differently with more time?

If I had more time I would optimze the photo api calls and create custom cells for the table. I would also add additional data validation.

## What do you think is the weakest part of your project?

The view renders before all the data is retrieved, so the user needs to scroll through the users before the profile photos appear.

## Did you copy any code or dependencies? Please make sure to attribute them here!

No

## Is there any other information you’d like us to know?

My experience developing in iOS is limited to the past 5 months and has focused primarily on deployment and configurations. However, I am a fast learner and willing to adapt my habits to become a better developer. I also try to ensure I am always using the best coding practices. I am more familiar with using storyboards to create layouts, but I wanted show that I can addapt to using new methods of development by creating the UI programatically.

Thank you for considering my application. I hope you find the best candidate for the position.
