# WorkSpaceAR
A tool which enables the user to customize a virtual workspace using their smartphone and AR technology. Place work screens throughout an AR room and display browser applications to improve tasks which require multiple views at once.

## Design 
    
## Features
 * Users can:
     - Manipulate and move the placements of the screens
     - Increment and decrement the number of screens
     - Interact with the web applications open on those screens
 * Users view:
     - The screens that they places
     - The content of each applications running in the screens and their interactions with them
 * We have to get the notifications show up on outside of all the browsers, if they have slack way in the back and not looking, it's important that no matter what view they're looking at they'll get a notification of a message sent. 
     
## Techniques and Procedures
 * A/B testing: 
    * There will be a need to do some A/B testing. The good thing is that we can narrow the A/B testing to 2 different ideas: 
    * (Recommended) One screen at time, where the user will look at a screen and if they have multiple screens then the side of the screens will be visible for them to see, and when they look one side it will trigger the view to be of the other screen.  **Complex Part** We will need to be precise with the user looking at one view to another based on the movement of their head
    * Players will be able to manipulate all the screens into their view and pull one closer to the view of their interest. So it looks like the link you sent me where they can look at all the screens at the same time, then in their AR view they can bring one screen closer to them than the others. **Complex Part** Won't be as difficult. However I believe it'll be tough to move the screens to their liking, maybe with their hands or mouse. 
    
 * Designed for iOS using Swift and Xcode 11 GM seed
 
 ## Resources


## Questions
To James:
1. Is your code running? Mine will build and then I get several warning:
    *** Terminating app due to uncaught exception 'NSInvalidUnarchiveOperationException', reason: 'Could not instantiate class named WKWebView because no class named WKWebView was found; the class needs to be defined in source code or linked in from a library (ensure the class is part of the correct target)'
2. Will we need to build screen objects using SceneKit?
