# TimeTracker

## Environment

- Install Xcode 14.1 or higher from the [Apple Developer Portal](https://developer.apple.com/download/more/)
- There is no 3rd party frameworks needed and no dependency manager is used. You can open the project by opening the .xcodeproj file.

## Supported platforms

- While there are many platforms supported on the project's setup, the app is only tested on iPhone simulators.

## Structure

- The app uses MVVM pattern with an added redux mechanism. The view model holds a state and fires its changes through a handler.
- View controllers can listen to these state changes and adapt to their UIs accordingly. This way the view model can be unit tested easily.
- In this project I used UIKit. There is no storyboard (except the launch screen) and .xibs as I feel they are not easily manageable and hard to read when reading their contents on code reviews.
- I built all the UI with the help of autolayout constraints. 
