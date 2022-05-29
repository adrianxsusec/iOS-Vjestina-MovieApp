import Foundation
import SnapKit
import UIKit

class FavoritesViewController: UIViewController {
    
    let cellIdentifier = "cellId"
    var favoriteMoviesViewModel: [MovieViewModel] = []
    var favoritesLayout = FavoritesFlowLayout(
        cellsPerRow: 3, minimumInteritemSpacing: 5,
        minimumLineSpacing: 5,
        sectionInset: UIEdgeInsets(
            top: 5, left: 5, bottom: 5, right: 5))
    var favorites: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let moviesRepository = MoviesRepository()
        favoriteMoviesViewModel = moviesRepository.getFavoriteMovies()
    
        navBarAppearance()
        
        favoritesLayout.scrollDirection = .vertical
        favoritesLayout.minimumInteritemSpacing = 15
        
        favorites = UICollectionView(
            frame: .zero,
                collectionViewLayout: favoritesLayout)
        
        favorites.register(GridMovieSubcell.self, forCellWithReuseIdentifier: cellIdentifier)
        favorites.dataSource = self
        favorites.delegate = self
        
        favorites.isScrollEnabled = true
        
        favorites.showsHorizontalScrollIndicator = false
        favorites.showsVerticalScrollIndicator = false
        
        favorites.collectionViewLayout = favoritesLayout
        
        
        
    }
    
    func navBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        let titleItem = UIImageView(image: UIImage(named: "tmdbtitleview.pdf"))
        navigationItem.titleView = titleItem
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteMoviesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GridMovieSubcell
        
        cell.backgroundColor = .systemOrange
        
        return cell
        
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegate {
    
}
