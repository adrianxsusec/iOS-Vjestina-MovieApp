import Foundation
import SnapKit
import UIKit
import MovieAppData

class GridMovieCell: UITableViewCell {
    
    var group = UILabel()
    var filters = FilterView()
    var moviesLayout = UICollectionViewFlowLayout()
    var movies: UICollectionView!
    var moviesGroup: [MovieModel] = []
    
    let cellIdentifier = "cellId"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        moviesLayout.scrollDirection = .horizontal
        moviesLayout.minimumInteritemSpacing = 15
        
        movies = UICollectionView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: self.bounds.width,
                    height: self.bounds.height),
                collectionViewLayout: moviesLayout)
        movies.frame = .zero
        
        movies.register(GridMovieSubcell.self, forCellWithReuseIdentifier: cellIdentifier)
        movies.dataSource = self
        
        movies.isScrollEnabled = true
        movies.isPagingEnabled = true
        
        self.contentView.addSubview(filters)
        contentView.addSubview(group)
        contentView.addSubview(movies)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillWithContent(_ groupName: String, _ filterNames: [String], _ movieList: [MovieModel]) {
        
        moviesGroup = movieList
        
        group.text = groupName
        group.font = .boldSystemFont(ofSize: 28)
        
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
            $0.top.equalTo(group.snp.bottom).offset(20)
            $0.leading.equalTo(group)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(5)
        }

        movies.snp.makeConstraints {
            $0.top.equalTo(filters.snp.bottom).offset(10)
            $0.leading.equalTo(filters)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}

extension GridMovieCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesGroup.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = movies.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GridMovieSubcell
        
        cell.fillWithContent(moviesGroup[indexPath.row])
        
        return cell
    }

}

extension GridMovieSubcell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)
        -> CGSize {
            CGSize(width: 100, height: 160)
    }
    
}
    




