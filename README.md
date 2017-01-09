# MoviesMobileApp

This first version (MVP) of the app will be very simple and limited to show the list of upcoming movies.

 - Scroll through the list of upcoming movies - including movie name, poster or backdrop image, genre and release date.
 - Select a specific movie to see details (name, poster image, genre, overview and release date).
 - Search for movies by entering a partial or full movie name.
 - I used the The Movie Database API.

Build instructions:
 - Projects uses CocoaPods to deal with dependencies (https://cocoapods.org/)

 - Deployment Target: iOS 10.0

 - Language: Swift 3

 - IDE: xCode8

Third Party Libraries used:

 - Alamofire (https://github.com/Alamofire/Alamofire) - HTTP Networking for Swift
 - RxSwift and RxCocoa (https://github.com/ReactiveX/RxSwift) - Reactive Programming Framework for Swift. I prefer to deal with service in a Reactive aproach because it deal perfectly with asynchronous operations and event/data streams. 
 - AlamofireImage (https://github.com/Alamofire/AlamofireImage) - AlamofireImage is an image component library for Alamofire