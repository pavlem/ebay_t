# ebay_t


First checkout the project and start the **Ebay_t.xcodeproj** file, there are no third party dependencies, so it’s pretty simple. In case you want to build on a real device, add your bundle ID project settings. 

# User Interface:
* Just build the app and you will see the loading screen while the home list data is being fetched from the API. 
* After the successful data retrieval, ten launches are shown. 
* In case of any error an alert is presented (turn the internet off and restart the app or try to tap a destination to try it out). Of course, this can be done in much more detail if Reachability class is used, but it would go outside of scope of this test project and it was mentioned to avoid 3rd party libs or other solutions. 
* Everything you see in this project is custom made, so nothing has been copied or used from some other source. 
* To see the launch details tap on the cell and Details Screen will appear.
*  When tapping on the map, another screen will appear where the url of the map will be opened in the web view
* Turn the internet off, the app will still function.
* On the main screen you can filter the list based on any of the 4 labels (their text)

# Architecture:
* MMVM-C is used as an app design pattern since it complements Apple's native, out of the box, MVC for UIKit and it's new MVVM in SwiftUI. Coordinator takes the role of presenting the application flow (like push, pop etc.).
* Networking module is independent and can be implemented anywhere. It is based on Apple's “URLSession” and generics so no third party libs have been used.
* There is a custom loading screen and alert for the user feedback. 
* Unit tests are made for view models and moc JSON of products list and details, they are just examples
* Reusable components have been made (like imageview) for illustration purposes. 
* Sample unit test have been made to see the approach, of course it is much more testable. 
* File organisation: 
    * App - App related data 
     *Models
    * Views
    * ViewControllers
    * ViewModels
    * Lib - all custom made libraries with the main one being the networking module under “Networking” 
    * Resources - storyboards, strings, images



