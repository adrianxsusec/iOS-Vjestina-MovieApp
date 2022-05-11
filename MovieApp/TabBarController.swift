import Foundation
import UIKit
import SnapKit
import Network

class TabBarController: UITabBarController {
    
    var movieListViewController: MovieListViewController!
    public var movieNavigationController: MovieNavigationController!
    var favoritesNavigationController: MovieNavigationController!
    var favoritesViewController: FavoritesViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let monitor = NWPathMonitor()
        
        var isConnectedToInternet: Bool!
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected to internet!")
                isConnectedToInternet = true
            } else {
                print("No connection")
                isConnectedToInternet = false
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        while isConnectedToInternet == nil {
        }
        
        if (isConnectedToInternet) {
            movieListViewController = MovieListViewController()
            movieNavigationController = MovieNavigationController(rootViewController: movieListViewController)
            favoritesViewController = FavoritesViewController()
            favoritesNavigationController = MovieNavigationController(rootViewController: favoritesViewController)

            
            movieNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"),
                                                                selectedImage: UIImage(systemName: "house.fill"))
            favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"),
                                                                selectedImage: UIImage(systemName: "heart.fill"))
            
            viewControllers = [movieNavigationController, favoritesNavigationController]
            
        } else {
            let noInternetViewController = ErrorViewController()
            viewControllers = [noInternetViewController]
        }
        
        
    }
    
}
