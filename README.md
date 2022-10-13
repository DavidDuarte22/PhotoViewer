# PhotoViewer
A simple app to implement concepts using Viper with Swift for iOS 13 and more.

Using https://www.pexels.com/ API to fetch photos

You can add your api key in the ServiceBuilder inside the Environents folder

Objetives: 
- Architecture: Implement modularized Viper architecture tested.
- Use different UIKit resources: UICollectionView, UITableView, UITabBar, UINavigationController, and more.
- Use different storage solutions: UserDefaults, CoreData.
- Any other good practice that could be interested to share.



13-10-2022: Review after 1 year. 
TODO: 
    UX - UI:
    - Implement error handling
    - Improve UX: low connection and offline flow
    - Collection header to select other categories [new feature]
    - Make bigger loading in Photo's detail
    
    Code: (The app has the TODO Mark. Here is just the main ideas to consider)
    - Modularize tabBar submodules 
    - Implement Auth and token in keychain
    - Offline mode: Favorites with Realm
    - Reconsidering folder structure to scale the app to an iPad/MacOS/WatchOS app
    
    Tests: 
    - Consider mock data for UI Tests

