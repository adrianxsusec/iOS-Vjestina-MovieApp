import Foundation
import SnapKit
import UIKit
import MovieAppData

class GridMovieCell: UITableViewCell {
    
    var group = UILabel()
    var filters = FilterView()
    var moviesLayout = UICollectionViewFlowLayout()
    var movies: UICollectionView!
    //var moviesGroup: [MovieModel] = []
    var moviesInCategory: [Movie] = []
    
    var navController: UIViewController!
    
    let cellIdentifier = "cellId"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        moviesLayout.scrollDirection = .horizontal
        moviesLayout.minimumInteritemSpacing = 15
        
        movies = UICollectionView(
            frame: .zero,
                collectionViewLayout: moviesLayout)
        
        movies.register(GridMovieSubcell.self, forCellWithReuseIdentifier: cellIdentifier)
        movies.dataSource = self
        movies.delegate = self
        
        movies.isScrollEnabled = true
        //movies.isPagingEnabled = true
        
        movies.showsHorizontalScrollIndicator = false
        movies.showsVerticalScrollIndicator = false
        
        self.contentView.addSubview(filters)
        contentView.addSubview(group)
        contentView.addSubview(movies)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func fillWithContent(_ groupName: String, _ filterNames: [String], _ movieList: [MovieModel]) {
//
//        moviesGroup = movieList
//
//        group.text = groupName
//        group.font = UIFont(name: "ProximaNova-Bold", size: 22)
//        group.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
//
//        setFilters(filterNames)
//        createConstraints()
//
//    }
    
    func setNavController(_ vc: UIViewController) {
        self.navController = vc
    }
    
    func fillWithContent(_ groupName: String, _ filterNames: [String], _ movieList: [Movie]) {
        
        moviesInCategory = movieList
        
        group.text = groupName
        group.font = UIFont(name: "ProximaNova-Bold", size: 22)
        group.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        
        setFilters(filterNames)
        createConstraints()
        
    }
    
    func setFilters(_ filterNames: [String]) {
        filters.fetchFilters(filterNames)
    }
    
    func createConstraints () {
        
        group.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
        }

        filters.snp.makeConstraints {
            $0.top.equalTo(group.snp.bottom).offset(10)
            $0.leading.equalTo(group)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(25)
        }

        movies.snp.makeConstraints {
            $0.top.equalTo(filters.snp.bottom).offset(8)
            $0.leading.equalTo(filters)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}

extension GridMovieCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesInCategory.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movies.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GridMovieSubcell
        
        //cell.fillWithContent(moviesGroup[indexPath.row])
        
        cell.fillWithContent(moviesInCategory[indexPath.row])
        
        cell.setNavController(navController)
        
        return cell
    }

}

extension GridMovieCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
            CGSize(width: 120, height: 180)
    }
    
}
    
extension GridMovieCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsViewController()
        movieDetailsVC.setMovieForDisplay(moviesInCategory[indexPath.row])
        navController.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}




